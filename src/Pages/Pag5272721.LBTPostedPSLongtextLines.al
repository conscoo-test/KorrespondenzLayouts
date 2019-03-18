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
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
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

