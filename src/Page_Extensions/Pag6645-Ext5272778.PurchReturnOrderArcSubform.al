pageextension 5272778 "LBT Purch Ret. Order Arc Sub." extends "Purch Return Order Arc Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field("LBT Pos. No."; "LBT Pos. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can fill in position numbers.', comment = 'Deu="Hier können Sie Positionsnummern angeben."';
            }
            field("LBT Printoption"; "LBT Printoption")
            {
                ApplicationArea = All;
                 ToolTip = 'Here you can choose the Printoptions.', comment = 'Deu="Hier können Sie die Druckoptionen wählen."';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("LBT Long Text"; "LBT Long Text")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can insert long texts. ', comment = 'deu="Hier können Sie Langtexte einfügen."';
            }
        }
    }
    actions
    {
        addafter(DeferralSchedule)
        {
            action("LBT LongText")
            {
                ApplicationArea = Suite;
                Caption = 'Long Text';
                ToolTip = 'Here you can insert the long text for the line.', comment = 'Deu="Hier können Sie den Langtext für die Zeile einfügen."';
                Image = Import;
                trigger OnAction()
                var
                    SourceRecRef: RecordRef;
                    Position: Option Header,Footer,Longtext;
                    LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                begin
                    SourceRecRef.GETTABLE(Rec);
                    LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Longtext);
                end;
            }
        }
    }
}

