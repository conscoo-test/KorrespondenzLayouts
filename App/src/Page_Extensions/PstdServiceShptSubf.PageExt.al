pageextension 5272812 "lbt cl Pstd Service Shpt. Subf" extends "Posted Service Shpt. Subform"
{
    layout
    {
        addafter(Description)
        {
            field("lbt Editor"; Rec.lbtHasEditorValue())
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Editor';
                Caption = 'Editor';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData();
                end;
            }
        }
    }
}
