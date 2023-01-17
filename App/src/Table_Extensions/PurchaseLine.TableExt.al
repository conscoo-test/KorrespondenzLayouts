tableextension 5272731 "lbt Purchase Line" extends "Purchase Line"
{
    fields
    {
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                lbtclSetUnitPrice(FieldNo("Direct Unit Cost"));
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                Validate("lbt Printoption", xRec."lbt Printoption");
                "lbt Pos. No." := xRec."lbt Pos. No.";
            end;
        }
        field(5272720; "lbt Long Text"; Boolean)
        {
            CalcFormula = exist("lbt PS Longtext Line" where("Table ID" = const(39),
                                                                "Document Type" = field("Document Type"),
                                                                "Document No." = field("Document No."),
                                                                Position = const(Longtext),
                                                                "Document Line No." = field("Line No.")));
            Caption = 'Long Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5272721; "lbt Printoption"; Option)
        {
            Caption = 'Printoption';
            OptionCaption = 'Standard,Title,Total,Price Invisible,Line Invisible,Alternative,Optional,New Page,Begin Total,End Total';
            OptionMembers = Standard,Title,Total,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("lbt Printoption" = "lbt Printoption"::Alternative) or ("lbt Printoption" = "lbt Printoption"::Optional) then begin
                    Validate(Quantity, 0);
                    Validate("Direct Unit Cost");
                end;

                if "lbt Printoption" = "lbt Printoption"::"New Page" then begin
                    if "No." <> '' then
                        Error(NewPageErr);
                    Validate(Type, Type::" ");
                    Description := NewPageLbl;
                end;
            end;
        }
        field(5272722; "lbt Summation"; Text[250])
        {
            Caption = 'Summation';
            TableRelation = "Purchase Line"."Line No." where("Document Type" = field("Document Type"),
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
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                    "Document No." = field("Document No."),
                                                                    "Line No." = field(filter("lbt Summation")),
                                                                    "lbt Printoption" = filter(<> Alternative & <> Optional)));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Purchase Line"."Line No." where("Document Type" = field("Document Type"),
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
            Caption = 'Printoption StyleExpr';
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
        PrintOptionTypeMismatchErr: Label 'If Type is %1 then you can only use printoptions "%2" and "%3"', Comment = '%1 - Type, %2 - Printoption, %3 - Printoption';

    procedure lbtclSetUnitPrice(CurrentFieldNo: Integer)
    var
        CorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";

    begin
        case CurrentFieldNo of
            FieldNo("lbt cl Price in Price Factor"):
                Validate("Direct Unit Cost", "lbt cl Price in Price Factor" / CorrespDocMgt.GetPriceFactor("lbt cl Price Factor"));
            FieldNo("Direct Unit Cost"), FieldNo("lbt cl Price Factor"):
                "lbt cl Price in Price Factor" := "Direct Unit Cost" * CorrespDocMgt.GetPriceFactor("lbt cl Price Factor");
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
