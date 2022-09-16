pageextension 5272839 "lbt cl Ship-to-Address" extends "Ship-to Address"
{
    layout
    {
        addlast(General)
        {
            field("lbt cl Delivery Date Type"; Rec."lbt cl Delivery Date Type")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you enter the Delivery Date Type.';
            }
            field("lbt cl Destination"; Rec."lbt cl Destination")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you define the Destination.';
            }
        }
    }
}
