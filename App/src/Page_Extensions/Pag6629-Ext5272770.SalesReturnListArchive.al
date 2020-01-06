pageextension 5272770 "LBT Sales Return List Archive" extends "Sales Return List Archive"
{
    // version NAVW111.00.00.19846,LBCOR1.00

    actions
    {
        addafter("<Action1102601000>")
        {
            group("LBT correspondence documents")
            {
                Caption = 'LIS365 Correspondence layout', Comment = 'DEU="LIS365 Korrespondenzbelege"';
                action("LBT Header Text")
                {
                    ToolTip = 'Here you can define the Header Text.', comment = 'deu="Hier können Sie den Kopftext erfassen."';
                    ApplicationArea = All;
                    Caption = 'Header Text', Comment = 'DEU="Kopftext"';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
                    end;

                }
                action("LBT &Footer Text")
                {
                    ToolTip = 'Here you can define the Footer Text.', comment = 'deu="Hier können Sie den Fußtext erfassen."';
                    ApplicationArea = All;
                    Caption = '&Footer Text', Comment = 'DEU="&Fußtext"';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Footer);
                    end;

                }
            }
        }
    }
}

