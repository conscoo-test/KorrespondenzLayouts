pageextension 5272816 "lbt cl PostedServiceInvoice" extends "Posted Service Invoice"
{
    layout
    {
        addafter(ServInvLines)
        {
            group(lbtEditor)
            {
                Caption = 'LeBit Extended Layout Options';

                field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Header';
                    Caption = 'Editor Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader);
                    end;
                }
                field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Footer';
                    Caption = 'Editor Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorFooter);
                    end;
                }
            }
        }
    }
}
