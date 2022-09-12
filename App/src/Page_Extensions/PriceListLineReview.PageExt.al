pageextension 5272841 "lbt cl PriceListLineReview" extends "Price List Line Review"
{
    layout
    {
        addafter("Unit Price")
        {

            field("lbt cl Price Factor"; Rec."lbt cl Price Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you Enter the Price Factor.';
            }
            field("lbt cl Price in Price Factor"; Rec."lbt cl Price in Price Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you enter the Unit Price in Price Factor.';
            }
        }
    }
}
