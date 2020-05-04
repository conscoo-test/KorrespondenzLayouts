pageextension 5272749 "lbt Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        modify(Description)
        {
            StyleExpr = "lbt Printoption StyleExpr";
        }


        addfirst(Control1)
        {
            field("lbt Pos. No."; "lbt Pos. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specified the Position No.';
            }
        }
        addafter(FilteredTypeField)
        {
            field("lbt Printoption"; "lbt Printoption")
            {
                ApplicationArea = All;
                ToolTip = 'Specified the Printoption';
            }
        }
        addafter("Line No.")
        {
            field("lbt Long Text"; "lbt Long Text")
            {
                ApplicationArea = All;
                ToolTip = 'Long Text';
            }
        }
    }
    actions
    {
        addafter(DeferralSchedule)
        {
            action("lbt LongText") //TODO: OnAfterAction
            {
                ApplicationArea = Suite;
                Caption = 'Long Text';
                ToolTip = 'Long Text';
                Image = Import;

                trigger OnAction()
                begin
                    ;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
    begin
        "lbt Printoption StyleExpr" := LeBitCorrespDocMgt.GetStyleExpr("lbt Printoption");
    end;
}

