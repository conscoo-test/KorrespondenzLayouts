page 5272726 DBTextEdit
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
                field(Text; Text)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text: Text;

    procedure SetText(Inputtext: Text)
    begin
        Text := Inputtext;
    end;

    procedure GetText(): Text
    begin
        exit(Text);
    end;
}

