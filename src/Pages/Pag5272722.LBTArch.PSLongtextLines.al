page 5272722 "LBT Arch. PS Longtext Lines"
{
    AutoSplitKey = true;
    Caption = 'Archive PS Longtext Lines', Comment = 'DEU="Archivierte EK/VK Langtext Zeilen"';
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

