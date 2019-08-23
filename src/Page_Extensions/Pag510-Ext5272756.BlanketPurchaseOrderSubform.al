pageextension 5272756 "LBT Blanket Purch. Order Sub." extends "Blanket Purchase Order Subform"
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
        }
        addafter(Type)
        {
            field("LBT Printoption"; "LBT Printoption")
            {
                ApplicationArea = All;
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field("LBT Long Text"; "LBT Long Text")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(DocumentLineTracking)
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

