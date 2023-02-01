pageextension 5272840 "lbt cl CustomerCard" extends "Customer Card"
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
            field("lbt cl No. Shipm. Note Copies"; Rec."lbt cl No. Shipm. Note Copies")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you define the No. of Shipment note Copies field.';
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
        addafter(CustomerReportSelections)
        {
            action("lbt cl LongTexts")
            {
                Caption = 'Header and footer';
                Image = BeginningText;
                ApplicationArea = All;
                RunObject = page "lbt cl Longtext SysId";
                RunPageLink = "Source System Id" = field(SystemId), "Table Id" = const(18);
            }
        }
        addafter(CustomerReportSelections_Promoted)
        {
            actionref("lbt cl LongTexts_Promoted"; "lbt cl LongTexts") { }
        }
    }
}
