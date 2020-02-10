pageextension 5272753 "lbt Blanket Sales Order Sub." extends "Blanket Sales Order Subform"
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
        addafter("ShortcutDimCode[8]")
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
        addafter("Co&mments")
        {
            action("lbt LongText")
            {
                ApplicationArea = Suite;
                Caption = 'Long Text', comment = 'DEU="Lang Text"';
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

