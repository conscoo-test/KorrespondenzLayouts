pageextension 5272838 "lbt cl CustomerCard" extends "Customer Card"
{
    layout
    {
        addlast(Shipping)
        {

            field("lbt cl Delivery Date Type"; Rec."lbt cl Delivery Date Type")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you define the Delivery Date Type.';
            }
        }
    }
}
