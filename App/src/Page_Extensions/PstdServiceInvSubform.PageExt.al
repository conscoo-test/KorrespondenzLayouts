pageextension 5272814 "lbt cl Pstd Service Inv Subf" extends "Posted Service Invoice Subform"
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
