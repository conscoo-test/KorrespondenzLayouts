tableextension 5272729 "lbt Sales Line" extends "Sales Line"
{
    fields
    {
        field(5272720; "lbt Long Text"; Boolean)
        {
            CalcFormula = Exist("lbt PS Longtext Line" WHERE("Table ID" = CONST(37),
                                                                "Document Type" = FIELD("Document Type"),
                                                                "Document No." = FIELD("Document No."),
                                                                Position = CONST(Longtext),
                                                                "Document Line No." = FIELD("Line No.")));
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
            var
                Printoption: Option Standard,Title,Total,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total";
                EndTime: Time;
            begin
                if ("Printoption" = "Printoption"::Alternative) or
                  ("Printoption" = "Printoption"::Optional)
                then begin
                    VALIDATE(Quantity, 0);
                    VALIDATE("Unit Price");
                end;

                if "Printoption" = "Printoption"::"New Page" then begin
                    if "No." <> '' then
                        ERROR(NewPageErr);
                    Printoption := "Printoption";
                    VALIDATE(Type, Type::" ");
                    Description := NewPageLbl;
                    "Printoption" := Printoption;
                end;

                if "Printoption" in ["Printoption"::"Begin Total",
                                           "Printoption"::"End Total",
                                           "Printoption"::Title]
                then begin
                    Printoption := "Printoption";
                    VALIDATE(Type, Type::" ");
                    "Printoption" := Printoption;
                end;
            end;
        }
        field(5272722; "lbt Summation"; Text[250])
        {
            Caption = 'Summation';
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                           "Document No." = FIELD("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "lbt Printoption" <> "lbt Printoption"::"End Total" then
                    FIELDERROR("lbt Printoption");
                CALCFIELDS("lbt Balance");
            end;
        }
        field(5272723; "lbt Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                "Document No." = FIELD("Document No."),
                                                                "Line No." = FIELD(FILTER("lbt Summation")),
                                                                "lbt Printoption" = filter(<> Alternative & <> Optional)));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                           "Document No." = FIELD("Document No."));
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

    procedure lbtHasEditorValue(docType: integer) Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(rec, enum::"lbt Position"::EditorLine, doctype));
    end;

    procedure lbtEditData(doctype: integer)
    var

    begin
        EditorHelper.editData(rec, enum::"lbt Position"::EditorLine, doctype);
    end;

    procedure lbtGetPrintData(Position: enum "lbt Position"; docType: integer): Text
    begin
        exit(EditorHelper.getPrintData(rec, Position, docType));
    end;

}

