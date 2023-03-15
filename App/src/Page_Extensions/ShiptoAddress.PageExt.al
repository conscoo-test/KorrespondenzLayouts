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
    actions
    {
        addafter("&Address")
        {
            action("lbt cl LongTexts")
            {
                Caption = 'Header and footer';
                Image = BeginningText;
                ApplicationArea = All;
                RunObject = page "lbt cl Longtext SysId";
                RunPageLink = "Source System Id" = field(SystemId), "Table Id" = const(222);
            }
        }

    }
}
