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
                Visible = Rec."lbt Textchoice" = Rec."lbt Textchoice"::"long text";
                ApplicationArea = All;
                Caption = 'Long Text';
                SubPageLink = Table_ID = field("Table Name"),
                              "No." = field("No."),
                              "Language Code" = field("Language Code"),
                              "Text No." = field("Text No.");
            }
            part("lbt EditorPreviewSub"; "lbt cl Editor Preview Sub")
            {
                Visible = Rec."lbt Textchoice" = Rec."lbt Textchoice"::Blob;
                ApplicationArea = All;
                Caption = 'Editor';
            }
        }
    }
    actions
    {
        addlast(Navigation)
        {
            action("lbt Edit")
            {
                Caption = 'Editor';
                ApplicationArea = All;
                Image = Edit;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()

                begin
                    Rec.lbtclEditData();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        CurrPage."lbt EditorPreviewSub".Page.SetData(Rec.lbtclReadContentData(false));
    end;
}
