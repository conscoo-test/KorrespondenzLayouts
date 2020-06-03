page 5272726 "LBT DBTextEdit"
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
                    ToolTip = 'Here you can enter the text.';
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

