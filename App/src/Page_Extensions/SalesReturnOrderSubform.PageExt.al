pageextension 5272772 "lbt Sales Return Order Subform" extends "Sales Return Order Subform"
{
    layout
    {
        modify(Description)
        {
            StyleExpr = "lbt Printoption StyleExpr";
        }

        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }
        addfirst(Control1)
        {
            field("lbt Pos. No."; "lbt Pos. No.")
            {
                ToolTip = 'Here you can fill in position numbers.', comment = 'Deu="Hier können Sie Positionsnummern angeben."';
                ApplicationArea = All;
            }
        }
        addafter(Type)
        {

            field("lbt Printoption"; "lbt Printoption")
            {
                ToolTip = 'Here you can choose the Printoptions.', comment = 'Deu="Hier können Sie die Druckoptionen wählen."';
                ApplicationArea = All;
            }
        }
        addafter("ShortcutDimCode8")
        {
            field("lbt Long Text"; "lbt Long Text")
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

    trigger OnAfterGetRecord()
    var
        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
    begin
        "lbt Printoption StyleExpr" := LeBitCorrespDocMgt.GetStyleExpr("lbt Printoption");
    end;
}

