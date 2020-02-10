pageextension 5272751 "lbt Purchase Order" extends "Purchase Order"
{
    // version NAVW111.00.00.20348,NAVDACH11.00.00.20348,LBCOR1.00

    actions
    {
        addafter("O&rder")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit365 Correspondence layout', Comment = 'DEU="LeBit365 Korrespondenzbelege"';
                action("lbt Tot&aling")
                {
                    ApplicationArea = All;
                    Caption = 'Totaling', Comment = 'DEU="Summieren"';
                    ToolTip = 'Creates a total of the line items "From total" / "To total"', comment = 'DEU="Legt eine Summierung der Zeilenpositionen "Von Summe" / "Bis Summe fest""';
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
                    Caption = 'Numbering', Comment = 'DEU="Nummerieren"';
                    ToolTip = 'Specified a numbering of the line positions"', comment = 'DEU="Legt eine Nummerierung der Zeilenpositionen fest"';
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
                    Caption = 'Header Text', Comment = 'DEU="Kopftext"';
                    ToolTip = 'Specified the Header Text', comment = 'DEU="Legt den Kopftext fest"';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
                    end;
                }
                action("lbt Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Footer Text', Comment = 'DEU="Fußtext"';
                    ToolTip = 'Specified the Footer Text', comment = 'DEU="Legt den Fußtext fest"';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Footer);
                    end;
                }
                action("lbt Invoice Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Header Text', Comment = 'DEU="Rechnungskopftext"';
                    ToolTip = 'Specified the Invoice Header Text', comment = 'DEU="Legt den Rechnungskopftext fest"';
                    Image = Import;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
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
                action("lbt Invoice Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Footer Text', Comment = 'DEU="Rechnungsfusstext"';
                    ToolTip = 'Specified the Invoice Footer Text', comment = 'DEU="Legt den Rechnungsfußtext fest"';
                    Image = Export;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
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
                action("lbt Shipment Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Header Text', Comment = 'DEU="Lieferungskopftext"';
                    ToolTip = 'Specified the Shipment Header Text', comment = 'DEU="Legt den Lieferungskopftext fest"';
                    Image = Import;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
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
                action("lbt Shipment Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Footer Text', Comment = 'DEU="Lieferungsfusstext"';
                    ToolTip = 'Specified the Shipment Footer Text', comment = 'DEU="Legt den Lieferungsfußtext fest"';
                    Image = Export;

                    trigger OnAction()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
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

