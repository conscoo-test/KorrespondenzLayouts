pageextension 50813 "lbt cl Pstd Service Shpt Lines" extends "Posted Service Shipment Lines"
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
