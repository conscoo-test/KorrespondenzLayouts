pageextension 5272810 "lbt cl ServItemWorksheet Subf" extends "Service Item Worksheet Subform"
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
