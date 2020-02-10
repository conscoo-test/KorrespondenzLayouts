tableextension 5272733 "lbt Purchase Line Archive" extends "Purchase Line Archive"
{
    fields
    {
        field(5272720; "lbt Long Text"; Boolean)
        {
            CalcFormula = Exist ("lbt Archive PS Longtext Line" WHERE("Table ID" = CONST(5110),
                                                                        "Document Type" = FIELD("Document Type"),
                                                                        "Document No." = FIELD("Document No."),
                                                                        Position = CONST(Longtext),
                                                                        "Document Line No." = FIELD("Line No."),
                                                                        "Version No." = FIELD("Version No."),
                                                                        "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence")));
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
        }
        field(5272722; "lbt Summation"; Text[250])
        {
            Caption = 'Summation', Comment = 'DEU="Zusammenzählung"';
            TableRelation = "Purchase Line Archive"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                                      "Document No." = FIELD("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(5272723; "lbt Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum ("Purchase Line Archive"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                           "Document No." = FIELD("Document No."),
                                                                           "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                                                           "Version No." = FIELD("Version No."),
                                                                           "Line No." = FIELD(FILTER("lbt Summation"))));
            Caption = 'Balance', Comment = 'DEU="Saldo"';
            Editable = false;
            FieldClass = FlowField;
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
}

