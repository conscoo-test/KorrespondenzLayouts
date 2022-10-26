pageextension 5272848 "lbtcl ReqWorksheet" extends "Req. Worksheet"
{
    layout
    {
        ///H22/0522
        addafter("Direct Unit Cost")
        {
            field("lbt cl Price Factor"; Rec."lbt cl Price Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you enter the Price Factor.';
            }
            field("lbt cl Price in Price Factor"; Rec."lbt cl Price in Price Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you enter the Unit Price in Price Factor.';
            }
        }
    }
}
