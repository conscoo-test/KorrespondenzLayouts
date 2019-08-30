pageextension 5272741 "LBT Extended Text" extends "Extended Text"
{
    layout
    {
        addafter("Ending Date")
        {
            field("LBT Textchoice"; "LBT Textchoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specified a Textchoice', comment = 'DEU="Legt eine Textauswahl fest"';
            }
        }
        addafter(Control25)
        {
            part("LBT LongTextSUB"; "LBT Ext. Text Lines Long")
            {
                Caption = 'Long Text', Comment = 'DEU="Langtext"';
                ToolTip = 'Long Text', comment = 'DEU="Langtext"';
                SubPageLink = Table_ID = FIELD ("Table Name"),
                              "No." = FIELD ("No."),
                              "Language Code" = FIELD ("Language Code"),
                              "Text No." = FIELD ("Text No.");
            }
        }
    }
}

