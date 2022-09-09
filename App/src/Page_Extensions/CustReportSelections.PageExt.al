pageextension 5272838 "lbt cl Cust. Report Selections" extends "Customer Report Selections"
{
    layout
    {
        addlast(Group)
        {
            field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Header Text';
                caption = 'Header Text';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Enum::"lbt Position"::EditorHeader);
                    CurrPage.Update(false);
                end;
            }
            field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Footer Text';
                caption = 'Footer Text';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Enum::"lbt Position"::Editorfooter);
                    CurrPage.Update(false);
                end;
            }
        }
    }

}
