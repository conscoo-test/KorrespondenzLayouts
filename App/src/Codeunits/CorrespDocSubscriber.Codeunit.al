codeunit 5272721 "lbt Corresp. Doc. Subscriber"
{
    Permissions =
        tabledata "Sales Shipment Line" = m,
        tabledata "Sales Invoice Line" = m,
        tabledata "Sales Cr.Memo Line" = m,
        tabledata "Return Receipt Line" = m,
        tabledata "Sales Line Archive" = m,
        tabledata "Purch. Rcpt. Line" = m,
        tabledata "Purch. Inv. Line" = m,
        tabledata "Purch. Cr. Memo Line" = m,
        tabledata "Return Shipment Line" = m,
        tabledata "Purchase Line Archive" = m;

    trigger OnRun()
    begin
    end;

    var
        CorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
        CorrespDocSingleInst: Codeunit "lbt Corresp. Doc. SingleInst";
        LongtextMgt: Codeunit "lbt Longtext Mgt.";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnCalculateSalesSubPageTotalsOnAfterSetFilters', '', true, true)]
    local procedure ExcludeAlternativeAndOptional(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        SalesLine.SetFilter("lbt Printoption", '<>%1&<>%2', SalesLine."lbt Printoption"::Alternative, SalesLine."lbt Printoption"::Optional);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCreateSalesLine', '', false, false)]
    local procedure "Table Sales Header - OnAfterCreateSalesLine"(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        LongtextMgt.CopyFieldInfoAfterCreateSalesLine(SalesLine, TempSalesLine, true);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateTypeOnCopyFromTempSalesLine', '', false, false)]
    local procedure "Table Sales Line - OnValidateTypeOnCopyFromTempSalesLine"(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        SalesLine."lbt Printoption" := TempSalesLine."lbt Printoption";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnCopyFromTempSalesLine', '', false, false)]
    local procedure "Table Sales Line - OnValidateNoOnCopyFromTempSalesLine"(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        SalesLine."lbt Printoption" := TempSalesLine."lbt Printoption";
        SalesLine."lbt Pos. No." := TempSalesLine."lbt Pos. No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'lbtOnAfterCreatePurchLine', '', false, false)]
    local procedure "Table Purchase Header - OnAfterCreatePurchLine"(var PurchaseLine: Record "Purchase Line"; var TempPurchaseLine: Record "Purchase Line" temporary)
    begin
        LongtextMgt.CopyFieldInfoAfterCreatePurchLine(PurchaseLine, TempPurchaseLine, true);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateTypeOnCopyFromTempPurchLine', '', false, false)]
    local procedure "Table Purchase Line - OnValidateTypeOnCopyFromTempPurchLine"(var PurchLine: Record "Purchase Line"; TempPurchaseLine: Record "Purchase Line" temporary)
    begin
        PurchLine."lbt Printoption" := TempPurchaseLine."lbt Printoption";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateNoOnCopyFromTempPurchLine', '', false, false)]
    local procedure "Table Purchase Line - OnValidateNoOnCopyFromTempPurchLine"(var PurchLine: Record "Purchase Line"; TempPurchaseLine: Record "Purchase Line" temporary)
    begin
        PurchLine."lbt Printoption" := TempPurchaseLine."lbt Printoption";
        PurchLine."lbt Pos. No." := TempPurchaseLine."lbt Pos. No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLine', '', false, false)]
    local procedure "Table Sales Shipment Line - OnBeforeInsertInvLineFromShptLine"(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line")
    begin
        LongtextMgt.CopyLongTextForGetShipmentLines(SalesShptLine, SalesLine);
    end;

    [EventSubscriber(ObjectType::Table, database::"Purch. Rcpt. Line", 'OnBeforeInsertInvLineFromRcptLine', '', false, false)]
    local procedure "Table Purch. Rcpt. Line - OnBeforeInsertInvLineFromRcptLine"(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line")
    begin
        LongtextMgt.CopyLongTextForGetPurchRcptLines(PurchRcptLine, PurchLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc_Codeunit80(var SalesHeader: Record "Sales Header")
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        CorrespDocSingleInst.CopyLongTextForPostDropOrderShipment(PurchRcptHeader, PurchRcptLine, 0, 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc_Codeunit80(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        CorrespDocSingleInst.CopyLongTextForPostDropOrderShipment(PurchRcptHeader, PurchRcptLine, 2, 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure OnBeforeSalesInvLineInsert_Codeunit80(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line")
    begin
        LongtextMgt.CopyLongtext(SalesLine, SalesInvLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesCrMemoLineInsert', '', false, false)]
    local procedure OnBeforeSalesCrMemoLineInsert_Codeunit80(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesLine: Record "Sales Line")
    begin
        LongtextMgt.CopyLongtext(SalesLine, SalesCrMemoLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesShptHeaderInsert_Codeunit80(var SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header")
    begin
        LongtextMgt.CopyLongtext(SalesHeader, SalesShptHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeReturnRcptHeaderInsert', '', false, false)]
    local procedure OnBeforeReturnRcptHeaderInsert_Codeunit80(var ReturnRcptHeader: Record "Return Receipt Header"; SalesHeader: Record "Sales Header")
    begin
        LongtextMgt.CopyLongtext(SalesHeader, ReturnRcptHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsert_Codeunit80(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    begin
        LongtextMgt.CopyLongtext(SalesHeader, SalesInvHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesCrMemoHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesCrMemoHeaderInsert_Codeunit80(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header")
    begin
        LongtextMgt.CopyLongtext(SalesHeader, SalesCrMemoHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptLineInsert', '', false, false)]
    local procedure OnBeforeSalesShptLineInsert_Codeunit80(SalesShptLine: Record "Sales Shipment Line"; SalesLine: Record "Sales Line")
    begin
        LongtextMgt.CopyLongtext(SalesLine, SalesShptLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeReturnRcptLineInsert', '', false, false)]
    local procedure OnBeforeReturnRcptLineInsert_Codeunit80(ReturnRcptLine: Record "Return Receipt Line"; SalesLine: Record "Sales Line")
    begin
        LongtextMgt.CopyLongtext(SalesLine, ReturnRcptLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnAfterOnRun', '', false, false)]
    local procedure OnAfterOnRun_Codeunit86(SalesHeader: Record "Sales Header"; SalesOrderHeader: Record "Sales Header")
    begin
        LongtextMgt.CopyLongtext(SalesHeader, SalesOrderHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure OnBeforeInsertSalesOrderLine_Codeunit86(SalesOrderLine: Record "Sales Line"; SalesQuoteLine: Record "Sales Line")
    begin
        LongtextMgt.CopyLongtext(SalesQuoteLine, SalesOrderLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeInsertSalesOrderHeader', '', false, false)]
    local procedure OnBeforeInsertSalesOrderHeader_Codeunit87(SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesHeader: Record "Sales Header")
    begin
        LongtextMgt.CopyLongtext(BlanketOrderSalesHeader, SalesOrderHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure OnBeforeInsertSalesOrderLine_Codeunit87(SalesOrderLine: Record "Sales Line"; BlanketOrderSalesLine: Record "Sales Line")
    begin
        LongtextMgt.CopyLongtext(BlanketOrderSalesLine, SalesOrderLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc_Codeunit90(var PurchaseHeader: Record "Purchase Header")
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        CorrespDocSingleInst.CopyLongTextForPostCombineSalesOrderShipment(SalesShipmentHeader, SalesShipmentLine, 0, 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure OnAfterPostPurchaseDoc_Codeunit90(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20])
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        CorrespDocSingleInst.CopyLongTextForPostCombineSalesOrderShipment(SalesShipmentHeader, SalesShipmentLine, 2, 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchCrMemoHeaderInsert', '', false, false)]
    local procedure OnBeforePurchCrMemoHeaderInsert_Codeunit90(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PurchHeader: Record "Purchase Header")
    begin
        LongtextMgt.CopyLongtext(PurchHeader, PurchCrMemoHdr);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchCrMemoLineInsert', '', false, false)]
    local procedure OnBeforePurchCrMemoLineInsert_Codeunit90(PurchCrMemoLine: Record "Purch. Cr. Memo Line"; PurchLine: Record "Purchase Line")
    begin
        LongtextMgt.CopyLongtext(PurchLine, PurchCrMemoLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvHeaderInsert', '', false, false)]
    local procedure OnBeforePurchInvHeaderInsert_Codeunit90(PurchInvHeader: Record "Purch. Inv. Header"; PurchHeader: Record "Purchase Header")
    begin
        LongtextMgt.CopyLongtext(PurchHeader, PurchInvHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvLineInsert', '', false, false)]
    local procedure OnBeforePurchInvLineInsert_Codeunit90(PurchInvLine: Record "Purch. Inv. Line"; PurchaseLine: Record "Purchase Line")
    begin
        LongtextMgt.CopyLongtext(PurchaseLine, PurchInvLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptHeaderInsert', '', false, false)]
    local procedure OnBeforePurchRcptHeaderInsert_Codeunit90(PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchaseHeader: Record "Purchase Header")
    begin
        LongtextMgt.CopyLongtext(PurchaseHeader, PurchRcptHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptLineInsert', '', false, false)]
    local procedure OnBeforePurchRcptLineInsert_Codeunit90(PurchRcptLine: Record "Purch. Rcpt. Line"; PurchLine: Record "Purchase Line")
    begin
        LongtextMgt.CopyLongtext(PurchLine, PurchRcptLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeReturnShptHeaderInsert', '', false, false)]
    local procedure OnBeforeReturnShptHeaderInsert_Codeunit90(ReturnShptHeader: Record "Return Shipment Header"; PurchHeader: Record "Purchase Header")
    begin
        LongtextMgt.CopyLongtext(PurchHeader, ReturnShptHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeReturnShptLineInsert', '', false, false)]
    local procedure OnBeforeReturnShptLineInsert_Codeunit90(ReturnShptLine: Record "Return Shipment Line"; PurchLine: Record "Purchase Line")
    begin
        LongtextMgt.CopyLongtext(PurchLine, ReturnShptLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnCreatePurchHeaderOnBeforePurchOrderHeaderModify', '', false, false)]
    local procedure OnCreatePurchHeaderOnBeforePurchOrderHeaderModify_Codeunit96(PurchOrderHeader: Record "Purchase Header"; PurchHeader: Record "Purchase Header")
    begin
        LongtextMgt.CopyLongtext(PurchHeader, PurchOrderHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeInsertPurchOrderLine', '', false, false)]
    local procedure OnBeforeInsertPurchOrderLine_Codeunit96(PurchOrderLine: Record "Purchase Line"; PurchQuoteLine: Record "Purchase Line")
    begin
        LongtextMgt.CopyLongtext(PurchQuoteLine, PurchOrderLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Order", 'OnBeforeInsertPurchOrderHeader', '', false, false)]
    local procedure OnBeforeInsertPurchOrderHeader_Codeunit97(PurchOrderHeader: Record "Purchase Header"; BlanketOrderPurchHeader: Record "Purchase Header")
    begin
        LongtextMgt.CopyLongtext(BlanketOrderPurchHeader, PurchOrderHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Order", 'OnBeforeInsertPurchOrderLine', '', false, false)]
    local procedure OnBeforeInsertPurchOrderLine_Codeunit97(PurchOrderLine: Record "Purchase Line"; BlanketOrderPurchLine: Record "Purchase Line")
    begin
        LongtextMgt.CopyLongtext(BlanketOrderPurchLine, PurchOrderLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ArchiveManagement", 'OnAfterStoreSalesLineArchive', '', false, false)]
    local procedure OnAfterStoreSalesLineArchive(SalesLine: Record "Sales Line"; SalesLineArchive: Record "Sales Line Archive")
    begin
        LongtextMgt.CopyLongtext(SalesLine, SalesLineArchive);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterStoreSalesDocument', '', false, false)]
    local procedure OnAfterStoreSalesDocument(var SalesHeader: Record "Sales Header"; var SalesHeaderArchive: Record "Sales Header Archive");
    begin
        LongtextMgt.CopyLongtext(SalesHeader, SalesHeaderArchive);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ArchiveManagement", 'OnAfterStorePurchLineArchive', '', false, false)]
    local procedure OnAfterStorePurchLineArchive(PurchLine: Record "Purchase Line"; PurchLineArchive: Record "Purchase Line Archive")
    begin
        LongtextMgt.CopyLongtext(PurchLine, PurchLineArchive);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterStorePurchDocument', '', false, false)]
    local procedure OnAfterStorePurchDocument(var PurchaseHeader: Record "Purchase Header"; var PurchaseHeaderArchive: Record "Purchase Header Archive");
    begin
        LongtextMgt.CopyLongtext(PurchaseHeader, PurchaseHeaderArchive);
    end;

    #region Copy Document Mgt
    #region Copy Document Mgt - Header

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesHeaderArchive', '', false, false)]
    local procedure OnAfterCopySalesHeaderArchive(var ToSalesHeader: Record "Sales Header"; FromSalesHeaderArchive: Record "Sales Header Archive");
    begin
        LongtextMgt.CopyLongtext(FromSalesHeaderArchive, ToSalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPostedReturnReceipt', '', false, false)]
    local procedure OnAfterCopyPostedReturnReceipt(ToSalesHeader: Record "Sales Header"; ReturnReceiptHeader: Record "Return Receipt Header");
    begin
        LongtextMgt.CopyLongtext(ReturnReceiptHeader, ToSalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterTransferFieldsFromCrMemoToInv', '', false, false)]
    local procedure OnAfterTransferFieldsFromCrMemoToInv(ToSalesHeader: Record "Sales Header"; FromSalesCrMemoHeader: Record "Sales Cr.Memo Header");
    begin
        LongtextMgt.CopyLongtext(FromSalesCrMemoHeader, ToSalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocOnAfterTransferPostedInvoiceFields', '', false, false)]
    local procedure OnCopySalesDocOnAfterTransferPostedInvoiceFields(ToSalesHeader: Record "Sales Header"; SalesInvoiceHeader: Record "Sales Invoice Header");
    begin
        LongtextMgt.CopyLongtext(SalesInvoiceHeader, ToSalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPostedShipment', '', false, false)]
    local procedure OnAfterCopyPostedShipment(ToSalesHeader: Record "Sales Header"; FromSalesShipmentHeader: Record "Sales Shipment Header");
    begin
        LongtextMgt.CopyLongtext(FromSalesShipmentHeader, ToSalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesHeader', '', false, false)]
    local procedure OnAfterCopySalesHeader(ToSalesHeader: Record "Sales Header"; FromSalesHeader: Record "Sales Header");
    begin
        LongtextMgt.CopyLongtext(FromSalesHeader, ToSalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopyPurchDocWithHeader', '', false, false)]
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchaseHeader', '', false, false)] //TODO: use the specific event once MS changes it
    local procedure OnAfterCopyPurchaseHeader(ToPurchHeader: Record "Purchase Header"; FromDocType: Option; FromDocNo: Code[20]);
    var
        FromPurchaseHeader: Record "Purchase Header";
        CopyDocumentMgt: Codeunit "Copy Document Mgt.";
        FromDocType2: Enum "Purchase Document Type From";
    begin
        FromDocType2 := "Purchase Document Type From".FromInteger(FromDocType);
        case FromDocType2 of
            "Purchase Document Type From"::Quote,
            "Purchase Document Type From"::"Blanket Order",
            "Purchase Document Type From"::Order,
            "Purchase Document Type From"::Invoice,
            "Purchase Document Type From"::"Return Order",
            "Purchase Document Type From"::"Credit Memo":
                begin
                    FromPurchaseHeader.Get(CopyDocumentMgt.GetPurchaseDocumentType(FromDocType2), FromDocNo);
                    LongtextMgt.CopyLongtext(FromPurchaseHeader, ToPurchHeader);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPostedReceipt', '', false, false)]
    local procedure OnAfterCopyPostedReceipt(var ToPurchaseHeader: Record "Purchase Header"; FromPurchRcptHeader: Record "Purch. Rcpt. Header");
    begin
        LongtextMgt.CopyLongtext(FromPurchRcptHeader, ToPurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPostedPurchInvoice', '', false, false)]
    local procedure OnAfterCopyPostedPurchInvoice(ToPurchaseHeader: Record "Purchase Header"; FromPurchInvHeader: Record "Purch. Inv. Header");
    begin
        LongtextMgt.CopyLongtext(FromPurchInvHeader, ToPurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPostedReturnShipment', '', false, false)]
    local procedure OnAfterCopyPostedReturnShipment(var ToPurchaseHeader: Record "Purchase Header"; FromReturnShipmentHeader: Record "Return Shipment Header");
    begin
        LongtextMgt.CopyLongtext(FromReturnShipmentHeader, ToPurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchHeaderFromPostedCreditMemo', '', false, false)]
    local procedure OnAfterCopyPurchHeaderFromPostedCreditMemo(var ToPurchaseHeader: Record "Purchase Header"; FromPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.");
    begin
        LongtextMgt.CopyLongtext(FromPurchCrMemoHeader, ToPurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchHeaderArchive', '', false, false)]
    local procedure OnAfterCopyPurchHeaderArchive(var ToPurchaseHeader: Record "Purchase Header"; FromPurchaseHeaderArchive: Record "Purchase Header Archive");
    begin
        LongtextMgt.CopyLongtext(FromPurchaseHeaderArchive, ToPurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesDocument', '', false, false)]
    local procedure OnAfterCopySalesDocument_Codeunit6620(FromDocumentType: Option; FromDocumentNo: Code[20]; var ToSalesHeader: Record "Sales Header")
    begin
        CorrespDocMgt.SalesLineIndentTotaling(ToSalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchaseDocument', '', false, false)]
    local procedure OnAfterCopyPurchaseDocument_Codeunit6620(FromDocumentType: Option; FromDocumentNo: Code[20]; var ToPurchaseHeader: Record "Purchase Header")
    begin
        CorrespDocMgt.PurchLineIndentTotaling(ToPurchaseHeader);
    end;

    #endregion
    #region Copy Document Mgt - Lines

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesLineFromSalesDocSalesLine', '', false, false)]
    local procedure OnAfterCopySalesLineFromSalesDocSalesLine(ToSalesLine: Record "Sales Line"; FromSalesLine: Record "Sales Line");
    begin
        LongtextMgt.CopyLongtext(FromSalesLine, ToSalesLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesLineFromSalesShptLineBuffer', '', false, false)]
    local procedure OnAfterCopySalesLineFromSalesShptLineBuffer(ToSalesLine: Record "Sales Line"; FromSalesShipmentLine: Record "Sales Shipment Line");
    begin
        LongtextMgt.CopyLongtext(FromSalesShipmentLine, ToSalesLine);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesLineFromSalesLineBuffer', '', false, false)]
    local procedure OnAfterCopySalesLineFromSalesLineBuffer(ToSalesLine: Record "Sales Line"; FromSalesInvLine: Record "Sales Invoice Line");
    begin
        LongtextMgt.CopyLongtext(FromSalesInvLine, ToSalesLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesLineFromReturnRcptLineBuffer', '', false, false)]
    local procedure OnAfterCopySalesLineFromReturnRcptLineBuffer(ToSalesLine: Record "Sales Line"; FromReturnReceiptLine: Record "Return Receipt Line");
    begin
        LongtextMgt.CopyLongtext(FromReturnReceiptLine, ToSalesLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesLineFromSalesCrMemoLineBuffer', '', false, false)]
    local procedure OnAfterCopySalesLineFromSalesCrMemoLineBuffer(ToSalesLine: Record "Sales Line"; FromSalesCrMemoLine: Record "Sales Cr.Memo Line");
    begin
        LongtextMgt.CopyLongtext(FromSalesCrMemoLine, ToSalesLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyArchSalesLine', '', false, false)]
    local procedure OnAfterCopyArchSalesLine(ToSalesLine: Record "Sales Line"; FromSalesLineArchive: Record "Sales Line Archive");
    begin
        LongtextMgt.CopyLongtext(FromSalesLineArchive, ToSalesLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopyPurchDocPurchLineOnAfterCopyPurchLine', '', false, false)]
    local procedure OnCopyPurchDocPurchLineOnAfterCopyPurchLine(ToPurchLine: Record "Purchase Line"; FromPurchLine: Record "Purchase Line");
    begin
        LongtextMgt.CopyLongtext(FromPurchLine, ToPurchLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchRcptLine', '', false, false)]
    local procedure OnAfterCopyPurchRcptLine(ToPurchaseLine: Record "Purchase Line"; FromPurchRcptLine: Record "Purch. Rcpt. Line");
    begin
        LongtextMgt.CopyLongtext(FromPurchRcptLine, ToPurchaseLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchInvLine', '', false, false)]
    local procedure OnAfterCopyPurchInvLine(FromPurchInvLine: Record "Purch. Inv. Line"; ToPurchaseLine: Record "Purchase Line");
    begin
        LongtextMgt.CopyLongtext(FromPurchInvLine, ToPurchaseLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyReturnShptLine', '', false, false)]
    local procedure OnAfterCopyReturnShptLine(FromReturnShipmentLine: Record "Return Shipment Line"; ToPurchaseLine: Record "Purchase Line");
    begin
        LongtextMgt.CopyLongtext(FromReturnShipmentLine, ToPurchaseLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchCrMemoLine', '', false, false)]
    local procedure OnAfterCopyPurchCrMemoLine(FromPurchCrMemoLine: Record "Purch. Cr. Memo Line"; ToPurchaseLine: Record "Purchase Line");
    begin
        LongtextMgt.CopyLongtext(FromPurchCrMemoLine, ToPurchaseLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyArchPurchLine', '', false, false)]
    local procedure OnAfterCopyArchPurchLine(ToPurchaseLine: Record "Purchase Line"; FromPurchaseLineArchive: Record "Purchase Line Archive");
    begin
        LongtextMgt.CopyLongtext(FromPurchaseLineArchive, ToPurchaseLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterUpdateSalesLine', '', false, false)] //TODO:
    local procedure OnAfterUpdateSalesLine_Codeunit6620(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; var FromSalesHeader: Record "Sales Header"; var FromSalesLine: Record "Sales Line"; var CopyThisLine: Boolean; RecalculateAmount: Boolean; FromSalesDocType: Option; var CopyPostedDeferral: Boolean)
    begin
        LongtextMgt.CopyFieldInfoAfterCreateSalesLine(ToSalesLine, FromSalesLine, false);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterUpdatePurchLine', '', false, false)] //TODO
    local procedure OnAfterUpdatePurchLine_Codeunit6620(var ToPurchHeader: Record "Purchase Header"; var ToPurchLine: Record "Purchase Line"; var FromPurchHeader: Record "Purchase Header"; var FromPurchLine: Record "Purchase Line"; var CopyThisLine: Boolean; RecalculateAmount: Boolean; FromPurchDocType: Option; var CopyPostedDeferral: Boolean)
    begin
        LongtextMgt.CopyFieldInfoAfterCreatePurchLine(ToPurchLine, FromPurchLine, false);
    end;


    #endregion
    #endregion

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeRecreateSalesLines', '', false, false)]
    local procedure OnBeforeRecreateSalesLines_Table36(SalesHeader: Record "Sales Header")
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
        TempPSLongtextLine: Record "lbt PS Longtext Line" temporary;
    begin
        PSLongtextLine.SetRange("Table ID", Database::"Sales Line");
        PSLongtextLine.SetRange("Document Type", SalesHeader."Document Type");
        PSLongtextLine.SetRange("Document No.", SalesHeader."No.");
        PSLongtextLine.SetRange(Position, PSLongtextLine.Position::Longtext);
        SalesHeader.lbtTransferPSLongtextLineToTemp(PSLongtextLine, TempPSLongtextLine);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterRecreateSalesLine', '', false, false)]
    local procedure OnAfterRecreateSalesLine_Table36(SalesLine: Record "Sales Line"; TempSalesLine: Record "Sales Line")
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
        TempPSLongtextLine: Record "lbt PS Longtext Line" temporary;
    begin
        TempPSLongtextLine.SetRange("Table ID", Database::"Sales Line");
        TempPSLongtextLine.SetRange("Document Type", TempSalesLine."Document Type");
        TempPSLongtextLine.SetRange("Document No.", TempSalesLine."Document No.");
        TempPSLongtextLine.SetRange(Position, TempPSLongtextLine.Position::Longtext);
        TempPSLongtextLine.SetRange("Document Line No.", TempSalesLine."Line No.");
        if TempPSLongtextLine.FindSet() then
            repeat
                PSLongtextLine.Init();
                PSLongtextLine := TempPSLongtextLine;
                PSLongtextLine."Document Line No." := SalesLine."Line No.";
                PSLongtextLine.Insert();
            until TempPSLongtextLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeRecreatePurchLines', '', false, false)]
    local procedure OnBeforeRecreatePurchLines_Table38(var PurchHeader: Record "Purchase Header")
    var
        LeBitPSLongtextLine: Record "lbt PS Longtext Line";
        TempLeBitPSLongtextLine: Record "lbt PS Longtext Line" temporary;
    begin
        LeBitPSLongtextLine.SetRange("Table ID", Database::"Purchase Line");
        LeBitPSLongtextLine.SetRange("Document Type", PurchHeader."Document Type");
        LeBitPSLongtextLine.SetRange("Document No.", PurchHeader."No.");
        LeBitPSLongtextLine.SetRange(Position, LeBitPSLongtextLine.Position::Longtext);
        PurchHeader.lbtTransferPSLongtextLineToTemp(LeBitPSLongtextLine, TempLeBitPSLongtextLine);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterRecreatePurchLine', '', false, false)]
    local procedure OnAfterRecreatePurchLine_Table38(var PurchLine: Record "Purchase Line"; var TempPurchLine: Record "Purchase Line")
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
        TempPSLongtextLine: Record "lbt PS Longtext Line" temporary;
        PurchaseHeader: Record "Purchase Header";
    begin
        TempPSLongtextLine.SetRange("Table ID", Database::"Purchase Line");
        TempPSLongtextLine.SetRange("Document Type", TempPurchLine."Document Type");
        TempPSLongtextLine.SetRange("Document No.", TempPurchLine."Document No.");
        TempPSLongtextLine.SetRange(Position, TempPSLongtextLine.Position::Longtext);
        TempPSLongtextLine.SetRange("Document Line No.", TempPurchLine."Line No.");
        if TempPSLongtextLine.FindSet() then
            repeat
                PSLongtextLine.Init();
                PSLongtextLine := TempPSLongtextLine;
                PSLongtextLine."Document Line No." := PurchLine."Line No.";
                PSLongtextLine.Insert();
            until TempPSLongtextLine.Next() = 0;
        PurchaseHeader.lbtOnAfterCreatePurchLine(PurchLine, TempPurchLine);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterCalcVATAmountLines', '', false, false)]
    local procedure OnAfterCalcVATAmountLines_Table37(var SalesLine: Record "Sales Line"; var VATAmountLine: Record "VAT Amount Line")
    begin
        VATAmountLine."VAT Clause Code" := SalesLine."VAT Clause Code";
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lines Instruction Mgt.", 'OnAfterSetSalesLineFilters', '', false, false)]
    local procedure OnAfterSetSalesLineFilters(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header");
    begin
        SalesLine.SetFilter("lbt Printoption", '<>%1&<>%2', SalesLine."lbt Printoption"::Alternative, SalesLine."lbt Printoption"::Optional);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lines Instruction Mgt.", 'OnAfterSetPurchaseLineFilters', '', false, false)]
    local procedure OnAfterSetPurchaseLineFilters(var PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header");
    begin
        PurchaseLine.SetFilter("lbt Printoption", '<>%1&<>%2', PurchaseLine."lbt Printoption"::Alternative, PurchaseLine."lbt Printoption"::Optional);
    end;

    // H21/0758
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsert_Codeunit442(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    begin
        LongtextMgt.CopyLongtext(SalesHeader, SalesInvHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayments", 'OnBeforeSalesCrMemoHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesCrMemoHeaderInsert_Codeunit442(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header")
    begin
        LongtextMgt.CopyLongtext(SalesHeader, SalesCrMemoHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnAfterCreateSalesLine', '', false, false)]
    local procedure JobCreateInvoice_OnAfterCreateSalesLine(SalesHeader: Record "Sales Header"; Job: Record Job; var JobPlanningLine: Record "Job Planning Line"; var SalesLine: Record "Sales Line")
    begin
        LongtextMgt.CopyLongtext(JobPlanningLine, SalesLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnCreateSalesHeaderOnBeforeUpdateSalesHeader', '', false, false)]
    local procedure JobCreateInvoice_OnAfterCreateSalesInvoiceLine(SalesHeader: Record "Sales Header"; var Job: Record Job)
    begin
        LongtextMgt.CopyLongtext(Job, SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Standard Customer Sales Code", 'OnAfterCreateSalesInvoice', '', false, false)]
    local procedure StandardCustomerSalesCode_OnAfterCreateSalesInvoice(StandardCustomerSalesCode: Record "Standard Customer Sales Code"; var SalesHeader: Record "Sales Header")
    begin
        LongtextMgt.CopyLongtext(StandardCustomerSalesCode, SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Standard Customer Sales Code", 'OnBeforeApplyStdCodesToSalesLines', '', false, false)]
    local procedure StandardCustomerSalesCode_OnBeforeApplyStdCodesToSalesLines(var SalesLine: Record "Sales Line"; StdSalesLine: Record "Standard Sales Line")
    begin
        SalesLine."lbt from Standard Sales Line" := StdSalesLine.SystemId;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Standard Customer Sales Code", 'OnAfterApplyStdCodesToSalesLinesLoop', '', false, false)]
    local procedure StandardCustomerSalesCode_OnAfterApplyStdCodesToSalesLinesLoop(var SalesLine: Record "Sales Line"; StdSalesCode: Record "Standard Sales Code")
    var
        StdSalesLn: Record "Standard Sales Line";
    begin
        if SalesLine.FindSet() then
            repeat
                if not SalesLine.lbtHasEditorValue(SalesLine."Document Type".AsInteger()) then begin
                    StdSalesLn.GetBySystemId(SalesLine."lbt from Standard Sales Line");
                    LongtextMgt.CopyLongtext(StdSalesLn, SalesLine);
                end;
            until SalesLine.Next() = 0;
    end;
}

