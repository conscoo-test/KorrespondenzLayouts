page 5272722 "LBT Arch. PS Longtext Lines"
{
    AutoSplitKey = true;
    Caption = 'Archive PS Longtext Lines';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "LBT Archive PS Longtext Line";
    // UsageCategory = History;
    // ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control5272723)
            {
                ShowCaption = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique number';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique description';
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique type';
                }
            }
        }
    }

    actions
    {
    }
}

