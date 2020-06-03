tableextension 5272722 "LBT Sales Cr.Memo Line" extends "Sales Cr.Memo Line"
{

    fields
    {
        field(5272720; "LBT Long Text"; Boolean)
        {
            CalcFormula = Exist ("LBT Posted PS Longtext Line" WHERE("Table ID" = CONST(115),
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
        }
        field(5272722; "LBT Summation"; Text[250])
        {
            Caption = 'Summation';
            TableRelation = "Sales Cr.Memo Line"."Line No." WHERE("Document No." = FIELD("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(5272723; "LBT Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum ("Sales Cr.Memo Line"."Line Amount" WHERE("Document No." = FIELD("Document No."),
                                                                        "Line No." = FIELD(FILTER("LBT Summation"))));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
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
}

