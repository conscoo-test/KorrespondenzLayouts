pageextension 5272741 "LBT Extended Text" extends "Extended Text"
{
    layout
    {
        addafter("Ending Date")
        {
            field("LBT Textchoice"; "LBT Textchoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specified a Textchoice';
            }
        }
        addafter(Control25)
        {
            part("LBT LongTextSUB"; "LBT Ext. Text Lines Long")
            {
                ApplicationArea = All;
                Caption = 'Long Text';
                ToolTip = 'Here you can insert long texts.';
                SubPageLink = Table_ID = FIELD("Table Name"),
                              "No." = FIELD("No."),
                              "Language Code" = FIELD("Language Code"),
                              "Text No." = FIELD("Text No.");
            }
        }
    }
}

