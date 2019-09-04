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
                ToolTip = 'Here you can fill in position numbers.', comment = 'Deu="Hier können Sie Positionsnummern angeben."';
                ApplicationArea = All;
            }
            field("LBT Printoption"; "LBT Printoption")
            {
                ToolTip = 'Here you can choose the Printoptions.', comment = 'Deu="Hier können Sie die Druckoptionen wählen."';
                ApplicationArea = All;
            }
        }
        addafter("ShortcutDimCode8")
        {
            field("LBT Long Text"; "LBT Long Text")
            {
                ToolTip = 'Here you can insert long texts. ', comment = 'deu="Hier können Sie Langtexte einfügen."';
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

    trigger OnAfterGetRecord()
    var
        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
    begin
        "LBT Printoption StyleExpr" := LeBitCorrespDocMgt.GetStyleExpr("LBT Printoption");
    end;
}

