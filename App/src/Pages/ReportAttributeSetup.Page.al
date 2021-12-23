page 50725 "lbt Report - Attribute Setup"
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
            repeater(Control50730)
            {
                ShowCaption = false;
                field("Report-Type"; Rec."Report-Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Please select the report type';
                }
                field("Report-ID"; Rec."Report-ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Please select the report-id';
                    LookupPageID = Objects;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                    ToolTip = 'Select the position at which the attributes appear';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please choose a priority';
                }
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please choose a No.';
                }
                field("Additional Character"; Rec."Additional Character")
                {
                    ApplicationArea = All;
                    ToolTip = 'Additional Character';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please enter a description';
                }
                field("Permit Description"; Rec."Permit Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow description';

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE();
                    end;
                }
                field("Control Unit of Measure Code"; Rec."Control Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select a unit of measure code';
                }
                field("Decimal Places"; Rec."Decimal Places")
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

