reportextension 5272721 "lbt cl Copy Sales Document" extends "Copy Sales Document"
{

    requestpage
    {
        layout
        {
            modify(IncludeHeader_Options)
            {
                trigger OnAfterValidate()
                begin
                    IncludeHeaderFooter := IncludeHeader;
                end;
            }
            addafter(IncludeHeader_Options)
            {
                field("lbt cl IncludeHeaderFooter"; IncludeHeaderFooter)
                {
                    ApplicationArea = Suite;
                    Caption = 'Copy Header and Footer';
                    ToolTip = 'Decide wether to copy headers and footers to the new document.';
                }
            }
        }
    }

    trigger OnPreReport()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(SalesHeader);
        if IncludeHeaderFooter then
            CopyTextsFromDocument()
        else
            CopyTextsFromCustomer();
    end;

    local procedure CopyTextsFromDocument()
    var
        SalesHeader2: Record "Sales Header";
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        case FromDocType of
            FromDocType::"Blanket Order",
            FromDocType::Quote,
            FromDocType::Order,
            FromDocType::Invoice,
            FromDocType::"Return Order",
            FromDocType::"Credit Memo":
                begin
                    SalesHeader2.Get(CopyDocMgt.GetSalesDocumentType(FromDocType), FromDocNo);
                    LongtextMgt.CopyLongtext(SalesHeader2, SalesHeader);
                end;
            FromDocType::"Posted Shipment":
                LongtextMgt.CopyLongtext(FromSalesShptHeader, SalesHeader);
            FromDocType::"Posted Invoice":
                LongtextMgt.CopyLongtext(FromSalesInvHeader, SalesHeader);
            FromDocType::"Posted Return Receipt":
                LongtextMgt.CopyLongtext(FromReturnRcptHeader, SalesHeader);
            FromDocType::"Posted Credit Memo":
                LongtextMgt.CopyLongtext(FromSalesCrMemoHeader, SalesHeader);
            FromDocType::"Arch. Quote",
            FromDocType::"Arch. Order",
            FromDocType::"Arch. Blanket Order",
            FromDocType::"Arch. Return Order":
                LongtextMgt.CopyLongtext(FromSalesHeaderArchive, SalesHeader);
        end;
    end;

    local procedure CopyTextsFromCustomer()
    var
        Handled: Boolean;
    begin
        lbtclOnBeforeCopyTextsFromCustomer(SalesHeader, Handled);

        if Handled then
            exit;
        if SalesHeader."Sell-to Customer No." <> '' then
            SalesHeader.Validate("Sell-to Customer No.");
    end;

    [IntegrationEvent(false, false)]
    local procedure lbtclOnBeforeCopyTextsFromCustomer(SalesHeader: Record "Sales Header"; var Handled: Boolean)
    begin
    end;

    var
        IncludeHeaderFooter: Boolean;
}