tableextension 5272742 "lbt Prepayment Inv.Line Buffer" extends "Prepayment Inv. Line Buffer"
{
    fields
    {
        field(5272721; "lbt Printoption"; Option)
        {
            OptionMembers = Standard,Title,,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total";
            DataClassification = CustomerContent;
        }
        field(5272722; "lbt Summation"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(5272724; "lbt Pos. No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(5272725; "lbt Indentation"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
}
