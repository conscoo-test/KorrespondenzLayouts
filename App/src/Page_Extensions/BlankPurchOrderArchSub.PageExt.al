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
    }
}