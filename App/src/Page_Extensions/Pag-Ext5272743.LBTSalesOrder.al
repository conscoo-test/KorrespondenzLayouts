pageextension 5272743 "LBT Sales Order" extends "Sales Order"
{
    // version NAVW111.00.00.19846,LBCOR1.00

    actions
    {
        addafter(ActionGroupCRM)
        {
            group("LBT correspondence documents")
            {
                Caption = 'LIS365 Correspondence layout', Comment = 'DEU="LIS365 Korrespondenzbelege"';
                action("Tot&aling")
                {
                    ApplicationArea = All;
                    Caption = 'Totaling', Comment = 'DEU="Summieren"';
                    ToolTip = 'Creates a total of the line items "From total" / "To total"', comment = 'DEU="Legt eine Summierung der Zeilenpositionen "Von Summe" / "Bis Summe fest""';
                    Image = Totals;
                    trigger OnAction()
                    var
                        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
                    begin
                        LeBitCorrespDocMgt.SalesLineIndentTotaling(Rec);
                    end;
                }
                action("LBT Num&bering")
                {
                    ApplicationArea = All;
                    Caption = 'Numbering', Comment = 'DEU="Nummerieren"';
                    ToolTip = 'Specified a numbering of the line positions"', comment = 'DEU="Legt eine Nummerierung der Zeilenpositionen fest"';
                    Image = NumberGroup;
                    trigger OnAction()
                    var
                        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
                    begin
                        LeBitCorrespDocMgt.SalesLinePosNumber(Rec);
                    end;
                }
                action("LBT Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text', Comment = 'DEU="Kopftext"';
                    ToolTip = 'Specified the Header Text', comment = 'DEU="Legt den Kopftext fest"';
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
                    Caption = 'Footer Text', Comment = 'DEU="Fußtext"';
                    ToolTip = 'Specified the Footer Text', comment = 'DEU="Legt den Fußtext fest"';
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
                    ToolTip = 'Specified the Invoice Header Text', comment = 'DEU="Legt den Rechnungskopftext fest"';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Shipment/Receipt";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := SalesHeaderLRec."Document Type"::Invoice;
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
                    end;
                }
                action("LBT Invoice Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Footer Text', Comment = 'DEU="Rechnungsfußtext"';
                    ToolTip = 'Specified the Invoice Footer Text', comment = 'DEU="Legt den Rechnungsfußtext fest"';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Shipment/Receipt";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := SalesHeaderLRec."Document Type"::Invoice;
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Footer);
                    end;
                }
                action("LBT Shipment Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Header Text', Comment = 'DEU="Lieferungskopftext"';
                    ToolTip = 'Specified the Invoice Footer Text', comment = 'DEU="Legt den Rechnungsfußtext fest"';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Shipment/Receipt";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := DocType::"Shipment/Receipt";
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
                    end;
                }
                action("LBT Shipment Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Footer Text', Comment = 'DEU="Lieferungsfußtext"';
                    ToolTip = 'Specified the Shipment Footer Text', comment = 'DEU="Legt den Lieferungsfußtext fest"';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Shipment/Receipt";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := DocType::"Shipment/Receipt";
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Footer);
                    end;
                }
            }
        }
    }
}

