#if CLEAN1_8
pageextension 5272838 "lbt cl Cust. Report Selections" extends "Customer Report Selections"
{
    layout
    {
        addlast(Group)
        {
            field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader))
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Header Text';
                Caption = 'Header Text';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Enum::"lbt Position"::EditorHeader);
                    CurrPage.Update(false);
                end;
            }
            field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter))
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Footer Text';
                Caption = 'Footer Text';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Enum::"lbt Position"::EditorFooter);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
#endif