pageextension 50810 "lbt cl ServItemWorksheet Subf" extends "Service Item Worksheet Subform"
{
    layout
    {
        addafter(Description)
        {
            field("lbt Editor"; Rec.lbtHasEditorValue(Rec."Document Type".AsInteger()))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor';
                caption = 'Editor';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Rec."Document Type".AsInteger());
                end;
            }

        }
    }
}
