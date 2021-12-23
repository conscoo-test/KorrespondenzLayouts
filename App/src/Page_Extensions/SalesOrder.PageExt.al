pageextension 50743 "lbt Sales Order" extends "Sales Order"
{
    // version NAVW111.00.00.19846,LBCOR1.00

    layout
    {
        addafter(SalesLines)
        {
            group(lbtEditor)
            {
                caption = 'Longtext';
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
                field("lbt Editor Shipment Header"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorHeader, rec."Document Type"::"Shipment/Receipt".AsInteger()))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Shipment Header';
                    caption = 'Editor Shipment Header';
                    trigger OnAssistEdit()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::EditorHeader, rec."Document Type"::"Shipment/Receipt".AsInteger());
                    end;
                }
                field("lbt Editor Shipment Footer"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorFooter, rec."Document Type"::"Shipment/Receipt".AsInteger()))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Shipment Footer';
                    caption = 'Editor Shipment Footer';
                    trigger OnAssistEdit()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::Editorfooter, rec."Document Type"::"Shipment/Receipt".AsInteger());
                    end;
                }
                field("lbt Editor Invoice Header"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorHeader, rec."Document Type"::Invoice.AsInteger()))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Invoice Header';
                    caption = 'Editor Invoice Header';
                    trigger OnAssistEdit()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::EditorHeader, rec."Document Type"::Invoice.AsInteger());
                    end;
                }
                field("lbt Editor Invoice Footer"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorFooter, rec."Document Type"::Invoice.AsInteger()))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Invoice Footer';
                    caption = 'Editor Invoice Footer';
                    trigger OnAssistEdit()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::Editorfooter, rec."Document Type"::Invoice.AsInteger());
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
                Caption = 'LeBit365 Correspondence layout';
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
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
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
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
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
                        Position: Option Header,Footer,Longtext;
                        DocType: Enum "Sales Document Type";
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := DocType::"Shipment/Receipt";
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
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
                        Position: Option Header,Footer,Longtext;
                        DocType: Enum "Sales Document Type";
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := DocType::"Shipment/Receipt";
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Footer);
                    end;
                }
            }
        }
    }
}

