tableextension 5272731 "lbt Purchase Line" extends "Purchase Line"
{
    fields
    {
        modify(Type)
        {
            trigger OnAfterValidate()
            begin
                if Type <> Type::" " then begin
                    if "lbt Printoption" in ["lbt Printoption"::"Begin Total",
                                                   "lbt Printoption"::"End Total",
                                                   "lbt Printoption"::Title,
                                                   "lbt Printoption"::"New Page"]
                    then
                        VALIDATE("lbt Printoption", "lbt Printoption"::Standard);
                end else
                    if "lbt Printoption" <> "lbt Printoption"::"New Page" then
                        VALIDATE("lbt Printoption", "lbt Printoption"::Standard);
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
            Caption = 'Long Text', Comment = 'DEU="Langtext"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5272721; "lbt Printoption"; Option)
        {
            Caption = 'Printoption', Comment = 'DEU="Druckauswahl"';
            OptionCaption = 'Standard,Title,,Price Invisible,Line Invisible,Alternative,Optional,New Page,Begin Total,End Total', Comment = 'DEU="Normal,Überschrift,,Preis unsichtbar,Zeile unsichtbar,Alternativposition,Bedarfsposition,Seitenwechsel,Von Summe,Bis Summe"';
            OptionMembers = Standard,Title,,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
                Printoption: Integer;
            begin
                if ("lbt Printoption" = "lbt Printoption"::Alternative) or ("lbt Printoption" = "lbt Printoption"::Optional) then begin
                    VALIDATE(Quantity, 0);
                    VALIDATE("Direct Unit Cost");
                end;

                if "lbt Printoption" = "lbt Printoption"::"New Page" then begin
                    if "No." <> '' then
                        ERROR(NewPageErr);
                    Printoption := "lbt Printoption";
                    VALIDATE(Type, Type::" ");
                    Description := NewPageLbl;
                    "lbt Printoption" := Printoption;
                end;

                if "lbt Printoption" in ["lbt Printoption"::"Begin Total",
                                           "lbt Printoption"::"End Total",
                                           "lbt Printoption"::Title]
                then begin
                    Printoption := "lbt Printoption";
                    VALIDATE(Type, Type::" ");
                    "lbt Printoption" := Printoption;
                end;

                "lbt Printoption StyleExpr" := LeBitCorrespDocMgt.GetStyleExpr("lbt Printoption");
            end;
        }
        field(5272722; "lbt Summation"; Text[250])
        {
            Caption = 'Summation', Comment = 'DEU="Zusammenzählung"';
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                              "Document No." = FIELD("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Type <> 9 then
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
            Caption = 'Balance', Comment = 'DEU="Saldo"';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                              "Document No." = FIELD("Document No."));
        }
        field(5272724; "lbt Pos. No."; Text[30])
        {
            Caption = 'Pos.No.', Comment = 'DEU="Positionsnummer"';
            DataClassification = CustomerContent;
        }
        field(5272725; "lbt Indentation"; Integer)
        {
            Caption = 'Indentation', Comment = 'DEU="Einrückung"';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(5272726; "lbt Source Document Line No."; Integer)
        {
            Caption = 'Source Document Line No.', Comment = 'DEU="Herkunft Belegzeilennummer"';
            DataClassification = CustomerContent;
        }
        field(5272727; "lbt Printoption StyleExpr"; Text[30])
        {
            Caption = 'lbt Printoption StyleExpr', Comment = 'DEU="Druckauswahl StyleExpr"';
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
        NewPageErr: Label 'New Pages can only be set in blank lines.', Comment = 'DEU="Seitenwechsel können nur in leeren Zeilen vereinbart werden."';
        NewPageLbl: Label '--- New Page ---', Comment = 'DEU="--- Seitenwechsel ---"';
}

