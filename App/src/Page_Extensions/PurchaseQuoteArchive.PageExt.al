pageextension 5272761 "lbt Purchase Quote Archive" extends "Purchase Quote Archive"
{
    actions
    {
        addafter("Ver&sion")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit Extended Layout Options';
                action("lbt Header Text")
                {
                    ToolTip = 'Here you can define the Header Text.';
                    ApplicationArea = All;
                    Caption = 'Header Text';
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
                    ToolTip = 'Here you can define the Footer Text.';
                    ApplicationArea = All;
                    Caption = 'Footer Text';
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

