page 5272721 "LBT Posted PS Longtext Lines"
{
    Caption = 'Posted PS Longtext Lines';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "LBT Posted PS Longtext Line";
    // UsageCategory = Lists;
    // ApplicationArea = All;    

    layout
    {
        area(content)
        {
            repeater(Control5272723)
            {
                Editable = false;
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
                    ToolTip = 'Specifies a unique description the type';
                }
            }
        }
    }

    actions
    {
    }
}

