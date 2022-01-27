pageextension 5272812 "lbt cl Pstd Service Shpt. Subf" extends "Posted Service Shpt. Subform"
{
    layout
    {
        addafter(Description)
        {
            field("lbt Editor"; Rec.lbtHasEditorValue())
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor';
                caption = 'Editor';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData();
                end;
            }

        }
    }
}
