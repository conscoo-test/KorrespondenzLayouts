pageextension 5272741 "lbt Extended Text" extends "Extended Text"
{
    layout
    {
        addafter("Ending Date")
        {
            field("lbt Textchoice"; "lbt Textchoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specified a Textchoice', comment = 'DEU="Legt eine Textauswahl fest"';
            }
        }
        addafter(Control25)
        {
            part("lbt LongTextSUB"; "lbt Ext. Text Lines Long")
            {
                ApplicationArea = All;
                Caption = 'Long Text', Comment = 'DEU="Langtext"';
                ToolTip = 'Here you can insert long texts.', comment = 'DEU="Hier können Sie Langtexte einfügen."';
                SubPageLink = Table_ID = FIELD("Table Name"),
                              "No." = FIELD("No."),
                              "Language Code" = FIELD("Language Code"),
                              "Text No." = FIELD("Text No.");
            }
        }
    }
}

