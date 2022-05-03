pageextension 50741 "lbt Extended Text" extends "Extended Text"
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
            part("lbt EditorPreviewSub"; "lbt cl Editor preview Sub")
            {
                Visible = Rec."lbt Textchoice" = Rec."lbt Textchoice"::blob;
                ApplicationArea = all;
                caption = 'Editor';
            }
        }

    }
    actions
    {
        addlast(Navigation)
        {
            action("lbt Edit")
            {
                caption = 'Editor';
                ApplicationArea = All;
                image = Edit;
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

