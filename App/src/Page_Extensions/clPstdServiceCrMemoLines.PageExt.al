pageextension 50828 "lbt cl PstdServiceCrMemoLines" extends "Posted Service Cr. Memo Lines"
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
