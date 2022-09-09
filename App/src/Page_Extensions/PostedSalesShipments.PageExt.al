pageextension 5272733 "lbt Posted Sales Shipments" extends "Posted Sales Shipments"
{
    actions
    {
        addafter("&Shipment")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit Extended Layout Options';
                action("lbt Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text';
                    ToolTip = 'Specified the Header Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        Position: Option Header,Footer,Longtext;
                    begin
                        LongtextMgt.ShowLongtextLines(Rec, Position::Header);
                    end;
                }
                action("lbt Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Footer Text';
                    ToolTip = 'Specified the Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        Position: Option Header,Footer,Longtext;
                    begin
                        LongtextMgt.ShowLongtextLines(Rec, Position::Footer);
                    end;
                }
            }
        }
    }
}

