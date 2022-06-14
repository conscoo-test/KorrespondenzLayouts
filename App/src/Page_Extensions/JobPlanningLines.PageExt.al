pageextension 5272833 "lbt cl JobPlanningLines" extends "Job Planning Lines"
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
