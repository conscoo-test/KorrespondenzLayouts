tableextension 5272729 "lbt Sales Line" extends "Sales Line"
{
    fields
    {
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                lbtclSetUnitPrice(FieldNo("Unit Price"));
            end;
        }
        field(5272720; "lbt Long Text"; Boolean)
        {
            CalcFormula = exist("lbt PS Longtext Line" where("Table ID" = const(37),
                                                                "Document Type" = field("Document Type"),
                                                                "Document No." = field("Document No."),
                                                                Position = const(Longtext),
                                                                "Document Line No." = field("Line No.")));
            Caption = 'Long Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5272721; "lbt Printoption"; Enum "lbt cl Printoption")
        {
            Caption = 'Printoption';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                _Description: Text[100];
            begin
                if (Rec."lbt Printoption" = Rec."lbt Printoption"::Alternative) or
                  (Rec."lbt Printoption" = Rec."lbt Printoption"::Optional)
                then begin
                    Validate(Quantity, 0);
                    Validate("Unit Price");
                end;

                if Rec."lbt Printoption" = Rec."lbt Printoption"::"New Page" then begin
                    if "No." <> '' then
                        Error(NewPageErr);
                    // PrintOption := Rec."lbt Printoption";
                    Validate(Type, Type::" ");
                    Description := NewPageLbl;
                    // Rec."lbt Printoption" := PrintOption;
                end;

                if Rec."lbt Printoption" in [Rec."lbt Printoption"::"Begin Total",
                                           Rec."lbt Printoption"::"End Total",
                                           Rec."lbt Printoption"::Title]
                then begin
                    // Rec."lbt Printoption" := Rec."lbt Printoption";
                    _Description := Rec.Description;
                    Validate(Type, Type::" ");
                    Validate(Description, _Description);
                    // Rec."lbt Printoption" := Rec."lbt Printoption";
                end;
            end;
        }
        field(5272722; "lbt Summation"; Text[250])
        {
            Caption = 'Summation';
            TableRelation = "Sales Line"."Line No." where("Document Type" = field("Document Type"),
                                                           "Document No." = field("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "lbt Printoption" <> "lbt Printoption"::"End Total" then
                    FieldError("lbt Printoption");
                CalcFields("lbt Balance");
            end;
        }
        field(5272723; "lbt Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                "Document No." = field("Document No."),
                                                                "Line No." = field(filter("lbt Summation")),
                                                                "lbt Printoption" = filter(<> Alternative & <> Optional)));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Sales Line"."Line No." where("Document Type" = field("Document Type"),
                                                           "Document No." = field("Document No."));
        }
        field(5272724; "lbt Pos. No."; Text[30])
        {
            Caption = 'Pos.No.';
            DataClassification = CustomerContent;
        }
        field(5272725; "lbt Indentation"; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(5272726; "lbt Source Document Line No."; Integer)
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Removed';
            Caption = 'Source Document Line No.';
            DataClassification = CustomerContent;
        }
        field(5272727; "lbt Printoption StyleExpr"; Text[30])
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Removed';
            Caption = 'lbt Printoption StyleExpr';
            DataClassification = CustomerContent;
        }
        field(5272728; "lbt from Standard Sales Line"; Guid)
        {
            ObsoleteReason = 'Removed, no longer needed.';
            ObsoleteState = Pending;
            ObsoleteTag = '2024-04-22';
            Caption = 'From Standard Sales Line';
            DataClassification = CustomerContent;
        }
        field(5272729; "lbt cl Delivery Date Type"; Enum "lbt cl DeliveryDateType")
        {
            Caption = 'Delivery Date Type';
            DataClassification = CustomerContent;
        }
        field(5272730; "lbt cl Price Factor"; Enum "lbt cl Price Factor")
        {
            Caption = 'Price Factor';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                lbtclSetUnitPrice(FieldNo("lbt cl Price Factor"));
            end;
        }
        field(5272731; "lbt cl Price in Price Factor"; Decimal)
        {
            Caption = 'Unit Price in Price Factor';
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FieldNo("lbt cl Price in Price Factor"));
            trigger OnValidate()
            begin
                lbtclSetUnitPrice(FieldNo("lbt cl Price in Price Factor"));
            end;
        }
        field(5272732; "lbt Special Qty"; Decimal)
        {
            Caption = 'Special Quantity';
            DataClassification = CustomerContent;
        }
    }

    trigger OnDelete()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(Rec);
    end;

    var
        EditorHelper: Codeunit "lbt cl EditorHelper";
        NewPageErr: Label 'New Pages can only be set in blank lines.';
        NewPageLbl: Label '--- New Page ---';

    ///H22/0437
    procedure lbtclSetUnitPrice(CurrentFieldNo: Integer)
    var
        CorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";

    begin
        case CurrentFieldNo of
            FieldNo("lbt cl Price in Price Factor"):
                Validate("Unit Price", "lbt cl Price in Price Factor" / CorrespDocMgt.GetPriceFactor("lbt cl Price Factor"));
            FieldNo("Unit Price"), FieldNo("lbt cl Price Factor"):
                "lbt cl Price in Price Factor" := "Unit Price" * CorrespDocMgt.GetPriceFactor("lbt cl Price Factor");
        end;
    end;

    procedure lbtEditData(doctype: Integer)
    var

    begin
        EditorHelper.editData(Rec, Enum::"lbt Position"::EditorLine, doctype);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, docType));
    end;

    procedure lbtHasEditorValue(docType: Integer) Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(Rec, Enum::"lbt Position"::EditorLine, docType));
    end;
}
