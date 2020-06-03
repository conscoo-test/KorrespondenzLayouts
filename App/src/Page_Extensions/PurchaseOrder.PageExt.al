pageextension 5272751 "LBT Purchase Order" extends "Purchase Order"
{
    // version NAVW111.00.00.20348,NAVDACH11.00.00.20348,LBCOR1.00

    actions
    {
        addafter("O&rder")
        {
            group("LBT correspondence documents")
            {
                Caption = 'LeBit365 Correspondence layout';
                action("LBT Tot&aling")
                {
                    ApplicationArea = All;
                    Caption = 'Totaling';
                    ToolTip = 'Creates a total of the line items "From total" / "To total"';
                    Image = Totals;
                    trigger OnAction()
                    var
                        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
                    begin
                        LeBitCorrespDocMgt.PurchLineIndentTotaling(Rec);
                    end;
                }
                action("LBT Num&bering")
                {
                    ApplicationArea = All;
                    Caption = 'Numbering';
                    ToolTip = 'Specified a numbering of the line positions"';
                    Image = NumberGroup;
                    trigger OnAction()
                    var
                        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
                    begin
                        LeBitCorrespDocMgt.PurchLinePosNumber(Rec);
                    end;
                }
                action("LBT Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text';
                    ToolTip = 'Specified the Header Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
                    end;
                }
                action("LBT Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Footer Text';
                    ToolTip = 'Specified the Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Footer);
                    end;
                }
                action("LBT Invoice Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Header Text';
                    ToolTip = 'Specified the Invoice Header Text';
                    Image = Import;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
                    begin
                        PurchaseHeaderRec.TransferFields(Rec);
                        PurchaseHeaderRec."Document Type" := DocType::Invoice;
                        SourceRecRef.GETTABLE(PurchaseHeaderRec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
                    end;
                }
                action("LBT Invoice Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Footer Text';
                    ToolTip = 'Specified the Invoice Footer Text';
                    Image = Export;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
                    begin
                        PurchaseHeaderRec.TransferFields(Rec);
                        PurchaseHeaderRec."Document Type" := DocType::Invoice;
                        SourceRecRef.GETTABLE(PurchaseHeaderRec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Footer);
                    end;
                }
                action("LBT Shipment Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Header Text';
                    ToolTip = 'Specified the Shipment Header Text';
                    Image = Import;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
                    begin
                        PurchaseHeaderRec.TransferFields(Rec);
                        PurchaseHeaderRec."Document Type" := DocType::"Return Order";
                        SourceRecRef.GETTABLE(PurchaseHeaderRec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
                    end;
                }
                action("LBT Shipment Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Footer Text';
                    ToolTip = 'Specified the Shipment Footer Text';
                    Image = Export;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
                    begin
                        PurchaseHeaderRec.TransferFields(Rec);
                        PurchaseHeaderRec."Document Type" := DocType::"Return Order";
                        SourceRecRef.GETTABLE(PurchaseHeaderRec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Footer);
                    end;
                }
            }
        }
    }
}

