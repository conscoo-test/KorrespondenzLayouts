pageextension 50781 "lbt Posted Ret. Shipment Sub." extends "Posted Return Shipment Subform"
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
        addafter(Correction)
        {
            field("lbt Long Text"; Rec."lbt Long Text")
            {
                ToolTip = 'Here you can insert long texts. ';
                ApplicationArea = All;
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
        addafter(ItemCreditMemoLines)
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

