pageextension 5272767 "LBT Purch. Invoice Subform" extends "Purch. Invoice Subform"
{
    layout
    {

        addfirst(Content)
        {
            field("LBT Pos. No."; "LBT Pos. No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(FilteredTypeField)
        {
            field("LBT Printoption"; "LBT Printoption")
            {
                ApplicationArea = All;
            }
        }
        addafter("Line No.")
        {
            field("LBT Long Text"; "LBT Long Text")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Related Information")
        {
            action("LBT LongText")
            {
                ApplicationArea = Suite;
                Caption = 'Long Text', Comment = 'DEU="Langtext"';
                Image = Import;
                trigger OnAction()
                var
                    SourceRecRef: RecordRef;
                    Position: Option Header,Footer,Longtext;
                    LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                begin
                    SourceRecRef.GETTABLE(Rec);
                    LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Longtext);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
    begin
        "LBT Printoption StyleExpr" := LeBitCorrespDocMgt.GetStyleExpr("LBT Printoption");
    end;
}

