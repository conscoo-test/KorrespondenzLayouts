pageextension 5272768 "LBT Sales Return Order Archive" extends "Sales Return Order Archive"
{
    // version NAVW111.00.00.19846,LBCOR1.00

    actions
    {
        addafter("Ver&sion")
        {
            group("LBT correspondence documents")
            {
                Caption = 'LeBit365 Correspondence layout';
                action("LBT Header Text")
                {
                    ToolTip = 'Here you can define the Header Text.';
                    ApplicationArea = All;
                    Caption = 'Header Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
                    end;
                }
                action("LBT &Footer Text")
                {
                    ToolTip = 'Here you can define the Footer Text.';
                    ApplicationArea = All;
                    Caption = '&Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
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

