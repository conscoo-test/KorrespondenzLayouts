pageextension 5272747 "lbt Sales Order Subform" extends "Sales Order Subform"
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
        addafter(FilteredTypeField)
        {
            field("lbt Printoption"; Rec."lbt Printoption")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Printoption';
                ValuesAllowed = Standard, Title, "Price Invisible", "Line Invisible", "New Page", "Begin Total", "End Total", Bold;
                StyleExpr = lbtStyle;

                trigger OnValidate()
                begin
                    SetStyle();
                end;
            }
        }
        addafter("Line No.")
        {
            field("lbt Long Text"; Rec."lbt Long Text")
            {
                ObsoleteState = Pending;
                ObsoleteReason = '2024-11-26 Old field';
                ApplicationArea = All;
                ToolTip = 'Long Text';
                Visible = false;
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
        addafter(Quantity)
        {
            field("lbt cl Delivery Date Type"; Rec."lbt cl Delivery Date Type")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you define the Delivery Date Type';
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
        addafter(DeferralSchedule)
        {
            action("lbt LongText")
            {
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'Old field';
                ObsoleteTag = '2024-11-26';

                ApplicationArea = Suite;
                Caption = 'Long Text';
                ToolTip = 'Long Text';
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
    begin
        SetStyle();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetStyle();
    end;

    local procedure SetStyle()
    var
        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
    begin
        lbtStyle := LeBitCorrespDocMgt.GetStyleExpr(Rec."lbt Printoption");
    end;

    var
        lbtStyle: Text;
}