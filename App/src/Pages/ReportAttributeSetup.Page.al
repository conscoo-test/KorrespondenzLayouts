page 5272725 "lbt Report - Attribute Setup"
{
    Caption = 'Report - Attribute Setup';
    PageType = List;
    SourceTable = "lbt Report - Attribute Setup";
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
                    ToolTip = 'Please select the report type';
                }
                field("Report-ID"; "Report-ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Please select the report-id';
                    LookupPageID = Objects;
                }
                field(Position; Position)
                {
                    ApplicationArea = All;
                    ToolTip = 'Select the position at which the attributes appear';
                }
                field(Priority; Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please choose a priority';
                }
                field(ID; ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please choose a No.';
                }
                field("Additional Character"; "Additional Character")
                {
                    ApplicationArea = All;
                    ToolTip = 'Additional Character';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please enter a description';
                }
                field("Permit Description"; "Permit Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow description';

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE();
                    end;
                }
                field("Control Unit of Measure Code"; "Control Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select a unit of measure code';
                }
                field("Decimal Places"; "Decimal Places")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of decimal places.';
                }
            }
        }
    }

    actions
    {
    }
}

