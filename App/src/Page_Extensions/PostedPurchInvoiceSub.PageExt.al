pageextension 5272730 "lbt Posted Purch. Invoice Sub." extends "Posted Purch. Invoice Subform"
{
    layout
    {
        modify(Description)
        {
            StyleExpr = "lbt Printoption StyleExpr";
        }
        addfirst(Control1)
        {
            field("lbt Pos. No."; "lbt Pos. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specified the Position No.', comment = 'DEU="Legt die Positionsnr. fest"';
            }
        }
        addafter(Type)
        {
            field("lbt Printoption"; "lbt Printoption")
            {
                ApplicationArea = All;
                ToolTip = 'Specified the Printoption', comment = 'DEU="Legt die Druckauswahl fest"';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("lbt Long Text"; "lbt Long Text")
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
            action("lbt LongText")
            {
                ApplicationArea = Suite;
                Caption = 'Long Text', Comment = 'DEU="Langtext"';
                ToolTip = 'Here you can insert the long text for the line.', comment = 'DEU="Hier können Sie den Langtext für die Zeile einfügen."';
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
    trigger OnAfterGetRecord()
    var
        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
    begin
        "lbt Printoption StyleExpr" := LeBitCorrespDocMgt.GetStyleExpr("lbt Printoption");
    end;
}

