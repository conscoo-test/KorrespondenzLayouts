pageextension 5272808 "lbt cl ServiceQuoteSubform" extends "Service Quote Subform"
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
