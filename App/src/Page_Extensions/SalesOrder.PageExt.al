pageextension 5272743 "lbt Sales Order" extends "Sales Order"
{
    // version NAVW111.00.00.19846,LBCOR1.00

    layout
    {
        addlast(General)
        {
            field("lbt cl Delivery Date Type"; Rec."lbt cl Delivery Date Type")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you define the Delivery Date Type';
            }
        }
        addlast("Shipping and Billing")
        {
            field("lbt cl Destination"; Rec."lbt cl Destination")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you define the Destination.';
            }
        }
        addafter(SalesLines)
        {
            group(lbtEditor)
            {
                Caption = 'LeBit Extended Layout Options';
                field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, Rec."Document Type".AsInteger()))
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
                field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, Rec."Document Type".AsInteger()))
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
                field("lbt Editor Shipment Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, Rec."Document Type"::"lbt cl Shipment/Receipt".AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Shipment Header';
                    Caption = 'Editor Shipment Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, Rec."Document Type"::"lbt cl Shipment/Receipt".AsInteger());
                    end;
                }
                field("lbt Editor Shipment Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, Rec."Document Type"::"lbt cl Shipment/Receipt".AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Shipment Footer';
                    Caption = 'Editor Shipment Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorFooter, Rec."Document Type"::"lbt cl Shipment/Receipt".AsInteger());
                    end;
                }
                field("lbt Editor Invoice Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, Rec."Document Type"::Invoice.AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Invoice Header';
                    Caption = 'Editor Invoice Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, Rec."Document Type"::Invoice.AsInteger());
                    end;
                }
                field("lbt Editor Invoice Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, Rec."Document Type"::Invoice.AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Invoice Footer';
                    Caption = 'Editor Invoice Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorFooter, Rec."Document Type"::Invoice.AsInteger());
                    end;
                }
            }
        }
    }
    actions
    {
        addafter("O&rder")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit Extended Layout Options';
                action("lbt Tot&aling")
                {
                    ApplicationArea = All;
                    Caption = 'Totaling';
                    ToolTip = 'Creates a total of the line items "From total" / "To total"';
                    Image = Totals;
                    trigger OnAction()
                    var
                        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
                    begin
                        LeBitCorrespDocMgt.SalesLineIndentTotaling(Rec);
                    end;
                }
                action("lbt Num&bering")
                {
                    ApplicationArea = All;
                    Caption = 'Numbering';
                    ToolTip = 'Specified a numbering of the line positions"';
                    Image = NumberGroup;
                    trigger OnAction()
                    var
                        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
                    begin
                        LeBitCorrespDocMgt.SalesLinePosNumber(Rec);
                    end;
                }
                action("lbt Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text';
                    ToolTip = 'Specified the Header Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        Position: Option Header,Footer,Longtext;
                    begin
                        LongtextMgt.ShowLongtextLines(Rec, Position::Header);
                    end;
                }
                action("lbt Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Footer Text';
                    ToolTip = 'Specified the Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        Position: Option Header,Footer,Longtext;
                    begin
                        LongtextMgt.ShowLongtextLines(Rec, Position::Footer);
                    end;
                }
                action("lbt Invoice Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Header Text';
                    ToolTip = 'Specified the Invoice Header Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := SalesHeaderLRec."Document Type"::Invoice;
                        SourceRecRef.GetTable(SalesHeaderLRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Header);
                    end;
                }
                action("lbt Invoice Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Footer Text';
                    ToolTip = 'Specified the Invoice Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := SalesHeaderLRec."Document Type"::Invoice;
                        SourceRecRef.GetTable(SalesHeaderLRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Footer);
                    end;
                }
                action("lbt Shipment Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Header Text';
                    ToolTip = 'Specified the Invoice Footer Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        DocType: Enum "Sales Document Type";
                        Position: Option Header,Footer,Longtext;
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := DocType::"lbt cl Shipment/Receipt";
                        SourceRecRef.GetTable(SalesHeaderLRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Header);
                    end;
                }
                action("lbt Shipment Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Footer Text';
                    ToolTip = 'Specified the Shipment Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        DocType: Enum "Sales Document Type";
                        Position: Option Header,Footer,Longtext;
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := DocType::"lbt cl Shipment/Receipt";
                        SourceRecRef.GetTable(SalesHeaderLRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Footer);
                    end;
                }
            }
        }
    }
}
