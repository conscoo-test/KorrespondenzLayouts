pageextension 5272833 "lbt cl JobPlanningLines" extends "Job Planning Lines"
{
    layout
    {
        modify(Description)
        {
            StyleExpr = lbtStyle;
        }
        addfirst(Control1)
        {
            field("lbt Pos. No."; Rec."lbt Pos. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Position No.';
            }
        }
        addafter(Type)
        {
            field("lbt Printoption"; Rec."lbt Printoption")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Printoption';
                StyleExpr = lbtStyle;
                ValuesAllowed = Standard, Title, "Price Invisible", "Line Invisible", "New Page", "Begin Total", "End Total", Bold;

                trigger OnValidate()
                begin
                    SetStyle();
                end;
            }
        }
        addafter(Description)
        {
            field("lbt Editor"; Rec.lbtHasEditorValue())
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Editor';
                Caption = 'Editor';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData();
                end;
            }

        }
    }

    actions
    {
        addafter("Job - Planning Lines")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit Extended Layout Options';
                action("lbt Tot&aling")
                {
                    ApplicationArea = All;
                    Caption = 'Totaling';
                    ToolTip = 'Creates a total of the line items "From total" / "To total"';
                    Image = Totals;
                    trigger OnAction()
                    var
                        Job: Record Job;
                        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";

                    begin
                        Job.Get(Rec."Job No.");
                        LeBitCorrespDocMgt.JobPlanningLineIndentTotaling(Job);
                    end;
                }
                action("lbt Num&bering")
                {
                    ApplicationArea = All;
                    Caption = 'Numbering';
                    ToolTip = 'Specified a numbering of the line positions"';
                    Image = NumberGroup;
                    trigger OnAction()
                    var
                        Job: Record Job;
                        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
                    begin
                        Job.Get(Rec."Job No.");
                        LeBitCorrespDocMgt.JobPlanningLinePosNumber(Job);
                    end;
                }
            }
        }
        addafter("Category_Item Availability by")
        {
            actionref("lbtNum&bering_Promoted"; "lbt Num&bering") { }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetStyle();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetStyle();
    end;

    local procedure SetStyle()
    var
        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
    begin
        lbtStyle := LeBitCorrespDocMgt.GetStyleExpr(Rec."lbt Printoption");
    end;

    var
        lbtStyle: Text;
}
