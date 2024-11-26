pageextension 5272737 "lbt Posted Purchase Invoices" extends "Posted Purchase Invoices"
{
    actions
    {
        addafter("&Invoice")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit Extended Layout Options';
                action("lbt Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text';
                    ToolTip = 'Specifies the Header Text';
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
                    ToolTip = 'Specifies the Footer Text';
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
