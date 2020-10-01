pageextension 5272756 "lbt Blanket Purch. Order Sub." extends "Blanket Purchase Order Subform"
{
    layout
    {
        modify(Description)
        {
            StyleExpr = Rec."lbt Printoption StyleExpr";
        }
        addfirst(Control1)
        {
            field("lbt Pos. No."; Rec."lbt Pos. No.")
            {
                ToolTip = 'Here you can fill in position numbers.';
                ApplicationArea = All;
            }
        }
        addafter(Type)
        {
            field("lbt Printoption"; Rec."lbt Printoption")
            {
                ToolTip = 'Here you can choose the Printoptions.';
                ApplicationArea = All;
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field("lbt Long Text"; Rec."lbt Long Text")
            {
                ToolTip = 'Here you can insert long texts. ';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(DocumentLineTracking)
        {
            action("lbt LongText")
            {
                ToolTip = 'Here you can insert the long text for the line.';
                ApplicationArea = Suite;
                Caption = 'Long Text';
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
        Rec."lbt Printoption StyleExpr" := LeBitCorrespDocMgt.GetStyleExpr(Rec."lbt Printoption");
    end;
}

