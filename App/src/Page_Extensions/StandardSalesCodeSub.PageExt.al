pageextension 5272836 "lbt cl StandardSalesCodeSub" extends "Standard Sales Code Subform"
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