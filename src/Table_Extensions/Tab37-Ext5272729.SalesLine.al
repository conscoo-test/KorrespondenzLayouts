tableextension 5272729 "LBT Sales Line" extends "Sales Line"
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
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                if (Type <> Type::" ") and
                   (Quantity <> 0)
                 then
                    if ("LBT Printoption" = "LBT Printoption"::Alternative) or
                      ("LBT Printoption" = "LBT Printoption"::Optional)
                    then
                        ERROR(Text5272721, FIELDCAPTION(Quantity), FIELDCAPTION("LBT Printoption"), "LBT Printoption");
            end;
        }
        field(5272720; "LBT Long Text"; Boolean)
        {
            CalcFormula = Exist ("LBT PS Longtext Line" WHERE ("Table ID" = CONST (37),
                                                                "Document Type" = FIELD ("Document Type"),
                                                                "Document No." = FIELD ("Document No."),
                                                                Position = CONST (Longtext),
                                                                "Document Line No." = FIELD ("Line No.")));
            Caption = 'Long Text', Comment = 'DEU="Langtext"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5272721; "LBT Printoption"; Option)
        {
            Caption = 'Printoption', Comment = 'DEU="Druckauswahl"';
            OptionCaption = 'Standard,Title,,Price Invisible,Line Invisible,Alternative,Optional,New Page,Begin Total,End Total', Comment = 'DEU="Normal,Überschrift,,Preis unsichtbar,Zeile unsichtbar,Alternativposition,Bedarfsposition,Seitenwechsel,Von Summe,Bis Summe"';
            OptionMembers = Standard,Title,,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total";

            trigger OnValidate()
            var
                Printoption: Option Standard,Title,,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total";
                LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
            begin
                if ("Printoption" = "Printoption"::Alternative) or
                  ("Printoption" = "Printoption"::Optional)
                then begin
                    VALIDATE(Quantity, 0);
                    VALIDATE("Unit Price");
                end;

                if "Printoption" = "Printoption"::"New Page" then begin
                    if "No." <> '' then
                        ERROR(Text5272722);
                    Printoption := "Printoption";
                    VALIDATE(Type, Type::" ");
                    Description := Text5272723;
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

                "LBT Printoption StyleExpr" := LeBitCorrespDocMgt.GetStyleExpr("Printoption");
            end;
        }
        field(5272722; "LBT Summation"; Text[250])
        {
            Caption = 'Summation', Comment = 'DEU="Zusammenzählung"';
            TableRelation = "Sales Line"."Line No." WHERE ("Document Type" = FIELD ("Document Type"),
                                                           "Document No." = FIELD ("Document No."));
            ValidateTableRelation = false;

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
            CalcFormula = Sum ("Sales Line"."Line Amount" WHERE ("Document Type" = FIELD ("Document Type"),
                                                                "Document No." = FIELD ("Document No."),
                                                                "Line No." = FIELD (FILTER ("LBT Summation"))));
            Caption = 'Balance', Comment = 'DEU="Saldo"';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Sales Line"."Line No." WHERE ("Document Type" = FIELD ("Document Type"),
                                                           "Document No." = FIELD ("Document No."));
        }
        field(5272724; "LBT Pos. No."; Text[30])
        {
            Caption = 'Pos.No.', Comment = 'DEU="Positionsnummer"';
        }
        field(5272725; "LBT Indentation"; Integer)
        {
            Caption = 'Indentation', Comment = 'DEU="Einrückung"';
            MinValue = 0;
        }
        field(5272726; "LBT Source Document Line No."; Integer)
        {
            Caption = 'Source Document Line No.', Comment = 'DEU="Herkunft Belegzeilennummer"';
        }
        field(5272727; "LBT Printoption StyleExpr"; Text[30])
        {
            Caption = 'LBT Printoption StyleExpr', Comment = 'DEU="Druckauswahl StyleExpr"';
            DataClassification = ToBeClassified;
        }
    }

    trigger OnDelete()
    var
        SourceRecRef: RecordRef;
        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
    begin
        SourceRecRef.GETTABLE(Rec);
        LeBitLongtextMgt.DelLongtext(SourceRecRef);
    end;

    var
        Text5272720: Label 'If type is %1 then you only can use printoption "Total" and "Line Invisible".', Comment = 'DEU="Bei Art "%1" kann bei Druckauswahl nur "Summe" und "Zeile unsichtbar" genutzt werden."';
        Text5272721: Label 'If type is %1 then you only can use printoption "Title" and "Line Invisible".', Comment = 'DEU="Bei Art "%1" kann bei Druckauswahl nur "Überschrift" und "Zeile unsichtbar" genutzt werden."';
        Text5272722: Label 'New Pages can only be set in blank lines.', Comment = 'DEU="Seitenwechsel können nur in leeren Zeilen vereinbart werden."';
        Text5272723: Label '--- New Page ---', Comment = 'DEU=">--- Seitenwechsel ---"';
        Text5272724: Label 'Begin Total', Comment = 'DEU="Von Summe"';
        Text5272725: Label 'End Total', Comment = 'DEU="Bis Summe"';
}

