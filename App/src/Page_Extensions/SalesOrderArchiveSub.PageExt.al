pageextension 5272758 "lbt Sales Order Archive Sub." extends "Sales Order Archive Subform"
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
                ToolTip = 'Here you can fill in position numbers.';
                ApplicationArea = All;
            }
        }
        addafter(Type)
        {
            field("lbt Printoption"; "lbt Printoption")
            {
                ToolTip = 'Here you can choose the Printoptions.';
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("lbt Long Text"; "lbt Long Text")
            {
                ToolTip = 'Here you can insert long texts. ';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(DeferralSchedule)
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
        "lbt Printoption StyleExpr" := LeBitCorrespDocMgt.GetStyleExpr("lbt Printoption");
    end;
}

