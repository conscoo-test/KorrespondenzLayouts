tableextension 5272723 "LBT Purch. Rcpt. Line" extends "Purch. Rcpt. Line"
{

    fields
    {
        field(5272720; "LBT Long Text"; Boolean)
        {
            CalcFormula = Exist ("LBT Posted PS Longtext Line" WHERE ("Table ID" = CONST (121),
                                                                       "Document No." = FIELD ("Document No."),
                                                                       Position = CONST (Longtext),
                                                                       "Document Line No." = FIELD ("Line No.")));
            Caption = 'Long Text', Comment = 'DEU="Langtext"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5272721; "LBT Printoption"; Option)
        {
            Caption = 'Printoption', Comment = 'DEU="Printoption"';
            OptionCaption = 'Standard,Title,,Price Invisible,Line Invisible,Alternative,Optional,New Page,Begin Total,End Total', Comment = 'DEU="Normal,Überschrift,,Preis unsichtbar,Zeile unsichtbar,Alternativposition,Bedarfsposition,Seitenwechsel,Von Summe,Bis Summe"';
            OptionMembers = Standard,Title,,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total";
        }
        field(5272722; "LBT Summation"; Text[250])
        {
            Caption = 'Summation', Comment = 'DEU="Zusammenzählung"';
            TableRelation = "Purch. Rcpt. Line"."Line No." WHERE ("Document No." = FIELD ("Document No."));
            ValidateTableRelation = false;
        }
        field(5272723; "LBT Balance"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance', Comment = 'DEU="Saldo"';
            Editable = false;
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
    trigger OnInsert()
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        LeBitCorrespDocSingleInst: Codeunit "LBT Corresp. Doc. SingleInst";
    begin
        LeBitCorrespDocSingleInst.CopyLongTextForPostDropOrderShipment(PurchRcptHeader, Rec, 1, 1);
    end;
}

