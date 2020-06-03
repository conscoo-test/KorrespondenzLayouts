pageextension 5272778 "LBT Purch Ret. Order Arc Sub." extends "Purch Return Order Arc Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field("LBT Pos. No."; "LBT Pos. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can fill in position numbers.';
            }
        }
        addafter(Type)
        {

            field("LBT Printoption"; "LBT Printoption")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can choose the Printoptions.';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("LBT Long Text"; "LBT Long Text")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can insert long texts. ';
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
                ToolTip = 'Here you can insert the long text for the line.';
                Image = Import;
                trigger OnAction()
                var
                    LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
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

