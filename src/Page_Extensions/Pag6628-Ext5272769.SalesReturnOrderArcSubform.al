pageextension 5272769 "LBT Sales Return Ord. Arc Sub." extends "Sales Return Order Arc Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field("LBT Pos. No."; "LBT Pos. No.")
            {
                ApplicationArea = All;
            }
            field("LBT Printoption"; "LBT Printoption")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("LBT Long Text"; "LBT Long Text")
            {
                ApplicationArea = All;
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

