pageextension 5272816 "lbt cl PostedServiceInvoice" extends "Posted Service Invoice"
{
    layout
    {
        addlast(General)
        {
            field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor Header';
                caption = 'Editor Header';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Enum::"lbt Position"::EditorHeader);
                end;
            }
            field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor Footer';
                caption = 'Editor Footer';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Enum::"lbt Position"::Editorfooter);
                end;
            }
        }
    }
}
