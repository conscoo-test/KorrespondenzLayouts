pageextension 5272807 "lbt cl ServiceOrderSubform" extends "Service Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("lbt Editor"; Rec.lbtHasEditorValue(Rec."Document Type".AsInteger()))
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Editor';
                Caption = 'Editor';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Rec."Document Type".AsInteger());
                end;
            }
        }
    }
}
