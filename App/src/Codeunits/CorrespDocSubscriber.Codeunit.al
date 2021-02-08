codeunit 5272721 "LBT Corresp. Doc. Subscriber"
{
    Permissions = TableData 111 = m, TableData 113 = m, TableData 115 = m, TableData 6661 = m, TableData 5108 = m, TableData 121 = m, TableData 123 = m, TableData 125 = m, TableData 6651 = m, TableData 5110 = m;
    trigger OnRun()
    begin
    end;

    var
        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
        LeBitCorrespDocSingleInst: Codeunit "LBT Corresp. Doc. SingleInst";
        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnCalculateSalesSubPageTotalsOnAfterSetFilters', '', true, true)]
    local procedure ExcludeAlternativeAndOptional(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        with SalesLine do
            SetFilter("LBT Printoption", '<>%1&<>%2', "LBT Printoption"::Alternative, "LBT Printoption"::Optional);
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterCreateSalesLine', '', false, false)]
    local procedure "Table Sales Header - OnAfterCreateSalesLine"(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        LeBitLongtextMgt.CopyFieldInfoAfterCreateSalesLine(SalesLine, TempSalesLine, true);
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnValidateTypeOnCopyFromTempSalesLine', '', false, false)]
    local procedure "Table Sales Line - OnValidateTypeOnCopyFromTempSalesLine"(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        SalesLine."LBT Printoption" := TempSalesLine."LBT Printoption";
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnValidateNoOnCopyFromTempSalesLine', '', false, false)]
    local procedure "Table Sales Line - OnValidateNoOnCopyFromTempSalesLine"(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        SalesLine."LBT Printoption" := TempSalesLine."LBT Printoption";
        SalesLine."LBT Pos. No." := TempSalesLine."LBT Pos. No.";
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterCreatePurchLine', '', false, false)]
    local procedure "Table Purchase Header - OnAfterCreatePurchLine"(var PurchaseLine: Record "Purchase Line"; var TempPurchaseLine: Record "Purchase Line" temporary)
    begin
        LeBitLongtextMgt.CopyFieldInfoAfterCreatePurchLine(PurchaseLine, TempPurchaseLine, true);
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnValidateTypeOnCopyFromTempPurchLine', '', false, false)]
    local procedure "Table Purchase Line - OnValidateTypeOnCopyFromTempPurchLine"(var PurchLine: Record "Purchase Line"; TempPurchaseLine: Record "Purchase Line" temporary)
    begin
        PurchLine."LBT Printoption" := TempPurchaseLine."LBT Printoption";
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnValidateNoOnCopyFromTempPurchLine', '', false, false)]
    local procedure "Table Purchase Line - OnValidateNoOnCopyFromTempPurchLine"(var PurchLine: Record "Purchase Line"; TempPurchaseLine: Record "Purchase Line" temporary)
    begin
        PurchLine."LBT Printoption" := TempPurchaseLine."LBT Printoption";
        PurchLine."LBT Pos. No." := TempPurchaseLine."LBT Pos. No.";
    end;

    [EventSubscriber(ObjectType::Table, 111, 'OnBeforeInsertInvLineFromShptLine', '', false, false)]
    local procedure "Table Sales Shipment Line - OnBeforeInsertInvLineFromShptLine"(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line")
    begin
        LeBitLongtextMgt.CopyLongTextForGetShipmentLines(SalesShptLine, SalesLine);
    end;

    [EventSubscriber(ObjectType::Table, database::"Purch. Rcpt. Line", 'OnBeforeInsertInvLineFromRcptLine', '', false, false)]
    local procedure "Table Purch. Rcpt. Line - OnBeforeInsertInvLineFromRcptLine"(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line")
    begin
        LeBitLongtextMgt.CopyLongTextForGetPurchRcptLines(PurchRcptLine, PurchLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc_Codeunit80(var SalesHeader: Record "Sales Header")
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        LeBitCorrespDocSingleInst.CopyLongTextForPostDropOrderShipment(PurchRcptHeader, PurchRcptLine, 0, 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc_Codeunit80(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        LeBitCorrespDocSingleInst.CopyLongTextForPostDropOrderShipment(PurchRcptHeader, PurchRcptLine, 2, 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure OnBeforeSalesInvLineInsert_Codeunit80(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(SalesLine);
        TargetRecRef.GETTABLE(SalesInvLine);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesCrMemoLineInsert', '', false, false)]
    local procedure OnBeforeSalesCrMemoLineInsert_Codeunit80(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesLine: Record "Sales Line")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(SalesLine);
        TargetRecRef.GETTABLE(SalesCrMemoLine);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesShptHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesShptHeaderInsert_Codeunit80(var SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(SalesHeader);
        TargetRecRef.GETTABLE(SalesShptHeader);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeReturnRcptHeaderInsert', '', false, false)]
    local procedure OnBeforeReturnRcptHeaderInsert_Codeunit80(var ReturnRcptHeader: Record "Return Receipt Header"; SalesHeader: Record "Sales Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(SalesHeader);
        TargetRecRef.GETTABLE(ReturnRcptHeader);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsert_Codeunit80(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(SalesHeader);
        TargetRecRef.GETTABLE(SalesInvHeader);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesCrMemoHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesCrMemoHeaderInsert_Codeunit80(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(SalesHeader);
        TargetRecRef.GETTABLE(SalesCrMemoHeader);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesShptLineInsert', '', false, false)]
    local procedure OnBeforeSalesShptLineInsert_Codeunit80(var SalesShptLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(SalesLine);
        TargetRecRef.GETTABLE(SalesShptLine);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeReturnRcptLineInsert', '', false, false)]
    local procedure OnBeforeReturnRcptLineInsert_Codeunit80(var ReturnRcptLine: Record "Return Receipt Line"; ReturnRcptHeader: Record "Return Receipt Header"; SalesLine: Record "Sales Line")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(SalesLine);
        TargetRecRef.GETTABLE(ReturnRcptLine);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 86, 'OnAfterOnRun', '', false, false)]
    local procedure OnAfterOnRun_Codeunit86(var SalesHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(SalesHeader);
        TargetRecRef.GETTABLE(SalesOrderHeader);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 86, 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure OnBeforeInsertSalesOrderLine_Codeunit86(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(SalesQuoteLine);
        TargetRecRef.GETTABLE(SalesOrderLine);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 87, 'OnBeforeInsertSalesOrderHeader', '', false, false)]
    local procedure OnBeforeInsertSalesOrderHeader_Codeunit87(var SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesHeader: Record "Sales Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(BlanketOrderSalesHeader);
        TargetRecRef.GETTABLE(SalesOrderHeader);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 87, 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure OnBeforeInsertSalesOrderLine_Codeunit87(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesLine: Record "Sales Line"; BlanketOrderSalesHeader: Record "Sales Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(BlanketOrderSalesLine);
        TargetRecRef.GETTABLE(SalesOrderLine);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc_Codeunit90(var PurchaseHeader: Record "Purchase Header")
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        LeBitCorrespDocSingleInst.CopyLongTextForPostCombineSalesOrderShipment(SalesShipmentHeader, SalesShipmentLine, 0, 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure OnAfterPostPurchaseDoc_Codeunit90(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20])
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        LeBitCorrespDocSingleInst.CopyLongTextForPostCombineSalesOrderShipment(SalesShipmentHeader, SalesShipmentLine, 2, 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePurchCrMemoHeaderInsert', '', false, false)]
    local procedure OnBeforePurchCrMemoHeaderInsert_Codeunit90(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchHeader: Record "Purchase Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(PurchHeader);
        TargetRecRef.GETTABLE(PurchCrMemoHdr);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePurchCrMemoLineInsert', '', false, false)]
    local procedure OnBeforePurchCrMemoLineInsert_Codeunit90(var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLine: Record "Purchase Line")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(PurchLine);
        TargetRecRef.GETTABLE(PurchCrMemoLine);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePurchInvHeaderInsert', '', false, false)]
    local procedure OnBeforePurchInvHeaderInsert_Codeunit90(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchHeader: Record "Purchase Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(PurchHeader);
        TargetRecRef.GETTABLE(PurchInvHeader);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePurchInvLineInsert', '', false, false)]
    local procedure OnBeforePurchInvLineInsert_Codeunit90(var PurchInvLine: Record "Purch. Inv. Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchaseLine: Record "Purchase Line")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(PurchaseLine);
        TargetRecRef.GETTABLE(PurchInvLine);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePurchRcptHeaderInsert', '', false, false)]
    local procedure OnBeforePurchRcptHeaderInsert_Codeunit90(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(PurchaseHeader);
        TargetRecRef.GETTABLE(PurchRcptHeader);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePurchRcptLineInsert', '', false, false)]
    local procedure OnBeforePurchRcptLineInsert_Codeunit90(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchLine: Record "Purchase Line")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(PurchLine);
        TargetRecRef.GETTABLE(PurchRcptLine);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforeReturnShptHeaderInsert', '', false, false)]
    local procedure OnBeforeReturnShptHeaderInsert_Codeunit90(var ReturnShptHeader: Record "Return Shipment Header"; var PurchHeader: Record "Purchase Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(PurchHeader);
        TargetRecRef.GETTABLE(ReturnShptHeader);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforeReturnShptLineInsert', '', false, false)]
    local procedure OnBeforeReturnShptLineInsert_Codeunit90(var ReturnShptLine: Record "Return Shipment Line"; var ReturnShptHeader: Record "Return Shipment Header"; var PurchLine: Record "Purchase Line")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(PurchLine);
        TargetRecRef.GETTABLE(ReturnShptLine);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 96, 'OnBeforeInsertPurchOrderHeader', '', false, false)]
    local procedure OnBeforeInsertPurchOrderHeader_Codeunit96(var PurchOrderHeader: Record "Purchase Header"; PurchQuoteHeader: Record "Purchase Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(PurchQuoteHeader);
        TargetRecRef.GETTABLE(PurchOrderHeader);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 96, 'OnBeforeInsertPurchOrderLine', '', false, false)]
    local procedure OnBeforeInsertPurchOrderLine_Codeunit96(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; PurchQuoteLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(PurchQuoteLine);
        TargetRecRef.GETTABLE(PurchOrderLine);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 97, 'OnBeforeInsertPurchOrderHeader', '', false, false)]
    local procedure OnBeforeInsertPurchOrderHeader_Codeunit97(var PurchOrderHeader: Record "Purchase Header"; BlanketOrderPurchHeader: Record "Purchase Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(BlanketOrderPurchHeader);
        TargetRecRef.GETTABLE(PurchOrderHeader);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 97, 'OnBeforeInsertPurchOrderLine', '', false, false)]
    local procedure OnBeforeInsertPurchOrderLine_Codeunit97(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; BlanketOrderPurchLine: Record "Purchase Line"; BlanketOrderPurchHeader: Record "Purchase Header")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(BlanketOrderPurchLine);
        TargetRecRef.GETTABLE(PurchOrderLine);
        LeBitLongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, 5063, 'OnAfterStoreSalesLineArchive', '', false, false)]
    local procedure OnAfterStoreSalesLineArchive_Codeunit5063(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var SalesHeaderArchive: Record "Sales Header Archive"; var SalesLineArchive: Record "Sales Line Archive")
    begin
        LeBitLongtextMgt.CopyLongTextForSalesArchivMgt(SalesHeader, SalesLine, SalesHeaderArchive, SalesLineArchive);
    end;

    [EventSubscriber(ObjectType::Codeunit, 5063, 'OnAfterStorePurchLineArchive', '', false, false)]
    local procedure OnAfterStorePurchLineArchive_Codeunit5063(var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var PurchHeaderArchive: Record "Purchase Header Archive"; var PurchLineArchive: Record "Purchase Line Archive")
    begin
        LeBitLongtextMgt.CopyLongTextForPurchArchivMgt(PurchHeader, PurchLine, PurchHeaderArchive, PurchLineArchive);
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnCopySalesDocWithHeader', '', false, false)]
    local procedure OnCopySalesDocWithHeader_Codeunit6620(FromDocType: Option; FromDocNo: Code[20]; var ToSalesHeader: Record "Sales Header")
    begin
        LeBitCorrespDocSingleInst.SetWithSalesHeader(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnAfterUpdateSalesLine', '', false, false)]
    local procedure OnAfterUpdateSalesLine_Codeunit6620(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; var FromSalesHeader: Record "Sales Header"; var FromSalesLine: Record "Sales Line"; var CopyThisLine: Boolean; RecalculateAmount: Boolean; FromSalesDocType: Option; var CopyPostedDeferral: Boolean)
    begin
        LeBitLongtextMgt.CopyLongTextForSalesCopyMgt(ToSalesHeader, ToSalesLine, FromSalesHeader, FromSalesLine, CopyThisLine, FromSalesDocType, LeBitCorrespDocSingleInst.GetWithSalesHeader());
        LeBitCorrespDocSingleInst.SetWithSalesHeader(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnBeforeModifyPurchHeader', '', false, false)]
    local procedure OnBeforeModifyPurchHeader_Codeunit6620(var ToPurchHeader: Record "Purchase Header"; FromDocType: Option; FromDocNo: Code[20]; IncludeHeader: Boolean)
    begin
        LeBitCorrespDocSingleInst.SetWithPurchHeader(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnAfterUpdatePurchLine', '', false, false)]
    local procedure OnAfterUpdatePurchLine_Codeunit6620(var ToPurchHeader: Record "Purchase Header"; var ToPurchLine: Record "Purchase Line"; var FromPurchHeader: Record "Purchase Header"; var FromPurchLine: Record "Purchase Line"; var CopyThisLine: Boolean; RecalculateAmount: Boolean; FromPurchDocType: Option; var CopyPostedDeferral: Boolean)
    begin
        LeBitLongtextMgt.CopyLongTextForPurchCopyMgt(ToPurchHeader, ToPurchLine, FromPurchHeader, FromPurchLine, CopyThisLine, FromPurchDocType, LeBitCorrespDocSingleInst.GetWithPurchHeader());
        LeBitCorrespDocSingleInst.SetWithPurchHeader(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnAfterCopySalesDocument', '', false, false)]
    local procedure OnAfterCopySalesDocument_Codeunit6620(FromDocumentType: Option; FromDocumentNo: Code[20]; var ToSalesHeader: Record "Sales Header")
    begin
        LeBitCorrespDocMgt.SalesLineIndentTotaling(ToSalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnAfterCopyPurchaseDocument', '', false, false)]
    local procedure OnAfterCopyPurchaseDocument_Codeunit6620(FromDocumentType: Option; FromDocumentNo: Code[20]; var ToPurchaseHeader: Record "Purchase Header")
    begin
        LeBitCorrespDocMgt.PurchLineIndentTotaling(ToPurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeRecreateSalesLines', '', false, false)]
    local procedure OnBeforeRecreateSalesLines_Table36(VAR SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        LeBitPSLongtextLine: Record "LBT PS Longtext Line";
        TempLeBitPSLongtextLine: Record "LBT PS Longtext Line" temporary;
    begin
        with SalesHeader do begin
            SalesLine.Reset();
            SalesLine.SetRange("Document Type", "Document Type");
            SalesLine.SetRange("Document No.", "No.");
            if SalesLine.FindSet() then begin
                LeBitPSLongtextLine.SetRange("Table ID", Database::"Sales Line");
                LeBitPSLongtextLine.SetRange("Document Type", SalesLine."Document Type");
                LeBitPSLongtextLine.SetRange("Document No.", SalesLine."Document No.");
                LeBitPSLongtextLine.SetRange(Position, LeBitPSLongtextLine.Position::Longtext);
                LeBitTransferPSLongtextLineToTemp(LeBitPSLongtextLine, TempLeBitPSLongtextLine);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterRecreateSalesLine', '', false, false)]
    local procedure OnAfterRecreateSalesLine_Table36(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line")
    var
        LeBitPSLongtextLine: Record "LBT PS Longtext Line";
        TempLeBitPSLongtextLine: Record "LBT PS Longtext Line" temporary;
    begin
        TempLeBitPSLongtextLine.SetRange("Table ID", Database::"Sales Line");
        TempLeBitPSLongtextLine.SetRange("Document Type", TempSalesLine."Document Type");
        TempLeBitPSLongtextLine.SetRange("Document No.", TempSalesLine."Document No.");
        TempLeBitPSLongtextLine.SetRange(Position, TempLeBitPSLongtextLine.Position::Longtext);
        TempLeBitPSLongtextLine.SetRange("Document Line No.", TempSalesLine."Line No.");
        if TempLeBitPSLongtextLine.FindSet() then
            repeat
                LeBitPSLongtextLine.Init();
                LeBitPSLongtextLine := TempLeBitPSLongtextLine;
                LeBitPSLongtextLine."Document Line No." := SalesLine."Line No.";
                LeBitPSLongtextLine.Insert();
            until TempLeBitPSLongtextLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeRecreatePurchLines', '', false, false)]
    local procedure OnBeforeRecreatePurchLines_Table38(var PurchHeader: Record "Purchase Header")
    var
        LeBitPSLongtextLine: Record "LBT PS Longtext Line";
        TempLeBitPSLongtextLine: Record "LBT PS Longtext Line" temporary;
    begin
        with PurchHeader do begin
            LeBitPSLongtextLine.SetRange("Table ID", Database::"Purchase Line");
            LeBitPSLongtextLine.SetRange("Document Type", PurchHeader."Document Type");
            LeBitPSLongtextLine.SetRange("Document No.", PurchHeader."No.");
            LeBitPSLongtextLine.SetRange(Position, LeBitPSLongtextLine.Position::Longtext);
            LeBitTransferPSLongtextLineToTemp(LeBitPSLongtextLine, TempLeBitPSLongtextLine);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterRecreatePurchLine', '', false, false)]
    local procedure OnAfterRecreatePurchLine_Table38(var PurchLine: Record "Purchase Line"; var TempPurchLine: Record "Purchase Line")
    var
        LeBitPSLongtextLine: Record "LBT PS Longtext Line";
        TempLeBitPSLongtextLine: Record "LBT PS Longtext Line" temporary;
        PurchHeader: Record "Purchase Header";
    begin
        with TempPurchLine do begin
            TempLeBitPSLongtextLine.SetRange("Table ID", Database::"Purchase Line");
            TempLeBitPSLongtextLine.SetRange("Document Type", TempPurchLine."Document Type");
            TempLeBitPSLongtextLine.SetRange("Document No.", TempPurchLine."Document No.");
            TempLeBitPSLongtextLine.SetRange(Position, TempLeBitPSLongtextLine.Position::Longtext);
            TempLeBitPSLongtextLine.SetRange("Document Line No.", TempPurchLine."Line No.");
            if TempLeBitPSLongtextLine.FindSet() then
                repeat
                    LeBitPSLongtextLine.Init();
                    LeBitPSLongtextLine := TempLeBitPSLongtextLine;
                    LeBitPSLongtextLine."Document Line No." := PurchLine."Line No.";
                    LeBitPSLongtextLine.Insert();
                until TempLeBitPSLongtextLine.Next() = 0;
            PurchHeader.OnAfterCreatePurchLine(PurchLine, TempPurchLine);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterCalcVATAmountLines', '', false, false)]
    local procedure OnAfterCalcVATAmountLines_Table37(var SalesLine: Record "Sales Line"; var VATAmountLine: Record "VAT Amount Line")
    begin
        with SalesLine do
            VATAmountLine."VAT Clause Code" := "VAT Clause Code";

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopyArchSalesLineOnAfterToSalesLineInsert', '', false, false)]
    local procedure OnCopyArchSalesLineOnAfterToSalesLineInsert_Codeunit6620(FromSalesLineArchive: Record "Sales Line Archive"; var ToSalesLine: Record "Sales Line")
    var
        FromSalesHeader: Record "Sales Header";
        FromSalesLine: Record "Sales Line";
        FromSalesHeaderArchive: Record "Sales Header Archive";
        ToSalesHeader: Record "Sales Header";
        SalesDocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
        DummyCopyThisLine: Boolean;
    begin
        DummyCopyThisLine := true;
        FromSalesHeaderArchive.Get(FromSalesLineArchive."Document Type", FromSalesLineArchive."document No.", FromSalesLineArchive."Doc. No. Occurrence", FromSalesLineArchive."Version No.");
        ToSalesHeader.get(ToSalesLine."Document Type", ToSalesLine."Document No.");
        FromSalesHeader.TransferFields(FromSalesHeaderArchive);
        FromSalesLine.TransferFields(FromSalesLineArchive);
        case FromSalesHeaderArchive."Document Type" of
            FromSalesHeaderArchive."Document Type"::"Blanket Order":
                SalesDocType := SalesDocType::"Arch. Blanket Order";
            FromSalesHeaderArchive."Document Type"::Order:
                SalesDocType := SalesDocType::"Arch. Order";
            FromSalesHeaderArchive."Document Type"::Quote:
                SalesDocType := SalesDocType::"Arch. Quote";
            FromSalesHeaderArchive."Document Type"::"Return Order":
                SalesDocType := SalesDocType::"Arch. Return Order";
        end;
        LeBitCorrespDocMgt.SetGetSalesArchivValues(FromSalesHeaderArchive."Doc. No. Occurrence", FromSalesHeaderArchive."Version No.");
        LeBitLongtextMgt.CopyLongTextForSalesCopyMgt(ToSalesHeader, ToSalesLine, FromSalesHeader, FromSalesLine, DummyCopyThisLine, SalesDocType, LeBitCorrespDocSingleInst.GetWithSalesHeader());
        LeBitCorrespDocSingleInst.SetWithSalesHeader(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnCopyArchPurchLineOnAfterToPurchLineInsert', '', false, false)]
    local procedure OnCopyArchPurchLineOnAfterToPurchLineInsert_Codeunit6620(FromPurchLineArchive: Record "Purchase Line Archive"; var ToPurchLine: Record "Purchase Line")
    var
        FromPurchaseHeader: Record "Purchase Header";
        FromPurchaseLine: Record "Purchase Line";
        FromPurchaseHeaderArchive: Record "Purchase Header Archive";
        ToPurchHeader: Record "Purchase Header";
        PurchDocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Receipt","Posted Invoice","Posted Return Shipment","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
        DummyCopyThisLine: Boolean;
    begin
        DummyCopyThisLine := true;
        FromPurchaseHeaderArchive.Get(FromPurchLineArchive."Document Type", FromPurchLineArchive."document No.", FromPurchLineArchive."Doc. No. Occurrence", FromPurchLineArchive."Version No.");
        ToPurchHeader.get(ToPurchLine."Document Type", ToPurchLine."Document No.");
        FromPurchaseHeader.TransferFields(FromPurchaseHeaderArchive);
        FromPurchaseLine.TransferFields(FromPurchLineArchive);
        case FromPurchaseHeaderArchive."Document Type" of
            FromPurchaseHeaderArchive."Document Type"::"Blanket Order":
                PurchDocType := PurchDocType::"Arch. Blanket Order";
            FromPurchaseHeaderArchive."Document Type"::Order:
                PurchDocType := PurchDocType::"Arch. Order";
            FromPurchaseHeaderArchive."Document Type"::Quote:
                PurchDocType := PurchDocType::"Arch. Quote";
            FromPurchaseHeaderArchive."Document Type"::"Return Order":
                PurchDocType := PurchDocType::"Arch. Return Order";
        end;
        LeBitCorrespDocMgt.SetGetPurchArchivValues(FromPurchaseHeaderArchive."Doc. No. Occurrence", FromPurchaseHeaderArchive."Version No.");
        LeBitLongtextMgt.CopyLongTextForPurchCopyMgt(ToPurchHeader, ToPurchLine, FromPurchaseHeader, FromPurchaseLine, DummyCopyThisLine, PurchDocType, LeBitCorrespDocSingleInst.GetWithPurchHeader());
        LeBitCorrespDocSingleInst.SetWithPurchHeader(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesDocument', '', false, false)]
    local procedure OnBeforeCopySalesDocument_Codeunit6620(FromDocumentType: Option; FromDocumentNo: Code[20]; var ToSalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        ReturnReceiptLine: Record "Return Receipt Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesLineArchive: Record "Sales Line Archive";
        SalesDocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
    begin
        case FromDocumentType of
            SalesDocType::Quote,
            SalesDocType::"Blanket Order",
            SalesDocType::Order,
            SalesDocType::Invoice,
            SalesDocType::"Return Order",
            SalesDocType::"Credit Memo":
                begin
                    case FromDocumentType of
                        SalesDocType::Quote:
                            SalesLine.SetRange("Document Type", SalesLine."Document Type"::Quote);
                        SalesDocType::"Blanket Order":
                            SalesLine.SetRange("Document Type", SalesLine."Document Type"::"Blanket Order");
                        SalesDocType::Order:
                            SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                        SalesDocType::Invoice:
                            SalesLine.SetRange("Document Type", SalesLine."Document Type"::Invoice);
                        SalesDocType::"Return Order":
                            SalesLine.SetRange("Document Type", SalesLine."Document Type"::"Return Order");
                        SalesDocType::"Credit Memo":
                            SalesLine.SetRange("Document Type", SalesLine."Document Type"::"Credit Memo");
                    end;
                    SalesLine.SetRange("Document No.", FromDocumentNo);
                    IF SalesLine.FindSet() then
                        repeat
                            SalesLine."LBT Source Document Line No." := SalesLine."Line No.";
                            SalesLine.modify();
                        until SalesLine.Next() = 0;
                end;
            SalesDocType::"Posted Shipment":
                begin
                    SalesShipmentLine.SetRange("Document No.", FromDocumentNo);
                    IF SalesShipmentLine.FindSet() then
                        repeat
                            SalesShipmentLine."LBT Source Document Line No." := SalesShipmentLine."Line No.";
                            SalesShipmentLine.modify();
                        until SalesShipmentLine.Next() = 0;
                end;
            SalesDocType::"Posted Invoice":
                begin
                    SalesInvoiceLine.SetRange("Document No.", FromDocumentNo);
                    IF SalesInvoiceLine.FindSet() then
                        repeat
                            SalesInvoiceLine."LBT Source Document Line No." := SalesInvoiceLine."Line No.";
                            SalesInvoiceLine.modify();
                        until SalesInvoiceLine.Next() = 0;
                end;
            SalesDocType::"Posted Return Receipt":
                begin
                    ReturnReceiptLine.SetRange("Document No.", FromDocumentNo);
                    IF ReturnReceiptLine.FindSet() then
                        repeat
                            ReturnReceiptLine."LBT Source Document Line No." := ReturnReceiptLine."Line No.";
                            ReturnReceiptLine.modify();
                        until ReturnReceiptLine.Next() = 0;
                end;
            SalesDocType::"Posted Credit Memo":
                begin
                    SalesCrMemoLine.SetRange("Document No.", FromDocumentNo);
                    IF SalesCrMemoLine.FindSet() then
                        repeat
                            SalesCrMemoLine."LBT Source Document Line No." := SalesCrMemoLine."Line No.";
                            SalesCrMemoLine.modify();
                        until SalesCrMemoLine.Next() = 0;
                end;
            SalesDocType::"Arch. Quote",
            SalesDocType::"Arch. Order",
            SalesDocType::"Arch. Blanket Order",
            SalesDocType::"Arch. Return Order":
                begin
                    case FromDocumentType of
                        SalesDocType::"Arch. Quote":
                            SalesLineArchive.SetRange("Document Type", SalesLineArchive."Document Type"::Quote);
                        SalesDocType::"Arch. Order":
                            SalesLineArchive.SetRange("Document Type", SalesLineArchive."Document Type"::Order);
                        SalesDocType::"Arch. Blanket Order":
                            SalesLineArchive.SetRange("Document Type", SalesLineArchive."Document Type"::"Blanket Order");
                        SalesDocType::"Arch. Return Order":
                            SalesLineArchive.SetRange("Document Type", SalesLineArchive."Document Type"::"Return Order");
                    end;
                    SalesLineArchive.SetRange("Document No.", FromDocumentNo);
                    IF SalesLineArchive.FindSet() then
                        repeat
                            SalesLineArchive."LBT Source Document Line No." := SalesLineArchive."Line No.";
                            SalesLineArchive.modify();
                        until SalesLineArchive.Next() = 0;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCopyPurchaseDocument', '', false, false)]
    local procedure OnBeforeCopyPurchaseDocument_Codeunit6620(FromDocumentType: Option; FromDocumentNo: Code[20]; var ToPurchaseHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchInvLine: Record "Purch. Inv. Line";
        ReturnShipmentLine: Record "Return Shipment Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        PurchLineArchive: Record "Purchase Line Archive";
        PurchDocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Receipt","Posted Invoice","Posted Return Shipment","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
    begin
        case FromDocumentType of
            PurchDocType::Quote,
            PurchDocType::"Blanket Order",
            PurchDocType::Order,
            PurchDocType::Invoice,
            PurchDocType::"Return Order",
            PurchDocType::"Credit Memo":
                begin
                    case FromDocumentType of
                        PurchDocType::Quote:
                            PurchLine.SetRange("Document Type", PurchLine."Document Type"::Quote);
                        PurchDocType::"Blanket Order":
                            PurchLine.SetRange("Document Type", PurchLine."Document Type"::"Blanket Order");
                        PurchDocType::Order:
                            PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                        PurchDocType::Invoice:
                            PurchLine.SetRange("Document Type", PurchLine."Document Type"::Invoice);
                        PurchDocType::"Return Order":
                            PurchLine.SetRange("Document Type", PurchLine."Document Type"::"Return Order");
                        PurchDocType::"Credit Memo":
                            PurchLine.SetRange("Document Type", PurchLine."Document Type"::"Credit Memo");
                    end;
                    PurchLine.SetRange("Document No.", FromDocumentNo);
                    IF PurchLine.FindSet() then
                        repeat
                            PurchLine."LBT Source Document Line No." := PurchLine."Line No.";
                            PurchLine.modify();
                        until PurchLine.Next() = 0;
                end;
            PurchDocType::"Posted Receipt":
                begin
                    PurchRcptLine.SetRange("Document No.", FromDocumentNo);
                    IF PurchRcptLine.FindSet() then
                        repeat
                            PurchRcptLine."LBT Source Document Line No." := PurchRcptLine."Line No.";
                            PurchRcptLine.modify();
                        until PurchRcptLine.Next() = 0;
                end;
            PurchDocType::"Posted Invoice":
                begin
                    PurchInvLine.SetRange("Document No.", FromDocumentNo);
                    IF PurchInvLine.FindSet() then
                        repeat
                            PurchInvLine."LBT Source Document Line No." := PurchInvLine."Line No.";
                            PurchInvLine.modify();
                        until PurchInvLine.Next() = 0;
                end;
            PurchDocType::"Posted Return Shipment":
                begin
                    ReturnShipmentLine.SetRange("Document No.", FromDocumentNo);
                    IF ReturnShipmentLine.FindSet() then
                        repeat
                            ReturnShipmentLine."LBT Source Document Line No." := ReturnShipmentLine."Line No.";
                            ReturnShipmentLine.modify();
                        until ReturnShipmentLine.Next() = 0;
                end;
            PurchDocType::"Posted Credit Memo":
                begin
                    PurchCrMemoLine.SetRange("Document No.", FromDocumentNo);
                    IF PurchCrMemoLine.FindSet() then
                        repeat
                            PurchCrMemoLine."LBT Source Document Line No." := PurchCrMemoLine."Line No.";
                            PurchCrMemoLine.modify();
                        until PurchCrMemoLine.Next() = 0;
                end;
            PurchDocType::"Arch. Quote",
            PurchDocType::"Arch. Order",
            PurchDocType::"Arch. Blanket Order",
            PurchDocType::"Arch. Return Order":
                begin
                    case FromDocumentType of
                        PurchDocType::"Arch. Quote":
                            PurchLineArchive.SetRange("Document Type", PurchLineArchive."Document Type"::Quote);
                        PurchDocType::"Arch. Order":
                            PurchLineArchive.SetRange("Document Type", PurchLineArchive."Document Type"::Order);
                        PurchDocType::"Arch. Blanket Order":
                            PurchLineArchive.SetRange("Document Type", PurchLineArchive."Document Type"::"Blanket Order");
                        PurchDocType::"Arch. Return Order":
                            PurchLineArchive.SetRange("Document Type", PurchLineArchive."Document Type"::"Return Order");
                    end;
                    PurchLineArchive.SetRange("Document No.", FromDocumentNo);
                    IF PurchLineArchive.FindSet() then
                        repeat
                            PurchLineArchive."LBT Source Document Line No." := PurchLineArchive."Line No.";
                            PurchLineArchive.modify();
                        until PurchLineArchive.Next() = 0;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnAfterFillInvLineBuffer', '', false, false)]
    local procedure OnAfterFillInvLineBuffer(var PrepmtInvLineBuf: Record "Prepayment Inv. Line Buffer"; SalesLine: Record "Sales Line");
    begin
        PrepmtInvLineBuf."lbt Indentation" := SalesLine."lbt Indentation";
        PrepmtInvLineBuf."lbt Pos. No." := SalesLine."lbt Pos. No.";
        PrepmtInvLineBuf."lbt Printoption" := SalesLine."lbt Printoption";
        PrepmtInvLineBuf."lbt Summation" := SalesLine."lbt Summation";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; PrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; CommitIsSuppressed: Boolean);
    begin
        SalesInvLine."lbt Indentation" := PrepmtInvLineBuffer."lbt Indentation";
        SalesInvLine."lbt Pos. No." := PrepmtInvLineBuffer."lbt Pos. No.";
        SalesInvLine."lbt Printoption" := PrepmtInvLineBuffer."lbt Printoption";
        SalesInvLine."lbt Summation" := PrepmtInvLineBuffer."lbt Summation";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeSalesCrMemoLineInsert', '', false, false)]
    local procedure OnBeforeSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; PrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer"; CommitIsSuppressed: Boolean);
    begin
        SalesCrMemoLine."lbt Indentation" := PrepmtInvLineBuffer."lbt Indentation";
        SalesCrMemoLine."lbt Pos. No." := PrepmtInvLineBuffer."lbt Pos. No.";
        SalesCrMemoLine."lbt Printoption" := PrepmtInvLineBuffer."lbt Printoption";
        SalesCrMemoLine."lbt Summation" := PrepmtInvLineBuffer."lbt Summation";
    end;

}

