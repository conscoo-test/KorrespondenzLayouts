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
                ToolTip = 'Specified the Position No.', comment = 'DEU="Legt die Positionsnr. fest"';
            }
        }
        addafter(FilteredTypeField)
        {
            field("lbt Printoption"; "lbt Printoption")
            {
                ApplicationArea = All;
                ToolTip = 'Specified the Printoption', comment = 'DEU="Legt die Druckauswahl fest"';
            }
        }
        addafter("Line No.")
        {
            field("lbt Long Text"; "lbt Long Text")
            {
                ApplicationArea = All;
                ToolTip = 'Long Text', comment = 'DEU="Langtext"';
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
                Caption = 'Long Text', Comment = 'DEU="Langtext"';
                ToolTip = 'Long Text', comment = 'DEU="Langtext"';
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

