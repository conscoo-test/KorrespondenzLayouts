page 5272726 "lbt DBTextEdit"
{
    PageType = StandardDialog;
    // UsageCategory = None;

    layout
    {
        area(content)
        {
            grid(Control50002)
            {
                GridLayout = Rows;
                ShowCaption = false;
                field("Text"; Txt)
                {
                    Caption = 'Text';
                    ApplicationArea = All;
                    ToolTip = 'Here you can enter the text.', comment = 'DEU="Hier ist die Texteingabe möglich."';
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
    }

    var
        Txt: Text;

    procedure SetText(Inputtext: Text)
    begin
        Txt := Inputtext;
    end;

    procedure GetText(): Text
    begin
        exit(Txt);
    end;
}

