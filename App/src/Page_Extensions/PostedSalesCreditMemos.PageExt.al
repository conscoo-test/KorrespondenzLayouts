pageextension 5272735 "lbt Posted Sales Credit Memos" extends "Posted Sales Credit Memos"
{
    actions
    {
        addafter("&Credit Memo")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit365 Correspondence layout';
                action("lbt Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text';
                    ToolTip = 'Specified the Header Text';
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
                    ApplicationArea = All;
                    Caption = 'Footer Text';
                    ToolTip = 'Specified the Footer Text';
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

