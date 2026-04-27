codeunit 5272733 "lbt cl Subscribers"
{

    local procedure ShouldRunAutomaticNumbering(DocumentType: Enum "Purchase Document Type"): Boolean
    var
        CorrSetup: Record "lbt Corr Setup";
    begin
        CorrSetup.Get();
        case DocumentType of
            "Purchase Document Type"::Quote:
                exit(CorrSetup."P.Quote Automatic Numbering");
            "Purchase Document Type"::Order:
                exit(CorrSetup."P.Order Automatic Numbering");
            "Purchase Document Type"::Invoice:
                exit(CorrSetup."P.Invoice Automatic Numbering");
            "Purchase Document Type"::"Credit Memo":
                exit(CorrSetup."P.Credit Memo Automatic Numbering");
            "Purchase Document Type"::"Return Order":
                exit(CorrSetup."P.Return Order Automatic Numbering");
        end;
    end;

    local procedure ShouldRunAutomaticNumbering(DocumentType: Enum "Sales Document Type"): Boolean
    var
        CorrSetup: Record "lbt Corr Setup";
    begin
        CorrSetup.Get();
        case DocumentType of
            "Sales Document Type"::Quote:
                exit(CorrSetup."S.Quote Automatic Numbering");
            "Sales Document Type"::Order:
                exit(CorrSetup."S.Order Automatic Numbering");
            "Sales Document Type"::Invoice:
                exit(CorrSetup."S.Invoice Automatic Numbering");
            "Sales Document Type"::"Credit Memo":
                exit(CorrSetup."S.Credit Memo Automatic Numbering");
            "Sales Document Type"::"Return Order":
                exit(CorrSetup."S.Return Order Automatic Numbering");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforeDoPrintSalesHeader', '', false, false)]
    local procedure "Document-Print_OnBeforeDoPrintSalesHeader"(var SalesHeader: Record "Sales Header"; ReportUsage: Integer; SendAsEmail: Boolean; var IsPrinted: Boolean)
    var
        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
    begin
        if not ShouldRunAutomaticNumbering(SalesHeader."Document Type") then
            exit;
        LeBitCorrespDocMgt.SalesLinePosNumber(SalesHeader);
        Commit(); // commit changes before showing the request page
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforePrintProformaSalesInvoice', '', false, false)]
    local procedure "Document-Print_OnBeforePrintProformaSalesInvoice"(var SalesHeader: Record "Sales Header"; ReportUsage: Integer; var IsPrinted: Boolean)
    var
        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
    begin
        if not ShouldRunAutomaticNumbering(SalesHeader."Document Type") then
            exit;
        LeBitCorrespDocMgt.SalesLinePosNumber(SalesHeader);
        Commit(); // commit changes before showing the request page
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforeDoPrintPurchHeader', '', false, false)]
    local procedure "Document-Print_OnBeforeDoPrintPurchHeader"(var PurchHeader: Record "Purchase Header"; ReportUsage: Integer; var IsPrinted: Boolean)
    var
        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
    begin
        if not ShouldRunAutomaticNumbering(PurchHeader."Document Type") then
            exit;
        LeBitCorrespDocMgt.PurchLinePosNumber(PurchHeader);
        Commit(); // commit changes before showing the request page
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforePrintRecords', '', false, false)]
    local procedure "Purchase Header_OnBeforePrintRecords"(var PurchaseHeader: Record "Purchase Header"; ShowRequestForm: Boolean; var IsHandled: Boolean)
    var
        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
    begin
        if not ShouldRunAutomaticNumbering(PurchaseHeader."Document Type") then
            exit;
        LeBitCorrespDocMgt.PurchLinePosNumber(PurchaseHeader);
        Commit(); // commit changes before showing the request page
    end;


}