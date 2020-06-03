pageextension 5272786 "LBT Item Attributes" extends "Item Attributes"
{
    actions
    {
        addafter(ItemAttributeValues)
        {
            group("LBT correspondence documents")
            {
                Caption = 'LeBit365 Correspondence layout';
                action("LBT Report - Attribute Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Report - Attribute Setup';
                    ToolTip = 'Allows you to assign attributes to a specific report or area.';
                    Image = Setup;
                    RunObject = Page "LBT Report - Attribute Setup";
                    RunPageView = SORTING("Report-Type", "Report-ID", Position, Priority);
                }
            }
        }
    }
}

