pageextension 5272845 "lbt cl BlankSalesOrderArchSub" extends "Blanket Sales Order Arch. Sub."
{
    layout
    {
        addlast(Control51)
        {
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
    }
}
