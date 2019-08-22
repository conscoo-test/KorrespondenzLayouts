pageextension 5272786 "LBT Item Attributes" extends "Item Attributes"
{
    actions
    {
        addafter(ItemAttributeValues)
        {
            group("LBT correspondence documents")
            {
                Caption = 'LIS365 Correspondence layout', Comment = 'DEU="LIS365 Korrespondenzbelege"';
                action("LBT Report - Attribute Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Report - Attribute Setup', Comment = 'DEU="Bericht - Attribute Einrichtung"';
                    Image = Setup;
                    RunObject = Page "LBT Report - Attribute Setup";
                    RunPageView = SORTING ("Report-Type", "Report-ID", Position, Priority);
                }
            }
        }
    }
}

