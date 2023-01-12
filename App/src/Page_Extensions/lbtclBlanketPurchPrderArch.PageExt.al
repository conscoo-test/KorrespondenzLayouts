pageextension 5272844 "lbt cl BlanketPurchPrderArch" extends "Blanket Purchase Order Archive"
{
    layout
    {
        addafter(PurchLinesArchive)
        {
            group(lbtEditor)
            {
                Caption = 'LeBit Extended Layout Options';
                field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, Rec."Document Type".AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Header';
                    Caption = 'Editor Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, Rec."Document Type".AsInteger());
                    end;
                }
                field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, Rec."Document Type".AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Footer';
                    Caption = 'Editor Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorFooter, Rec."Document Type".AsInteger());
                    end;
                }
            }
        }
    }
}
