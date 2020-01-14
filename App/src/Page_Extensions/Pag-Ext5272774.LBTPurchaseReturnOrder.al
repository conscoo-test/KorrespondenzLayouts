pageextension 5272774 "LBT Purchase Return Order" extends "Purchase Return Order"
{
    actions
    {
        addafter("&Return Order")
        {
            group("LBT correspondence documents")
            {
                Caption = 'LIS365 Correspondence layout', Comment = 'DEU="LIS365 Korrespondenzbelege"';
                action("Tot&aling")
                {
                    ApplicationArea = All;
                    Caption = 'Tot&aling', Comment = 'DEU="&Summieren"';
                    ToolTip = 'Creates a total of the line items "From total" / "To total"', comment = 'DEU="Legt eine Summierung der Zeilenpositionen "Von Summe" / "Bis Summe fest""';
                    Image = Totals;
                    trigger OnAction()
                    var
                        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
                    begin
                        LeBitCorrespDocMgt.PurchLineIndentTotaling(Rec);
                    end;
                }
                action("LBT Num&bering")
                {
                    ApplicationArea = All;
                    Caption = 'Num&bering', Comment = 'DEU="&Nummerieren"';
                    ToolTip = 'Specified a numbering of the line positions"', comment = 'DEU="Legt eine Nummerierung der Zeilenpositionen fest"';
                    Image = NumberGroup;
                    trigger OnAction()
                    var
                        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
                    begin
                        LeBitCorrespDocMgt.PurchLinePosNumber(Rec);
                    end;
                }
                action("LBT Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text', Comment = 'DEU="Kopftext"';
                    ToolTip = 'Here you can define the Header Text.', comment = 'deu="Hier können Sie den Kopftext erfassen."';
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
                    ApplicationArea = All;
                    Caption = '&Footer Text', Comment = 'DEU="&Fußtext"';
                    ToolTip = 'Here you can define the Footer Text.', comment = 'deu="Hier können Sie den Fußtext erfassen."';
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

