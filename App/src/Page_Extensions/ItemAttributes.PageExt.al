pageextension 5272786 "lbt Item Attributes" extends "Item Attributes"
{
    actions
    {
        addafter(ItemAttributeValues)
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit365 Correspondence layout', Comment = 'DEU="LeBit365 Korrespondenzbelege"';
                action("lbt Report - Attribute Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Report - Attribute Setup', Comment = 'DEU="Bericht - Attribute Einrichtung"';
                    ToolTip = 'Allows you to assign attributes to a specific report or area.', comment = 'deu="Hier können Sie Attribute für einen bestimmten Bericht oder Bereiche zuweisen."';
                    Image = Setup;
                    RunObject = Page "lbt Report - Attribute Setup";
                    RunPageView = SORTING("Report-Type", "Report-ID", Position, Priority);
                }
            }
        }
    }
}

