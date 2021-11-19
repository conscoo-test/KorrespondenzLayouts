pageextension 5272824 "lbt cl ServiceContractSubform" extends "Service Contract Subform"
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
