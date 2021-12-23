pageextension 50809 "lbt cl Service Invoice Subf" extends "Service Invoice Subform"
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
