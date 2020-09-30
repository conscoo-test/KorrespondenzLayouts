tableextension 5272731 "lbt Purchase Line" extends "Purchase Line"
{
    fields
    {
        modify(Type)
        {
            trigger OnAfterValidate()
            begin
                case Type of
                    Type::"Begin Total":
                        "lbt Printoption" := "lbt Printoption"::Title;
                    Type::"End Total":
                        "lbt Printoption" := "lbt Printoption"::Total;
                    Type::"Pack Sample":
                        "lbt Printoption" := "lbt Printoption"::Title;
                end;
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                VALIDATE("lbt Printoption", xRec."lbt Printoption");
                "lbt Pos. No." := xRec."lbt Pos. No.";
            end;
        }

        field(5272720; "lbt Long Text"; Boolean)
        {
            CalcFormula = Exist ("lbt PS Longtext Line" WHERE("Table ID" = CONST(39),
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
            OptionCaption = 'Standard,Title,Total,Price Invisible,Line Invisible,Alternative,Optional,New Page';
            OptionMembers = Standard,Title,Total,"Price Invisible","Line Invisible",Alternative,Optional,"New Page";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
            begin
                if ("lbt Printoption" = "lbt Printoption"::Alternative) or ("lbt Printoption" = "lbt Printoption"::Optional) then begin
                    VALIDATE(Quantity, 0);
                    VALIDATE("Direct Unit Cost");
                end;

                if "lbt Printoption" = "lbt Printoption"::"New Page" then begin
                    if "No." <> '' then
                        ERROR(NewPageErr);
                    VALIDATE(Type, Type::" ");
                    Description := NewPageLbl;
                end;

                if "lbt Printoption" = "lbt Printoption"::"Total" then
                    VALIDATE(Type, Type::"End Total");

                if (Type = Type::"Begin Total") and not ("lbt Printoption" in ["lbt Printoption"::Title, "lbt Printoption"::"Line Invisible"]) then
                    Error(PrintOptionTypeMismatchErr, Type, "lbt Printoption"::Title, "lbt Printoption"::"Line Invisible");
                if (Type = Type::"End Total") and not ("lbt Printoption" in ["lbt Printoption"::Total, "lbt Printoption"::"Line Invisible"]) then
                    Error(PrintOptionTypeMismatchErr, Type, "lbt Printoption"::Total, "lbt Printoption"::"Line Invisible");

                "lbt Printoption StyleExpr" := LeBitCorrespDocMgt.GetStyleExpr("lbt Printoption");
            end;
        }
        field(5272722; "lbt Summation"; Text[250])
        {
            Caption = 'Summation';
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                              "Document No." = FIELD("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Type <> Type::"End Total" then
                    FIELDERROR(Type);
                CALCFIELDS("lbt Balance");
            end;
        }
        field(5272723; "lbt Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum ("Purchase Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                   "Document No." = FIELD("Document No."),
                                                                   "Line No." = FIELD(FILTER("lbt Summation"))));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
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
            Caption = 'Source Document Line No.';
            DataClassification = CustomerContent;
        }
        field(5272727; "lbt Printoption StyleExpr"; Text[30])
        {
            Caption = 'lbt Printoption StyleExpr';
            DataClassification = CustomerContent;

        }
    }

    trigger OnDelete()
    var
        LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
        SourceRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(Rec);
        LeBitLongtextMgt.DelLongtext(SourceRecRef);
    end;

    var
        NewPageErr: Label 'New Pages can only be set in blank lines.';
        NewPageLbl: Label '--- New Page ---';
        PrintOptionTypeMismatchErr: Label 'If Type is %1 then you can only use printoptions "%2" and "%3"', Comment = '%1 - Type, %2 - Printoption, %3 - Printoption';
}

