pageextension 5272726 "lbt Posted Sales Cr. Memo Sub." extends "Posted Sales Cr. Memo Subform"
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
                ToolTip = 'Specified the Position No.';
            }
        }
        addafter(Type)
        {
            field("lbt Printoption"; Rec."lbt Printoption")
            {
                ApplicationArea = All;
                ToolTip = 'Specified the Printoption';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("lbt Long Text"; Rec."lbt Long Text")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can insert long texts.';
            }
            field("Lbt Editor"; Rec.lbtHasEditorValue())
            {
                Caption = ' ', Locked = true;
                ApplicationArea = all;
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

