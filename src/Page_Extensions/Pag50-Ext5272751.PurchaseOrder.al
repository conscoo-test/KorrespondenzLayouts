pageextension 5272751 "LBT Purchase Order" extends "Purchase Order"
{
    // version NAVW111.00.00.20348,NAVDACH11.00.00.20348,LBCOR1.00

    actions
    {
        addafter("O&rder")
        {
            group("LBT correspondence documents")
            {
                Caption = 'LIS365 Correspondence layout', Comment = 'DEU="LIS365 Korrespondenzbelege"';
                action("Tot&aling")
                {
                    ApplicationArea = All;
                    Caption = 'Totaling', Comment = 'DEU="Summieren"';
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
                    Caption = 'Numbering', Comment = 'DEU="Nummerieren"';
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
                    Caption = 'Header Text', Comment = 'DEU="Kopftext"';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
                    end;
                }
                action("LBT Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Footer Text', Comment = 'DEU="Kopftext"';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Footer);
                    end;
                }
                action("LBT Invoice Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Header Text', Comment = 'DEU="Rechnungskopftext"';
                    Image = Import;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
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
                    Caption = 'Invoice Footer Text', Comment = 'DEU="Rechnungsfusstext"';
                    Image = Export;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
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
                    Caption = 'Shipment Header Text', Comment = 'DEU="Lieferungskopftext"';
                    Image = Import;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
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
                    Caption = 'Shipment Footer Text', Comment = 'DEU="Lieferungsfusstext"';
                    Image = Export;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
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

