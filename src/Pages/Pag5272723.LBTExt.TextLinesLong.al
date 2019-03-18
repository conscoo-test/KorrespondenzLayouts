page 5272723 "LBT Ext. Text Lines Long"
{
    AutoSplitKey = true;
    Caption = 'Ext. Text Lines Long';
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "LBT Extended Text Line Long";
    // UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control5272721)
            {
                ShowCaption = false;
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

