pageextension 5272728 "lbt Posted Purch. Rcpt. Sub." extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        modify(Description)
        {
            StyleExpr = lbtStyle;
        }
        addfirst(Control1)
        {
            field("lbt Pos. No."; Rec."lbt Pos. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Position No.';
            }
        }
        addafter(Type)
        {
            field("lbt Printoption"; Rec."lbt Printoption")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Printoption';
                StyleExpr = lbtStyle;
            }
        }
        addafter(Correction)
        {
            field("lbt Long Text"; Rec."lbt Long Text")
            {
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'Old field';
                ObsoleteTag = '2024-11-26';

                ApplicationArea = All;
                ToolTip = 'Here you can insert long texts.';
            }
            field("lbt Editor"; Rec.lbtHasEditorValue())
            {
                Caption = 'Editor';
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Editor';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData();
                end;
            }
        }
    }
    actions
    {
        addafter(DocumentLineTracking)
        {
            action("lbt LongText")
            {
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'Old action';
                ObsoleteTag = '2024-11-26';

                ApplicationArea = Suite;
                Caption = 'Long Text';
                ToolTip = 'Here you can insert the long text for the line.';
                Image = Import;
                trigger OnAction()
                var
                    LongtextMgt: Codeunit "lbt Longtext Mgt.";
                    SourceRecRef: RecordRef;
                    Position: Option Header,Footer,Longtext;
                begin
                    SourceRecRef.GetTable(Rec);
                    LongtextMgt.ShowLongtextLines(Rec, Position::Longtext);
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
