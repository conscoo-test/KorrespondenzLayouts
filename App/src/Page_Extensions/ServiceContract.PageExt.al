pageextension 5272831 "lbt cl ServiceContract" extends "Service Contract"
{
    layout
    {
        addlast(Shipping)
        {
            field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, Rec."Contract Type"))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor Header';
                caption = 'Editor Header';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, Rec."Contract Type");
                end;
            }
            field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, Rec."Contract Type"))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor Footer';
                caption = 'Editor Footer';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Enum::"lbt Position"::Editorfooter, Rec."Contract Type");
                end;
            }
        }
    }
}
