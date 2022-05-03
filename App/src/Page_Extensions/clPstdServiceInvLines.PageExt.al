pageextension 50827 "lbt cl PstdServiceInvLines" extends "Posted Service Invoice Lines"
{
    layout
    {
        addafter(Description)
        {
            field("lbt Editor"; rec.lbtHasEditorValue())
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor';
                caption = 'Editor';
                trigger OnAssistEdit()
                begin
                    rec.lbtEditData();
                end;
            }

        }
    }
}
