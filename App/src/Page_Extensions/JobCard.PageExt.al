pageextension 5272832 "lbt cl JobCard" extends "Job Card"
{
    layout
    {
        addafter(JobTaskLines)
        {
            group(lbtEditor)
            {
                Caption = 'LeBit Extended Layout Options';
                field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, 0))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Header';
                    Caption = 'Editor Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, 0);
                    end;
                }
                field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, 0))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Footer';
                    Caption = 'Editor Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorFooter, 0);
                    end;
                }
                field("lbt Editor Shipment Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, Enum::"Sales Document Type"::"lbt cl Shipment/Receipt".AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Shipment Header';
                    Caption = 'Editor Shipment Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, Enum::"Sales Document Type"::"lbt cl Shipment/Receipt".AsInteger());
                    end;
                }
                field("lbt Editor Shipment Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, Enum::"Sales Document Type"::"lbt cl Shipment/Receipt".AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Shipment Footer';
                    Caption = 'Editor Shipment Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorFooter, Enum::"Sales Document Type"::"lbt cl Shipment/Receipt".AsInteger());
                    end;
                }
                field("lbt Editor Invoice Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, Enum::"Sales Document Type"::Invoice.AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Invoice Header';
                    Caption = 'Editor Invoice Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, Enum::"Sales Document Type"::Invoice.AsInteger());
                    end;
                }
                field("lbt Editor Invoice Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, Enum::"Sales Document Type"::Invoice.AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Invoice Footer';
                    Caption = 'Editor Invoice Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorFooter, Enum::"Sales Document Type"::Invoice.AsInteger());
                    end;
                }
            }
        }
    }
}
