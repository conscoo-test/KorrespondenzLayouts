tableextension 5272731 "LBT Purchase Line" extends "Purchase Line"
{
    fields
    {
        modify(Type)
        {
            trigger OnAfterValidate()
            begin
                if Type <> Type::" " then begin
                    if "LBT Printoption" in ["LBT Printoption"::"Begin Total",
                                                   "LBT Printoption"::"End Total",
                                                   "LBT Printoption"::Title,
                                                   "LBT Printoption"::"New Page"]
                    then
                        VALIDATE("LBT Printoption", "LBT Printoption"::Standard);
                end else
                    if "LBT Printoption" <> "LBT Printoption"::"New Page" then
                        VALIDATE("LBT Printoption", "LBT Printoption"::Standard);
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                VALIDATE("LBT Printoption", xRec."LBT Printoption");
                "LBT Pos. No." := xRec."LBT Pos. No.";
            end;
        }

        field(5272720; "LBT Long Text"; Boolean)
        {
            CalcFormula = Exist ("LBT PS Longtext Line" WHERE("Table ID" = CONST(39),
                                                                "Document Type" = FIELD("Document Type"),
                                                                "Document No." = FIELD("Document No."),
                                                                Position = CONST(Longtext),
                                                                "Document Line No." = FIELD("Line No.")));
            Caption = 'Long Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5272721; "LBT Printoption"; Option)
        {
            Caption = 'Printoption';
            OptionCaption = 'Standard,Title,,Price Invisible,Line Invisible,Alternative,Optional,New Page,Begin Total,End Total';
            OptionMembers = Standard,Title,,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
                Printoption: Integer;
            begin
                if ("LBT Printoption" = "LBT Printoption"::Alternative) or ("LBT Printoption" = "LBT Printoption"::Optional) then begin
                    VALIDATE(Quantity, 0);
                    VALIDATE("Direct Unit Cost");
                end;

                if "LBT Printoption" = "LBT Printoption"::"New Page" then begin
                    if "No." <> '' then
                        ERROR(NewPageErr);
                    Printoption := "LBT Printoption";
                    VALIDATE(Type, Type::" ");
                    Description := NewPageLbl;
                    "LBT Printoption" := Printoption;
                end;

                if "LBT Printoption" in ["LBT Printoption"::"Begin Total",
                                           "LBT Printoption"::"End Total",
                                           "LBT Printoption"::Title]
                then begin
                    Printoption := "LBT Printoption";
                    VALIDATE(Type, Type::" ");
                    "LBT Printoption" := Printoption;
                end;

                "LBT Printoption StyleExpr" := LeBitCorrespDocMgt.GetStyleExpr("LBT Printoption");
            end;
        }
        field(5272722; "LBT Summation"; Text[250])
        {
            Caption = 'Summation';
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                              "Document No." = FIELD("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Type <> 9 then
                    FIELDERROR(Type);
                CALCFIELDS("LBT Balance");
            end;
        }
        field(5272723; "LBT Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum ("Purchase Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                   "Document No." = FIELD("Document No."),
                                                                   "Line No." = FIELD(FILTER("LBT Summation"))));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                              "Document No." = FIELD("Document No."));
        }
        field(5272724; "LBT Pos. No."; Text[30])
        {
            Caption = 'Pos.No.';
            DataClassification = CustomerContent;
        }
        field(5272725; "LBT Indentation"; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(5272726; "LBT Source Document Line No."; Integer)
        {
            Caption = 'Source Document Line No.';
            DataClassification = CustomerContent;
        }
        field(5272727; "LBT Printoption StyleExpr"; Text[30])
        {
            Caption = 'LBT Printoption StyleExpr';
            DataClassification = CustomerContent;

        }
    }

    trigger OnDelete()
    var
        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
        SourceRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(Rec);
        LeBitLongtextMgt.DelLongtext(SourceRecRef);
    end;

    var
        NewPageErr: Label 'New Pages can only be set in blank lines.';
        NewPageLbl: Label '--- New Page ---';
}

