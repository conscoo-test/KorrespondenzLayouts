pageextension 5272761 "lbt Purchase Quote Archive" extends "Purchase Quote Archive"
{
    actions
    {
        addafter("Ver&sion")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit365 Correspondence layout';
                action("lbt Header Text")
                {
                    ToolTip = 'Here you can define the Header Text.';
                    ApplicationArea = All;
                    Caption = 'Header Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
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
                        LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Footer);
                    end;
                }
            }
        }
    }
}

