pageextension 5272724 "LBT Posted Sales Inv. Subform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        modify(Description)
        {
            StyleExpr = "LBT Printoption StyleExpr";
        }
        addfirst(Control1)
        {
            field("LBT Pos. No."; "LBT Pos. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specified the Position No.', comment = 'DEU="Legt die Positionsnr. fest"';
            }
            field("LBT Printoption"; "LBT Printoption")
            {
                ApplicationArea = All;
                ToolTip = 'Specified the Printoption', comment = 'DEU="Legt die Druckauswahl fest"';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("LBT Long Text"; "LBT Long Text")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can insert long texts.', comment = 'DEU="Hier können Sie Langtexte einfügen."';
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
                Caption = 'Long Text', Comment = 'DEU="Langtext"';
                ToolTip = 'Here you can insert the long text for the line.', comment = 'DEU="Hier können Sie den Langtext für die Zeile einfügen."';
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

