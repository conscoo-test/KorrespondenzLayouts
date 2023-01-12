pageextension 5272825 "lbt cl ServiceSontractQuoteSub" extends "Service Contract Quote Subform"
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
