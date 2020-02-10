page 5272723 "lbt Ext. Text Lines Long"
{
    AutoSplitKey = true;
    Caption = 'Ext. Text Lines Long', Comment = 'DEU="Ext. Textbausteinzeilen Lang"';
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
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique description', comment = 'DEU="Legt eine eindeutige Beschreibung fest"';
                }
            }
        }
    }

    actions
    {
    }
}

