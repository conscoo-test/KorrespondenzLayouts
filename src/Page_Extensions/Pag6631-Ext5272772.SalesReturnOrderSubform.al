pageextension 5272772 "LBT Sales Return Order Subform" extends "Sales Return Order Subform"
{
    layout
    {
        modify(Description)
        {
            StyleExpr = "LBT Printoption StyleExpr";
        }

        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }
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
        addafter("ShortcutDimCode[8]")
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

    trigger OnAfterGetRecord()
    var
        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
    begin
        "LBT Printoption StyleExpr" := LeBitCorrespDocMgt.GetStyleExpr("LBT Printoption");
    end;
}

