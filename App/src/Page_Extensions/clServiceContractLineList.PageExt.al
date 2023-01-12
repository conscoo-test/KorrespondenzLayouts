pageextension 5272826 "lbt cl ServiceContractLineList" extends "Service Contract Line List"
{
    layout
    {
        addafter(Description)
        {
            field("lbt Editor"; Rec.lbtHasEditorValue(Rec."Contract Type"))
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Editor';
                Caption = 'Editor';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Rec."Contract Type");
                end;
            }
        }
    }
}
