pageextension 50751 "lbt Purchase Order" extends "Purchase Order"
{
    // version NAVW111.00.00.20348,NAVDACH11.00.00.20348,LBCOR1.00
    layout
    {
        addlast(General)
        {
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
                        LeBitCorrespDocMgt.PurchLineIndentTotaling(Rec);
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
                        LeBitCorrespDocMgt.PurchLinePosNumber(Rec);
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
                    Image = Import;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Enum "Purchase Document Type";
                    begin
                        PurchaseHeaderRec.TransferFields(Rec);
                        PurchaseHeaderRec."Document Type" := DocType::Invoice;
                        SourceRecRef.GETTABLE(PurchaseHeaderRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Header);
                    end;
                }
                action("lbt Invoice Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Footer Text';
                    ToolTip = 'Specified the Invoice Footer Text';
                    Image = Export;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Enum "Purchase Document Type";
                    begin
                        PurchaseHeaderRec.TransferFields(Rec);
                        PurchaseHeaderRec."Document Type" := DocType::Invoice;
                        SourceRecRef.GETTABLE(PurchaseHeaderRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Footer);
                    end;
                }
                action("lbt Shipment Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Header Text';
                    ToolTip = 'Specified the Shipment Header Text';
                    Image = Import;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Enum "Purchase Document Type";
                    begin
                        PurchaseHeaderRec.TransferFields(Rec);
                        PurchaseHeaderRec."Document Type" := DocType::"Return Order";
                        SourceRecRef.GETTABLE(PurchaseHeaderRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Header);
                    end;
                }
                action("lbt Shipment Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Footer Text';
                    ToolTip = 'Specified the Shipment Footer Text';
                    Image = Export;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Enum "Purchase Document Type";
                    begin
                        PurchaseHeaderRec.TransferFields(Rec);
                        PurchaseHeaderRec."Document Type" := DocType::"Return Order";
                        SourceRecRef.GETTABLE(PurchaseHeaderRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Footer);
                    end;
                }
            }
        }
    }
}

