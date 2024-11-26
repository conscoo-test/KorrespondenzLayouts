pageextension 5272760 "lbt Sales Quote Archive Sub." extends "Sales Quote Archive Subform"
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
        addafter("Shortcut Dimension 2 Code")
        {
            field("lbt Long Text"; Rec."lbt Long Text")
            {
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'Old field';
                ObsoleteTag = '2024-11-26';

                ToolTip = 'Here you can insert long texts. ';
                ApplicationArea = All;
            }
            field("Lbt Editor"; Rec.lbtHasEditorValue(Rec."Document Type".AsInteger()))
            {
                Caption = 'Editor';
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Editor';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Rec."Document Type".AsInteger());
                end;
            }
        }
        ///H22/0437
        addafter("Unit Price")
        {
            field("lbt cl Price Factor"; Rec."lbt cl Price Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you enter the Price Factor.';
            }
            field("lbt cl Price in Price Factor"; Rec."lbt cl Price in Price Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you enter the Unit Price in Price Factor.';
            }
        }
    }
    actions
    {
        addafter("Co&mments")
        {
            action("lbt LongText")
            {
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'Old action';
                ObsoleteTag = '2024-11-26';

                ToolTip = 'Here you can insert the long text for the line.';
                ApplicationArea = Suite;
                Caption = 'Long Text';
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
