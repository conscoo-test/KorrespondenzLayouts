pageextension 5272749 "lbt Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        modify(FilteredTypeField)
        {
            Visible = false;
        }
        modify(Type)
        {
            ApplicationArea = All;
        }
        modify(Description)
        {
            StyleExpr = lbtStyle;
        }
        addfirst(Control1)
        {
            field("lbt Pos. No."; Rec."lbt Pos. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specified the Position No.';
            }
        }
        addafter(FilteredTypeField)
        {
            field("lbt Printoption"; Rec."lbt Printoption")
            {
                ApplicationArea = All;
                ToolTip = 'Specified the Printoption';
            }
        }
        addafter("Line No.")
        {
            field("lbt Long Text"; Rec."lbt Long Text")
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
        lbtStyle := LeBitCorrespDocMgt.GetStyleExpr(Rec."lbt Printoption");
    end;

    var
        lbtStyle: Text;
}

