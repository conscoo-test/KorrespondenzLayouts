page 5272725 "LBT Report - Attribute Setup"
{
    Caption = 'Report - Attribute Setup';
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
                }
                field("Report-ID"; "Report-ID")
                {
                    ApplicationArea = All;
                    LookupPageID = Objects;
                }
                field(Position; Position)
                {
                    ApplicationArea = All;
                }
                field(Priority; Priority)
                {
                    ApplicationArea = All;
                }
                field(ID; ID)
                {
                    ApplicationArea = All;
                }
                field("Additional Character"; "Additional Character")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Permit Description"; "Permit Description")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Control Unit of Measure Code"; "Control Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Decimal Places"; "Decimal Places")
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

