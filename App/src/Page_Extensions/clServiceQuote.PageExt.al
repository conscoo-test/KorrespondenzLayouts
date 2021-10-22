pageextension 5272819 "lbt cl ServiceQuote" extends "Service Quote"
{
    layout
    {
        addlast(General)
        {
            field("lbt Editor Header"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorHeader, rec."Document Type".AsInteger()))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor Header';
                caption = 'Editor Header';
                trigger OnAssistEdit()
                begin
                    rec.lbtEditData(enum::"lbt Position"::EditorHeader, rec."Document Type".AsInteger());
                end;
            }
            field("lbt Editor Footer"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorFooter, rec."Document Type".AsInteger()))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor Footer';
                caption = 'Editor Footer';
                trigger OnAssistEdit()
                begin
                    rec.lbtEditData(enum::"lbt Position"::Editorfooter, rec."Document Type".AsInteger());
                end;
            }
        }
    }
}