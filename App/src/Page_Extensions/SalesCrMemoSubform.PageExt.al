pageextension 5272804 "lbt Sales Cr. Memo Subform" extends "Sales Cr. Memo Subform"
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
        addafter("ShortcutDimCode8")
        {
            field("lbt Long Text"; "lbt Long Text")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can insert long texts.';
            }
        }
    }
    actions
    {
        addafter(ItemTrackingLines)
        {
            action("lbt LongText")
            {
                ApplicationArea = Suite;
                Caption = 'Long Text';
                ToolTip = 'Here you can insert the long text for the line.';
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

