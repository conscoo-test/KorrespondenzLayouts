pageextension 5272823 "lbt cl ServiceContractQuote" extends "Service Contract Quote"
{
    layout
    {
        addlast(General)
        {
            field("lbt Editor Header"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorHeader, rec."Contract Type"))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor Header';
                caption = 'Editor Header';
                trigger OnAssistEdit()
                begin
                    rec.lbtEditData(enum::"lbt Position"::EditorHeader, rec."Contract Type");
                end;
            }
            field("lbt Editor Footer"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorFooter, rec."Contract Type"))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor Footer';
                caption = 'Editor Footer';
                trigger OnAssistEdit()
                begin
                    rec.lbtEditData(enum::"lbt Position"::Editorfooter, rec."Contract Type");
                end;
            }
        }
    }
}
