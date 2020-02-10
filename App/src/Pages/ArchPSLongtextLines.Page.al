page 5272722 "lbt Arch. PS Longtext Lines"
{
    AutoSplitKey = true;
    Caption = 'Archive PS Longtext Lines', Comment = 'DEU="Archivierte EK/VK Langtext Zeilen"';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "lbt Archive PS Longtext Line";
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
                    ToolTip = 'Specifies a unique number', comment = 'DEU="Legt eine eindeutige Nr. fest"';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique description', comment = 'DEU="Legt eine eindeutige Beschreibung fest"';
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique type', comment = 'DEU="Legt den Typ fest"';
                }
            }
        }
    }

    actions
    {
    }
}

