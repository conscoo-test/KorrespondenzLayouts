pageextension 50786 "lbt Item Attributes" extends "Item Attributes"
{
    actions
    {
        addafter(ItemAttributeValues)
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit365 Correspondence layout';
                action("lbt Report - Attribute Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Report - Attribute Setup';
                    ToolTip = 'Allows you to assign attributes to a specific report or area.';
                    Image = Setup;
                    RunObject = Page "lbt Report - Attribute Setup";
                    RunPageView = SORTING("Report-Type", "Report-ID", Position, Priority);
                }
            }
        }
    }
}

