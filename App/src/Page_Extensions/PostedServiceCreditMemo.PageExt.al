pageextension 5272818 "lbt cl PostedServiceCreditMemo" extends "Posted Service Credit Memo"
{
    layout
    {
        addafter(ServCrMemoLines)
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
