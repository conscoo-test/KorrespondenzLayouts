pageextension 5272846 "lbt cl BlankPurchOrderArchSub" extends "Blanket Purch. Order Arch.Sub."
{
    layout
    {
        addlast(Control47)
        {
            field("Lbt Editor"; Rec.lbtHasEditorValue(Rec."Document Type".AsInteger()))
            {
                Caption = 'Editor';
                ApplicationArea = all;
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
}