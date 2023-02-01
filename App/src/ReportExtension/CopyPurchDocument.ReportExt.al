reportextension 5272722 "lbt cl Copy Purch. Document" extends "Copy Purchase Document"
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
        LongtextMgt.DelLongtext(PurchHeader);
        if IncludeHeaderFooter then
            CopyTextsFromDocument()
        else
            CopyTextsFromCustomer();
    end;

    local procedure CopyTextsFromDocument()
    var
        PurchaseHeader2: Record "Purchase Header";
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        case FromDocType of
            FromDocType::Quote,
            FromDocType::"Blanket Order",
            FromDocType::Order,
            FromDocType::Invoice,
            FromDocType::"Return Order",
            FromDocType::"Credit Memo":
                begin
                    PurchaseHeader2.Get(CopyDocMgt.GetPurchaseDocumentType(FromDocType), FromDocNo);
                    LongtextMgt.CopyLongtext(PurchaseHeader2, PurchHeader);
                end;
            FromDocType::"Posted Receipt":
                LongtextMgt.CopyLongtext(FromPurchRcptHeader, PurchHeader);
            FromDocType::"Posted Invoice":
                LongtextMgt.CopyLongtext(FromPurchInvHeader, PurchHeader);
            FromDocType::"Posted Return Shipment":
                LongtextMgt.CopyLongtext(FromReturnShptHeader, PurchHeader);
            FromDocType::"Posted Credit Memo":
                LongtextMgt.CopyLongtext(FromPurchCrMemoHeader, PurchHeader);
            FromDocType::"Arch. Quote",
            FromDocType::"Arch. Order",
            FromDocType::"Arch. Blanket Order",
            FromDocType::"Arch. Return Order":
                LongtextMgt.CopyLongtext(FromPurchHeaderArchive, PurchHeader);
        end;
    end;

    local procedure CopyTextsFromCustomer()
    var
        Handled: Boolean;
    begin
        lbtclOnBeforeCopyTextsFromCustomer(PurchHeader, Handled);

        if Handled then
            exit;

        if PurchHeader."Buy-from Vendor No." <> '' then
            PurchHeader.Validate("Buy-from Vendor No.");
    end;

    [IntegrationEvent(false, false)]
    local procedure lbtclOnBeforeCopyTextsFromCustomer(PurchHeader: Record "Purchase Header"; var Handled: Boolean)
    begin
    end;

    var
        IncludeHeaderFooter: Boolean;
}