pageextension 5272831 "lbt cl ServiceLines" extends "Service Lines"
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
