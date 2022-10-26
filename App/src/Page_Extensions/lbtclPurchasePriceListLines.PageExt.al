pageextension 5272847 "lbtcl PurchasePriceListLines" extends "Purchase Price List Lines"
{
    layout
    {
        addafter(DirectUnitCost)
        {

            field("lbt cl Price Factor"; Rec."lbt cl Price Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you Enter the Price Factor.';
            }
            field("lbt cl Price in Price Factor"; Rec."lbt cl Price in Price Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you enter the Price in Price Factor.';
            }
        }
    }
}
