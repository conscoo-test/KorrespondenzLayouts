pageextension 5272818 "lbt cl PostedServiceCreditMemo" extends "Posted Service Credit Memo"
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
