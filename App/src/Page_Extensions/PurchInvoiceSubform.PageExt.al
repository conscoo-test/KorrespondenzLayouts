pageextension 5272767 "lbt Purch. Invoice Subform" extends "Purch. Invoice Subform"
{
    layout
    {
        addfirst(PurchDetailLine)
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
            }
        }
        addafter("Line No.")
        {
            field("lbt Long Text"; Rec."lbt Long Text")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can insert long texts.';
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
        ///H22/0522
        addafter("Direct Unit Cost")
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
        addafter("Related Information")
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
}
