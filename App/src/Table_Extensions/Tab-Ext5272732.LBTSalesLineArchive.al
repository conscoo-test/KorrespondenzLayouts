tableextension 5272732 "LBT Sales Line Archive" extends "Sales Line Archive"
{
    fields
    {


        field(5272720; "LBT Long Text"; Boolean)
        {
            CalcFormula = Exist ("LBT Archive PS Longtext Line" WHERE ("Table ID" = CONST (5108),
                                                                        "Document Type" = FIELD ("Document Type"),
                                                                        "Document No." = FIELD ("Document No."),
                                                                        Position = CONST (Longtext),
                                                                        "Document Line No." = FIELD ("Line No."),
                                                                        "Version No." = FIELD ("Version No."),
                                                                        "Doc. No. Occurrence" = FIELD ("Doc. No. Occurrence")));
            Caption = 'Long Text', Comment = 'DEU=""';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5272721; "LBT Printoption"; Option)
        {
            Caption = 'Printoption', Comment = 'DEU="Druckauswahl"';
            OptionCaption = 'Standard,Title,,Price Invisible,Line Invisible,Alternative,Optional,New Page,Begin Total,End Total', Comment = 'DEU="Normal,Überschrift,,Preis unsichtbar,Zeile unsichtbar,Alternativposition,Bedarfsposition,Seitenwechsel,Von Summe,Bis Summe"';
            OptionMembers = Standard,Title,,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total";
        }
        field(5272722; "LBT Summation"; Text[250])
        {
            Caption = 'Summation', Comment = 'DEU="Zusammenzählung"';
            TableRelation = "Sales Line Archive"."Line No." WHERE ("Document Type" = FIELD ("Document Type"),
                                                                   "Document No." = FIELD ("Document No."));
            ValidateTableRelation = false;
        }
        field(5272723; "LBT Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum ("Sales Line Archive"."Line Amount" WHERE ("Document Type" = FIELD ("Document Type"),
                                                                        "Document No." = FIELD ("Document No."),
                                                                        "Doc. No. Occurrence" = FIELD ("Doc. No. Occurrence"),
                                                                        "Version No." = FIELD ("Version No."),
                                                                        "Line No." = FIELD (FILTER ("LBT Summation"))));
            Caption = 'Balance', Comment = 'DEU="aldo"';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Sales Line Archive"."Line No." WHERE ("Document Type" = FIELD ("Document Type"),
                                                                   "Document No." = FIELD ("Document No."));
        }
        field(5272724; "LBT Pos. No."; Text[30])
        {
            Caption = 'Pos.No.', Comment = 'DEU="Positionsnummer"';
        }
        field(5272725; "LBT Indentation"; Integer)
        {
            Caption = 'Indentation', Comment = 'DEU="Einrückung"';
            DataClassification = ToBeClassified;
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
}

