pageextension 5272781 "LBT Posted Ret. Shipment Sub." extends "Posted Return Shipment Subform"
{
    layout
    {
        modify(Description)
        {
            StyleExpr = "LBT Printoption StyleExpr";
        }
        addfirst(Control1)
        {
            field("LBT Pos. No."; "LBT Pos. No.")
            {
                ApplicationArea = All;
            }
            field("LBT Printoption"; "LBT Printoption")
            {
                ApplicationArea = All;
            }
        }
        addafter(Correction)
        {
            field("LBT Long Text"; "LBT Long Text")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(ItemCreditMemoLines)
        {
            action("LBT LongText")
            {
                ApplicationArea = Suite;
                Caption = 'Long Text';
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

