page 50723 "lbt Ext. Text Lines Long"
{
    AutoSplitKey = true;
    Caption = 'Ext. Text Lines Long';
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "lbt Extended Text Line Long";
    // UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control5272721)
            {
                ShowCaption = false;
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique description';
                }
            }
        }
    }

    actions
    {
    }
}

