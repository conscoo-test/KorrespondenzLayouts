pageextension 5272747 "lbt Sales Order Subform" extends "Sales Order Subform"
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
            action("lbt LongText")
            {
                ApplicationArea = Suite;
                Caption = 'Long Text', Comment = 'DEU="Langtext"';
                ToolTip = 'Long Text', comment = 'DEU="Langtetxt"';
                Image = Import;
                trigger OnAction()
                var
                    LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
                    SourceRecRef: RecordRef;
                    Position: Option Header,Footer,Longtext;
                begin
                    SourceRecRef.GETTABLE(Rec);
                    LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Longtext);
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