pageextension 5272832 "lbt cl JobCard" extends "Job Card"
{
    layout
    {
        addafter(JobTaskLines)
        {
            group(lbtEditor)
            {
                caption = 'LeBit Extended Layout Options';
                field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, 0))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Header';
                    caption = 'Editor Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, 0);
                    end;
                }
                field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, 0))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Footer';
                    caption = 'Editor Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::Editorfooter, 0);
                    end;
                }
                field("lbt Editor Shipment Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, enum::"Sales Document Type"::"lbt cl Shipment/Receipt".AsInteger()))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Shipment Header';
                    caption = 'Editor Shipment Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, enum::"Sales Document Type"::"lbt cl Shipment/Receipt".AsInteger());
                    end;
                }
                field("lbt Editor Shipment Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, enum::"Sales Document Type"::"lbt cl Shipment/Receipt".AsInteger()))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Shipment Footer';
                    caption = 'Editor Shipment Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::Editorfooter, enum::"Sales Document Type"::"lbt cl Shipment/Receipt".AsInteger());
                    end;
                }
                field("lbt Editor Invoice Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, enum::"Sales Document Type"::Invoice.AsInteger()))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Invoice Header';
                    caption = 'Editor Invoice Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, enum::"Sales Document Type"::Invoice.AsInteger());
                    end;
                }
                field("lbt Editor Invoice Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, enum::"Sales Document Type"::Invoice.AsInteger()))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Invoice Footer';
                    caption = 'Editor Invoice Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::Editorfooter, enum::"Sales Document Type"::Invoice.AsInteger());
                    end;
                }
            }
        }
    }
}
