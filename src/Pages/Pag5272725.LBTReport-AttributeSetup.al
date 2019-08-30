page 5272725 "LBT Report - Attribute Setup"
{
    Caption = 'Report - Attribute Setup';, Comment = 'DEU="Bericht - Attribute Einrichtung"'
    PageType = List;
    SourceTable = "LBT Report - Attribute Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control5272730)
            {
                ShowCaption = false;
                field("Report-Type"; "Report-Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Please select the report type', comment = 'DEU="Bitte wählen Sie den Berichtstyp"';
                }
                field("Report-ID"; "Report-ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Please select the report-id', comment = 'DEU="Bitte wählen Sie die Report-ID"';
                    LookupPageID = Objects;
                }
                field(Position; Position)
                {
                    ApplicationArea = All;
                    ToolTip = 'Select the position at which the attributes appear', comment = 'DEU="Legen Sie fest an welcher Position die Attribute erscheinen"';
                }
                field(Priority; Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please choose a priority', comment = 'DEU="Bitte wählen Sie eine Priorität"';
                }
                field(ID; ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please choose a No.', comment = 'DEU="Bitte wählen Sie eine Nr."';
                }
                field("Additional Character"; "Additional Character")
                {
                    ApplicationArea = All;
                    ToolTip = 'Additional Character', comment = 'DEU="Zusatzzeichen"';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please enter a description', comment = 'DEU="Bitte hier eine Beschreibung eingeben"';
                }
                field("Permit Description"; "Permit Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow description', comment = 'DEU="Beschreibung zulassen"';

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Control Unit of Measure Code"; "Control Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select a unit of measure code', comment = 'DEU="Legt eine Einheit für den Prüfeinheitencode fest"';
                }
                field("Decimal Places"; "Decimal Places")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of decimal places.', comment = 'DEU="Legt die Anzahl der Dezimalstellen fest"';
                }
            }
        }
    }

    actions
    {
    }
}

