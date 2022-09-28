pageextension 5272815 "lbt cl ServiceOrder" extends "Service Order"
{
    layout
    {
        addafter(ServItemLines)
        {
            group(lbtEditor)

            {
                Caption = 'LeBit Extended Layout Options';
                field("lbt Editor Header"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorHeader, rec."Document Type"::Order.AsInteger()))
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
                field("lbt Editor Footer"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorFooter, rec."Document Type"::Order.AsInteger()))
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
                field("lbt Editor Shipment Header"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorHeader, 11))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Shipment Header';
                    caption = 'Editor Shipment Header';
                    trigger OnAssistEdit()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::EditorHeader, 11);
                    end;
                }
                field("lbt Editor Shipment Footer"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorFooter, 11))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Shipment Footer';
                    caption = 'Editor Shipment Footer';
                    trigger OnAssistEdit()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::Editorfooter, 11);
                    end;
                }
                field("lbt Editor Invoice Header"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorHeader, 12))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Invoice Header';
                    caption = 'Editor Invoice Header';
                    trigger OnAssistEdit()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::EditorHeader, 12);
                    end;
                }
                field("lbt Editor Invoice Footer"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorFooter, 12))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Invoice Footer';
                    caption = 'Editor Invoice Footer';
                    trigger OnAssistEdit()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::Editorfooter, 12);
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
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, Rec."Document Type".AsInteger());
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
                        Rec.lbtEditData(Enum::"lbt Position"::Editorfooter, Rec."Document Type".AsInteger());
                    end;
                }
            }
        }
    }
}
