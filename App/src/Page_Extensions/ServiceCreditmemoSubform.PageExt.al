pageextension 50811 "lbt cl ServiceCreditmemoSubf" extends "Service Credit Memo Subform"
{
    layout
    {
        addafter(Description)
        {
            field("lbt Editor"; rec.lbtHasEditorValue(rec."Document Type".AsInteger()))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor';
                caption = 'Editor';
                trigger OnAssistEdit()
                begin
                    rec.lbtEditData(rec."Document Type".AsInteger());
                end;
            }

        }
    }
}
