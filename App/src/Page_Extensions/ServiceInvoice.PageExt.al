pageextension 5272821 "lbt cl ServiceInvoice" extends "Service Invoice"
{
    layout
    {
        addafter(ServLines)
        {
            group(lbtEditor)
            {
                Caption = 'Longtext';

                field("lbt Editor Header"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorHeader, rec."Document Type".AsInteger()))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Header';
                    caption = 'Editor Header';
                    trigger OnAssistEdit()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::EditorHeader, rec."Document Type".AsInteger());
                    end;
                }
                field("lbt Editor Footer"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorFooter, rec."Document Type".AsInteger()))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Footer';
                    caption = 'Editor Footer';
                    trigger OnAssistEdit()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::Editorfooter, rec."Document Type".AsInteger());
                    end;
                }
            }
        }
    }
    actions
    {
        addafter("&Dimensions")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit Extended Layout Options';
                action("lbt Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text';
                    ToolTip = 'Here you can define the Header Text.';
                    Image = BeginningText;

                    trigger OnAction()

                    begin
                        rec.lbtEditData(enum::"lbt Position"::EditorHeader, rec."Document Type".AsInteger());
                    end;
                }
                action("lbt &Footer Text")
                {
                    ApplicationArea = All;
                    Caption = '&Footer Text';
                    ToolTip = 'Here you can define the Footer Text.';
                    Image = EndingText;

                    trigger OnAction()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::Editorfooter, rec."Document Type".AsInteger());
                    end;
                }
            }
        }
    }
}
