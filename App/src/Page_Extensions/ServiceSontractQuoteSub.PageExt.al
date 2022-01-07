pageextension 5272825 "lbt cl ServiceSontractQuoteSub" extends "Service Contract Quote Subform"
{
    layout
    {
        addafter(Description)
        {
            field("lbt Editor"; rec.lbtHasEditorValue(rec."Contract Type"))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor';
                caption = 'Editor';
                trigger OnAssistEdit()
                begin
                    rec.lbtEditData(rec."Contract Type");
                end;
            }

        }
    }
}
