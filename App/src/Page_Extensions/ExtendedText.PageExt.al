pageextension 5272741 "lbt Extended Text" extends "Extended Text"
{
    layout
    {
        addafter("Ending Date")
        {
            field("lbt Textchoice"; Rec."lbt Textchoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specified a Textchoice';
            }
        }
        addafter(Control25)
        {
            part("lbt LongTextSUB"; "lbt Ext. Text Lines Long")
            {
                ApplicationArea = All;
                Caption = 'Long Text';
                SubPageLink = Table_ID = FIELD("Table Name"),
                              "No." = FIELD("No."),
                              "Language Code" = FIELD("Language Code"),
                              "Text No." = FIELD("Text No.");
            }
        }
    }
}

