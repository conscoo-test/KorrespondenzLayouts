pageextension 5272779 "lbt Purch. Return List Archive" extends "Purchase Return List Archive"
{
    actions
    {
        addafter("<Action1102601000>")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit365 Correspondence layout', Comment = 'DEU="LeBit365 Korrespondenzbelege"';
                action("lbt Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text', Comment = 'DEU="Kopftext"';
                    ToolTip = 'Here you can define the Header Text.', comment = 'deu="Hier können Sie den Kopftext erfassen."';
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
                action("lbt &Footer Text")
                {
                    ApplicationArea = All;
                    Caption = '&Footer Text', Comment = 'DEU="Fußtext"';
                    ToolTip = 'Here you can define the Footer Text.', comment = 'deu="Hier können Sie den Fußtext erfassen."';
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

