pageextension 5272731 "LBT Posted Purch. Credit Memo" extends "Posted Purchase Credit Memo"
{
    actions
    {
        addafter("&Cr. Memo")
        {
            group("LBT correspondence documents")
            {
                Caption = 'LIS365 Correspondence layout', Comment = 'DEU="LIS365 Korrespondenzbelege"';
                action("LBT Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text', Comment = 'DEU="Kopftext"';
                    ToolTip = 'Specified the Header Text', comment = 'DEU="Legt den Kopftext fest"';
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
                action("LBT Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Footer Text', Comment = 'DEU="Fußtext"';
                    ToolTip = 'Specified the Footer Text', comment = 'DEU="Legt den Fußtext fest"';
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

