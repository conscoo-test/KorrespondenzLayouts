pageextension 5272778 "lbt Purch Ret. Order Arc Sub." extends "Purch Return Order Arc Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field("lbt Pos. No."; "lbt Pos. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can fill in position numbers.', comment = 'Deu="Hier können Sie Positionsnummern angeben."';
            }
        }
        addafter(Type)
        {

            field("lbt Printoption"; "lbt Printoption")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can choose the Printoptions.', comment = 'Deu="Hier können Sie die Druckoptionen wählen."';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("lbt Long Text"; "lbt Long Text")
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
            action("lbt LongText")
            {
                ApplicationArea = Suite;
                Caption = 'Long Text';
                ToolTip = 'Here you can insert the long text for the line.', comment = 'Deu="Hier können Sie den Langtext für die Zeile einfügen."';
                Image = Import;
                trigger OnAction()
                var
                    LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
                    SourceRecRef: RecordRef;
                    Position: Option Header,Footer,Longtext;
                begin
                    SourceRecRef.GETTABLE(Rec);
                    LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Longtext);
                end;
            }
        }
    }
}

