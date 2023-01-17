pageextension 5272837 "lbt cl ServiceContract" extends "Service Contract"
{
    layout
    {
        addlast(Shipping)
        {
            field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, Rec."Contract Type"))
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Editor Header';
                Caption = 'Editor Header';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, Rec."Contract Type");
                end;
            }
            field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, Rec."Contract Type"))
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Editor Footer';
                Caption = 'Editor Footer';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Enum::"lbt Position"::EditorFooter, Rec."Contract Type");
                end;
            }
        }
    }
}
