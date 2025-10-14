pageextension 5272815 "lbt cl ServiceOrder" extends "Service Order"
{
    layout
    {
        addafter(ServItemLines)
        {
            group(lbtEditor)

            {
                Caption = 'LeBit Extended Layout Options';
                field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, Rec."Document Type"::Order.AsInteger()))
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
                field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, Rec."Document Type"::Order.AsInteger()))
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
                field("lbt Editor Shipment Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, "Sales Document Type"::"lbt cl Shipment/Receipt".AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Shipment Header';
                    Caption = 'Editor Shipment Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, "Sales Document Type"::"lbt cl Shipment/Receipt".AsInteger());
                    end;
                }
                field("lbt Editor Shipment Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, "Sales Document Type"::"lbt cl Shipment/Receipt".AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Shipment Footer';
                    Caption = 'Editor Shipment Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorFooter, "Sales Document Type"::"lbt cl Shipment/Receipt".AsInteger());
                    end;
                }
                field("lbt Editor Invoice Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, "Sales Document Type"::Invoice.AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Invoice Header';
                    Caption = 'Editor Invoice Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, "Sales Document Type"::Invoice.AsInteger());
                    end;
                }
                field("lbt Editor Invoice Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, "Sales Document Type"::Invoice.AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Invoice Footer';
                    Caption = 'Editor Invoice Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorFooter, "Sales Document Type"::Invoice.AsInteger());
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
                        Rec.lbtEditData(Enum::"lbt Position"::EditorFooter, Rec."Document Type".AsInteger());
                    end;
                }
            }
        }
    }
}
