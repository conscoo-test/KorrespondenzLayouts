pageextension 5272816 "lbt cl PostedServiceInvoice" extends "Posted Service Invoice"
{
    layout
    {
        addlast(General)
        {
            field("lbt Editor Header"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorHeader))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor Header';
                caption = 'Editor Header';
                trigger OnAssistEdit()
                begin
                    rec.lbtEditData(enum::"lbt Position"::EditorHeader);
                end;
            }
            field("lbt Editor Footer"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorFooter))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor Footer';
                caption = 'Editor Footer';
                trigger OnAssistEdit()
                begin
                    rec.lbtEditData(enum::"lbt Position"::Editorfooter);
                end;
            }
        }
    }
}
