codeunit 5272723 "LBT Longtext Mgt."
{
    trigger OnRun()
    begin
    end;

    var
        Text5272720: Label 'Header/footer texts already exists. Do you want to delete this?';
        FromDocOccurrenceNo: Integer;
        FromDocVersionNo: Integer;
        Text5272723: Label 'There is not enough space to insert extended text lines.';
        NextLineNo: Integer;
        MakeUpdateRequired: Boolean;
        TempExtTextLineLongRec2: Record "LBT Extended Text Line Long" temporary;
        TmpExtTextLine: Record "Extended Text Line" temporary;
        Text5272728: Label 'This Message ist for Developer:\\\ Table %1 %2 is not exist.';

    procedure CopyLongTextForSalesCopyMgt(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; var FromSalesHeader: Record "Sales Header"; var FromSalesLine: Record "Sales Line"; var CopyThisLine: Boolean; FromSalesDocType: Option; WithSalesHeader: Boolean)
    var
        SalesDocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
        CopyDocumentMgt: Codeunit "Copy Document Mgt.";
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
        FromSalesShptHeader: Record "Sales Shipment Header";
        FromSalesShptLine: Record "Sales Shipment Line";
        FromSalesInvHeader: Record "Sales Invoice Header";
        FromSalesInvLine: Record "Sales Invoice Line";
        FromReturnRcptHeader: Record "Return Receipt Header";
        FromReturnRcptLine: Record "Return Receipt Line";
        FromSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        FromSalesCrMemoLine: Record "Sales Cr.Memo Line";
        FromArchSalesHeader: Record "Sales Header Archive";
        FromArchSalesLine: Record "Sales Line Archive";
    begin
        if WithSalesHeader then begin
            TargetRecRef.GETTABLE(ToSalesHeader);
            if ExistLongtext(TargetRecRef) then
                if CONFIRM(Text5272720) then
                    DelLongtext(TargetRecRef);
        end;

        FromSalesDocType := TransferDocType(FromSalesDocType);

        case FromSalesDocType of
            SalesDocType::Quote,
            SalesDocType::"Blanket Order",
            SalesDocType::Order,
            SalesDocType::Invoice,
            SalesDocType::"Return Order",
            SalesDocType::"Credit Memo":
                begin
                    if WithSalesHeader then begin
                        SourceRecRef.GETTABLE(FromSalesHeader);
                        CopyLongtext(SourceRecRef, TargetRecRef);
                    end;
                    SourceRecRef.GETTABLE(FromSalesLine);
                    TargetRecRef.GETTABLE(ToSalesLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
            SalesDocType::"Posted Shipment":
                begin
                    if WithSalesHeader then begin
                        FromSalesShptHeader.GET(FromSalesHeader."No.");
                        SourceRecRef.GETTABLE(FromSalesShptHeader);
                        CopyLongtext(SourceRecRef, TargetRecRef);
                    end;
                    FromSalesShptLine.GET(FromSalesHeader."No.", FromSalesLine."LBT Source Document Line No.");
                    SourceRecRef.GETTABLE(FromSalesShptLine);
                    TargetRecRef.GETTABLE(ToSalesLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
            SalesDocType::"Posted Invoice":
                begin
                    if WithSalesHeader then begin
                        FromSalesInvHeader.GET(FromSalesHeader."No.");
                        SourceRecRef.GETTABLE(FromSalesInvHeader);
                        CopyLongtext(SourceRecRef, TargetRecRef);
                    end;
                    FromSalesInvLine.GET(FromSalesHeader."No.", FromSalesLine."LBT Source Document Line No.");
                    SourceRecRef.GETTABLE(FromSalesInvLine);
                    TargetRecRef.GETTABLE(ToSalesLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
            SalesDocType::"Posted Return Receipt":
                begin
                    if WithSalesHeader then begin
                        FromReturnRcptHeader.GET(FromSalesHeader."No.");
                        SourceRecRef.GETTABLE(FromReturnRcptHeader);
                        CopyLongtext(SourceRecRef, TargetRecRef);
                    end;
                    FromReturnRcptLine.GET(FromSalesHeader."No.", FromSalesLine."LBT Source Document Line No.");
                    SourceRecRef.GETTABLE(FromReturnRcptLine);
                    TargetRecRef.GETTABLE(ToSalesLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
            SalesDocType::"Posted Credit Memo":
                begin
                    if WithSalesHeader then begin
                        FromSalesCrMemoHeader.GET(FromSalesHeader."No.");
                        SourceRecRef.GETTABLE(FromSalesCrMemoHeader);
                        CopyLongtext(SourceRecRef, TargetRecRef);
                    end;
                    FromSalesCrMemoLine.GET(FromSalesHeader."No.", FromSalesLine."LBT Source Document Line No.");
                    SourceRecRef.GETTABLE(FromSalesCrMemoLine);
                    TargetRecRef.GETTABLE(ToSalesLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
            SalesDocType::"Arch. Quote",
            SalesDocType::"Arch. Order",
            SalesDocType::"Arch. Blanket Order",
            SalesDocType::"Arch. Return Order":
                begin
                    if WithSalesHeader then begin
                        FromArchSalesHeader.GET(CopyDocumentMgt.ArchSalesHeaderDocType(FromSalesDocType),
                                                FromSalesHeader."No.",
                                                FromDocOccurrenceNo,
                                                FromDocVersionNo);
                        SourceRecRef.GETTABLE(FromArchSalesHeader);
                        CopyLongtext(SourceRecRef, TargetRecRef);
                    end;
                    FromArchSalesLine.GET(CopyDocumentMgt.ArchSalesHeaderDocType(FromSalesDocType),
                                          FromSalesHeader."No.",
                                          FromDocOccurrenceNo,
                                          FromDocVersionNo,
                                          FromSalesLine."Line No.");

                    SourceRecRef.GETTABLE(FromArchSalesLine);
                    TargetRecRef.GETTABLE(ToSalesLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
        end;
        CopyFieldInfoAfterCreateSalesLine(ToSalesLine, FromSalesLine, false);
    end;

    procedure CopyLongTextForPurchCopyMgt(var ToPurchHeader: Record "Purchase Header"; var ToPurchLine: Record "Purchase Line"; var FromPurchHeader: Record "Purchase Header"; var FromPurchLine: Record "Purchase Line"; var CopyThisLine: Boolean; FromPurchDocType: Option; WithPurchHeader: Boolean)
    var
        PurchDocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Receipt","Posted Invoice","Posted Return Shipment","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
        CopyDocumentMgt: Codeunit "Copy Document Mgt.";
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
        FromPurchRcptHeader: Record "Purch. Rcpt. Header";
        FromPurchRcptLine: Record "Purch. Rcpt. Line";
        FromPurchInvHeader: Record "Purch. Inv. Header";
        FromPurchInvLine: Record "Purch. Inv. Line";
        FromReturnShptHeader: Record "Return Shipment Header";
        FromReturnShptLine: Record "Return Shipment Line";
        FromPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        FromPurchCrMemoLine: Record "Purch. Cr. Memo Line";
        FromArchPurchHeader: Record "Purchase Header Archive";
        FromArchPurchLine: Record "Purchase Line Archive";
    begin
        if WithPurchHeader then begin
            TargetRecRef.GETTABLE(ToPurchHeader);
            if ExistLongtext(TargetRecRef) then
                if CONFIRM(Text5272720) then
                    DelLongtext(TargetRecRef);
        end;

        FromPurchDocType := TransferDocType(FromPurchDocType);

        case FromPurchDocType of
            PurchDocType::Quote,
            PurchDocType::"Blanket Order",
            PurchDocType::Order,
            PurchDocType::Invoice,
            PurchDocType::"Return Order",
            PurchDocType::"Credit Memo":
                begin
                    if WithPurchHeader then begin
                        SourceRecRef.GETTABLE(FromPurchHeader);
                        CopyLongtext(SourceRecRef, TargetRecRef);
                    end;
                    SourceRecRef.GETTABLE(FromPurchLine);
                    TargetRecRef.GETTABLE(ToPurchLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
            PurchDocType::"Posted Receipt":
                begin
                    if WithPurchHeader then begin
                        FromPurchRcptHeader.GET(FromPurchHeader."No.");
                        SourceRecRef.GETTABLE(FromPurchRcptHeader);
                        CopyLongtext(SourceRecRef, TargetRecRef);
                    end;
                    FromPurchRcptLine.GET(FromPurchHeader."No.", FromPurchLine."LBT Source Document Line No.");
                    SourceRecRef.GETTABLE(FromPurchRcptLine);
                    TargetRecRef.GETTABLE(ToPurchLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
            PurchDocType::"Posted Invoice":
                begin
                    if WithPurchHeader then begin
                        FromPurchInvHeader.GET(FromPurchHeader."No.");
                        SourceRecRef.GETTABLE(FromPurchInvHeader);
                        CopyLongtext(SourceRecRef, TargetRecRef);
                    end;
                    FromPurchInvLine.GET(FromPurchHeader."No.", FromPurchLine."LBT Source Document Line No.");
                    SourceRecRef.GETTABLE(FromPurchInvLine);
                    TargetRecRef.GETTABLE(ToPurchLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
            PurchDocType::"Posted Return Shipment":
                begin
                    if WithPurchHeader then begin
                        FromReturnShptHeader.GET(FromPurchHeader."No.");
                        SourceRecRef.GETTABLE(FromReturnShptHeader);
                        CopyLongtext(SourceRecRef, TargetRecRef);
                    end;
                    FromReturnShptLine.GET(FromPurchHeader."No.", FromPurchLine."LBT Source Document Line No.");
                    SourceRecRef.GETTABLE(FromReturnShptLine);
                    TargetRecRef.GETTABLE(ToPurchLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
            PurchDocType::"Posted Credit Memo":
                begin
                    if WithPurchHeader then begin
                        FromPurchCrMemoHeader.GET(FromPurchHeader."No.");
                        SourceRecRef.GETTABLE(FromPurchCrMemoHeader);
                        CopyLongtext(SourceRecRef, TargetRecRef);
                    end;
                    FromPurchCrMemoLine.GET(FromPurchHeader."No.", FromPurchLine."LBT Source Document Line No.");
                    SourceRecRef.GETTABLE(FromPurchCrMemoLine);
                    TargetRecRef.GETTABLE(ToPurchLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
            PurchDocType::"Arch. Order",
            PurchDocType::"Arch. Quote",
            PurchDocType::"Arch. Blanket Order",
            PurchDocType::"Arch. Return Order":
                begin
                    if WithPurchHeader then begin
                        FromArchPurchHeader.GET(CopyDocumentMgt.ArchPurchHeaderDocType(FromPurchDocType),
                                                FromPurchHeader."No.",
                                                FromDocOccurrenceNo,
                                                FromDocVersionNo);
                        SourceRecRef.GETTABLE(FromArchPurchHeader);
                        CopyLongtext(SourceRecRef, TargetRecRef);
                    end;
                    FromArchPurchLine.GET(CopyDocumentMgt.ArchPurchHeaderDocType(FromPurchDocType),
                                          FromPurchHeader."No.",
                                          FromDocOccurrenceNo,
                                          FromDocVersionNo,
                                          FromPurchLine."Line No.");
                    SourceRecRef.GETTABLE(FromPurchCrMemoLine);
                    TargetRecRef.GETTABLE(ToPurchLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
        end;
        CopyFieldInfoAfterCreatePurchLine(ToPurchLine, FromPurchLine, false);
    end;

    procedure CopyLongTextForGetShipmentLines(SalesShipmentLine: Record "Sales Shipment Line"; SalesLine: Record "Sales Line")
    var
        SalesOrderLine: Record "Sales Line";
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        if (SalesShipmentLine.Type <> SalesShipmentLine.Type::" ") and
          SalesOrderLine.GET(SalesOrderLine."Document Type"::Order, SalesShipmentLine."Order No.", SalesShipmentLine."Order Line No.")
        then begin
            SourceRecRef.GETTABLE(SalesOrderLine);
            TargetRecRef.GETTABLE(SalesLine);
            CopyLongtext(SourceRecRef, TargetRecRef);
        end;
    end;

    procedure CopyLongTextForGetPurchRcptLines(PurchRcptLine: Record "Purch. Rcpt. Line"; PurchaseLine: Record "Purchase Line")
    var
        PurchOrderLine: Record "Purchase Line";
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        if (PurchRcptLine.Type <> PurchRcptLine.Type::" ") and
          PurchOrderLine.GET(PurchOrderLine."Document Type"::Order, PurchRcptLine."Order No.", PurchRcptLine."Order Line No.")
        then begin
            SourceRecRef.GETTABLE(PurchOrderLine);
            TargetRecRef.GETTABLE(PurchaseLine);
            CopyLongtext(SourceRecRef, TargetRecRef);
        end;
    end;

    procedure CopyLongTextForSalesArchivMgt(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var SalesHeaderArchive: Record "Sales Header Archive"; var SalesLineArchive: Record "Sales Line Archive")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        TargetRecRef.GETTABLE(SalesHeaderArchive);
        if not ExistLongtext(TargetRecRef) then begin
            SourceRecRef.GETTABLE(SalesHeader);
            CopyLongtext(SourceRecRef, TargetRecRef);
        end;

        SourceRecRef.GETTABLE(SalesLine);
        TargetRecRef.GETTABLE(SalesLineArchive);
        CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    procedure CopyLongTextForPurchArchivMgt(var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var PurchHeaderArchive: Record "Purchase Header Archive"; var PurchLineArchive: Record "Purchase Line Archive")
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        TargetRecRef.GETTABLE(PurchHeaderArchive);
        if not ExistLongtext(TargetRecRef) then begin
            SourceRecRef.GETTABLE(PurchHeader);
            CopyLongtext(SourceRecRef, TargetRecRef);
        end;

        SourceRecRef.GETTABLE(PurchLine);
        TargetRecRef.GETTABLE(PurchLineArchive);
        CopyLongtext(SourceRecRef, TargetRecRef);
    end;

    procedure CopyFieldInfoAfterCreateSalesLine(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary; RunModify: Boolean)
    begin
        SalesLine."LBT Indentation" := TempSalesLine."LBT Indentation";
        SalesLine."LBT Pos. No." := TempSalesLine."LBT Pos. No.";
        SalesLine."LBT Printoption" := TempSalesLine."LBT Printoption";
        SalesLine."LBT Summation" := TempSalesLine."LBT Summation";
        if RunModify then
            SalesLine.MODIFY;
    end;

    procedure CopyFieldInfoAfterCreatePurchLine(var PurchaseLine: Record "Purchase Line"; var TempPurchaseLine: Record "Purchase Line" temporary; RunModify: Boolean)
    begin
        PurchaseLine."LBT Indentation" := TempPurchaseLine."LBT Indentation";
        PurchaseLine."LBT Pos. No." := TempPurchaseLine."LBT Pos. No.";
        PurchaseLine."LBT Printoption" := TempPurchaseLine."LBT Printoption";
        PurchaseLine."LBT Summation" := TempPurchaseLine."LBT Summation";
        if RunModify then
            PurchaseLine.MODIFY;
    end;

    procedure ShowLongtextLines(var SourceRecRef: RecordRef; Position: Option Header,Footer,Longtext)
    begin
        LookupLongtext(SourceRecRef, Position);
    end;

    local procedure LookupLongtext(SourceRecRef: RecordRef; Position: Option Header,Footer,Longtext)
    var
        LongtextRec: Record "LBT PS Longtext Line";
        PostedLongtextRec: Record "LBT Posted PS Longtext Line";
        ArchivedLongtextRec: Record "LBT Archive PS Longtext Line";
        SourceFieldRef: FieldRef;
        SourceDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        SourceDocumentNo: Code[20];
        SourceDocNoOcc: Integer;
        SourceVersionNo: Integer;
        SourceLineNo: Integer;
        SourceTableID: Integer;
    begin
        SourceTableID := SourceRecRef.NUMBER;
        case SourceTableID of
            DATABASE::"Sales Header", DATABASE::"Sales Line",
            DATABASE::"Purchase Header", DATABASE::"Purchase Line":
                begin
                    // Filter bestimmen
                    SourceFieldRef := SourceRecRef.FIELD(1);
                    SourceDocumentType := SourceFieldRef.VALUE;
                    SourceFieldRef := SourceRecRef.FIELD(3);
                    SourceDocumentNo := SourceFieldRef.VALUE;
                    if SourceDocumentNo = '' then
                        exit;
                    if SourceTableID in [DATABASE::"Sales Line", DATABASE::"Purchase Line"] then begin
                        SourceFieldRef := SourceRecRef.FIELD(4);
                        SourceLineNo := SourceFieldRef.VALUE;
                        if SourceLineNo = 0 then
                            exit;
                    end else begin
                        SourceLineNo := 0;
                    end;

                    //Filter setzen
                    LongtextRec.SETRANGE("Table ID", SourceTableID);
                    LongtextRec.SETRANGE("Document Type", SourceDocumentType);
                    LongtextRec.SETRANGE("Document No.", SourceDocumentNo);
                    LongtextRec.SETRANGE(Position, Position);
                    LongtextRec.SETRANGE("Document Line No.", SourceLineNo);

                    // Page öffnen
                    PAGE.RUNMODAL(PAGE::"LBT PS Longtext Lines", LongtextRec)
                end;

            DATABASE::"Sales Shipment Header", DATABASE::"Sales Shipment Line",
            DATABASE::"Sales Invoice Header", DATABASE::"Sales Invoice Line",
            DATABASE::"Sales Cr.Memo Header", DATABASE::"Sales Cr.Memo Line",
            DATABASE::"Purch. Rcpt. Header", DATABASE::"Purch. Rcpt. Line",
            DATABASE::"Purch. Inv. Header", DATABASE::"Purch. Inv. Line",
            DATABASE::"Purch. Cr. Memo Hdr.", DATABASE::"Purch. Cr. Memo Line",
            DATABASE::"Return Shipment Header", DATABASE::"Return Shipment Line",
            DATABASE::"Return Receipt Header", DATABASE::"Return Receipt Line":
                begin
                    // Filter bestimmen
                    SourceFieldRef := SourceRecRef.FIELD(3);
                    SourceDocumentNo := SourceFieldRef.VALUE;
                    if SourceDocumentNo = '' then
                        exit;
                    if SourceTableID in [DATABASE::"Sales Shipment Line", DATABASE::"Sales Invoice Line", DATABASE::"Sales Cr.Memo Line",
                                         DATABASE::"Purch. Rcpt. Line", DATABASE::"Purch. Inv. Line", DATABASE::"Purch. Cr. Memo Line",
                                         DATABASE::"Return Shipment Line", DATABASE::"Return Receipt Line"]
                    then begin
                        SourceFieldRef := SourceRecRef.FIELD(4);
                        SourceLineNo := SourceFieldRef.VALUE;
                        if SourceLineNo = 0 then
                            exit;
                    end else begin
                        SourceLineNo := 0;
                    end;

                    //Filter setzen
                    PostedLongtextRec.SETRANGE("Table ID", SourceTableID);
                    PostedLongtextRec.SETRANGE("Document No.", SourceDocumentNo);
                    PostedLongtextRec.SETRANGE(Position, Position);
                    PostedLongtextRec.SETRANGE("Document Line No.", SourceLineNo);

                    // Page öffnen
                    PAGE.RUNMODAL(PAGE::"LBT Posted PS Longtext Lines", PostedLongtextRec)
                end;

            DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
            DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive":
                begin
                    // Filter bestimmen
                    SourceFieldRef := SourceRecRef.FIELD(1);
                    SourceDocumentType := SourceFieldRef.VALUE;
                    SourceFieldRef := SourceRecRef.FIELD(3);
                    SourceDocumentNo := SourceFieldRef.VALUE;
                    if SourceDocumentNo = '' then
                        exit;
                    if SourceTableID in [DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive"]
                    then begin
                        SourceFieldRef := SourceRecRef.FIELD(4);
                        SourceLineNo := SourceFieldRef.VALUE;
                        if SourceLineNo = 0 then
                            exit;
                    end else begin
                        SourceLineNo := 0;
                    end;
                    SourceFieldRef := SourceRecRef.FIELD(5048);
                    SourceDocNoOcc := SourceFieldRef.VALUE;
                    SourceFieldRef := SourceRecRef.FIELD(5047);
                    SourceVersionNo := SourceFieldRef.VALUE;


                    //Filter setzen
                    ArchivedLongtextRec.SETRANGE("Table ID", SourceTableID);
                    ArchivedLongtextRec.SETRANGE("Document Type", SourceDocumentType);
                    ArchivedLongtextRec.SETRANGE("Document No.", SourceDocumentNo);
                    ArchivedLongtextRec.SETRANGE("Doc. No. Occurrence", SourceDocNoOcc);
                    ArchivedLongtextRec.SETRANGE("Version No.", SourceVersionNo);
                    ArchivedLongtextRec.SETRANGE(Position, Position);
                    ArchivedLongtextRec.SETRANGE("Document Line No.", SourceLineNo);

                    // Page öffnen
                    PAGE.RUNMODAL(PAGE::"LBT Arch. PS Longtext Lines", ArchivedLongtextRec)
                end;
        end;
    end;

    procedure ExistLongtext(SourceRecRef: RecordRef): Boolean
    var
        SourceLongtextRecRef: RecordRef;
        SourceFieldRef: FieldRef;
        SourceDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        SourceDocumentNo: Code[20];
        SourceTableID: Integer;
        SourceDocNoOcc: Integer;
        SourceVersionNo: Integer;
        SourceLineNo: Integer;
    begin
        // 1. Herkunft
        SourceTableID := SourceRecRef.NUMBER;
        // Tabellen und Filterung über RecordRef's
        case SourceTableID of
            DATABASE::"Sales Header", DATABASE::"Sales Line",
        DATABASE::"Purchase Header", DATABASE::"Purchase Line":
                SourceLongtextRecRef.OPEN(DATABASE::"LBT PS Longtext Line");
            DATABASE::"Sales Shipment Header", DATABASE::"Sales Shipment Line",
        DATABASE::"Sales Invoice Header", DATABASE::"Sales Invoice Line",
        DATABASE::"Sales Cr.Memo Header", DATABASE::"Sales Cr.Memo Line",
        DATABASE::"Purch. Rcpt. Header", DATABASE::"Purch. Rcpt. Line",
        DATABASE::"Purch. Inv. Header", DATABASE::"Purch. Inv. Line",
        DATABASE::"Purch. Cr. Memo Hdr.", DATABASE::"Purch. Cr. Memo Line",
        DATABASE::"Return Shipment Header", DATABASE::"Return Shipment Line",
        DATABASE::"Return Receipt Header", DATABASE::"Return Receipt Line":
                SourceLongtextRecRef.OPEN(DATABASE::"LBT Posted PS Longtext Line");
            DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
        DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive":
                SourceLongtextRecRef.OPEN(DATABASE::"LBT Archive PS Longtext Line");
        end;
        SourceFieldRef := SourceLongtextRecRef.FIELD(1);
        SourceFieldRef.SETRANGE(SourceTableID);

        // Dokumentenart
        if SourceTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                             DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                             DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                             DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecRef.FIELD(1);
            SourceDocumentType := SourceFieldRef.VALUE;
            SourceFieldRef := SourceLongtextRecRef.FIELD(2);
            SourceFieldRef.SETRANGE(SourceDocumentType);
        end;

        // Dokumenten Nr.
        SourceFieldRef := SourceRecRef.FIELD(3);
        SourceDocumentNo := SourceFieldRef.VALUE;
        SourceFieldRef := SourceLongtextRecRef.FIELD(3);
        SourceFieldRef.SETRANGE(SourceDocumentNo);

        // Belegnr.-Häufigkeit + Versionsnr.
        if SourceTableID in [DATABASE::"Sales Header Archive", DATABASE::"Purchase Header Archive",
                             DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecRef.FIELD(5048);
            SourceDocNoOcc := SourceFieldRef.VALUE;
            SourceFieldRef := SourceLongtextRecRef.FIELD(8);
            SourceFieldRef.SETRANGE(SourceDocNoOcc);

            SourceFieldRef := SourceRecRef.FIELD(5047);
            SourceVersionNo := SourceFieldRef.VALUE;
            SourceFieldRef := SourceLongtextRecRef.FIELD(7);
            SourceFieldRef.SETRANGE(SourceVersionNo);
        end;

        // Zeilen Nr.
        if SourceTableID in [DATABASE::"Sales Line", DATABASE::"Purchase Line",
                             DATABASE::"Sales Shipment Line", DATABASE::"Purch. Rcpt. Line",
                             DATABASE::"Sales Invoice Line", DATABASE::"Purch. Inv. Line",
                             DATABASE::"Sales Cr.Memo Line", DATABASE::"Purch. Cr. Memo Line",
                             DATABASE::"Return Shipment Line", DATABASE::"Return Receipt Line",
                             DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive",
                             DATABASE::"Return Shipment Line", DATABASE::"Return Receipt Line"]
        then begin
            SourceFieldRef := SourceRecRef.FIELD(4);
            SourceLineNo := SourceFieldRef.VALUE;
            SourceFieldRef := SourceLongtextRecRef.FIELD(5);
            SourceFieldRef.SETRANGE(SourceLineNo);
        end;

        // nicht leer, dann vorhanden :)
        exit(not SourceLongtextRecRef.ISEMPTY);
    end;

    procedure CopyLongtext(SourceRecRef: RecordRef; TargetRecRef: RecordRef)
    var
        SourceLongtextRecRef: RecordRef;
        TargetLongtextRecRef: RecordRef;
        TargetFieldRef: FieldRef;
        SourceFieldRef: FieldRef;
        SourceDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        TargetDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        SourceDocumentNo: Code[20];
        TargetDocumentNo: Code[20];
        TargetTableID: Integer;
        SourceTableID: Integer;
        SourceDocNoOcc: Integer;
        SourceVersionNo: Integer;
        SourceLineNo: Integer;
        TargetDocNoOcc: Integer;
        TargetVersionNo: Integer;
        TargetLineNo: Integer;
        LineNo: Integer;
    begin
        // Funktion derzeit nur fürs Kopieren von Belegen, nicht das verbuchen/Archivieren von Belegen
        // Könnte jedoch bei beid Bedarf und Gelegenheit zusammengeführt werden

        // 1. Herkunft
        SourceTableID := SourceRecRef.NUMBER;
        // Tabellen und Filterung über RecordRef's
        case SourceTableID of
            DATABASE::"Sales Header", DATABASE::"Sales Line",
        DATABASE::"Purchase Header", DATABASE::"Purchase Line":
                SourceLongtextRecRef.OPEN(DATABASE::"LBT PS Longtext Line");
            DATABASE::"Sales Shipment Header", DATABASE::"Sales Shipment Line",
        DATABASE::"Sales Invoice Header", DATABASE::"Sales Invoice Line",
        DATABASE::"Sales Cr.Memo Header", DATABASE::"Sales Cr.Memo Line",
        DATABASE::"Purch. Rcpt. Header", DATABASE::"Purch. Rcpt. Line",
        DATABASE::"Purch. Inv. Header", DATABASE::"Purch. Inv. Line",
        DATABASE::"Purch. Cr. Memo Hdr.", DATABASE::"Purch. Cr. Memo Line",
        DATABASE::"Return Shipment Header", DATABASE::"Return Shipment Line",
        DATABASE::"Return Receipt Header", DATABASE::"Return Receipt Line":
                SourceLongtextRecRef.OPEN(DATABASE::"LBT Posted PS Longtext Line");
            DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
        DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive":
                SourceLongtextRecRef.OPEN(DATABASE::"LBT Archive PS Longtext Line");
        end;
        SourceFieldRef := SourceLongtextRecRef.FIELD(1);
        SourceFieldRef.SETRANGE(SourceTableID);

        // Dokumententyp
        if SourceTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                             DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                             DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                             DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecRef.FIELD(1);
            SourceDocumentType := SourceFieldRef.VALUE;
            SourceFieldRef := SourceLongtextRecRef.FIELD(2);
            SourceFieldRef.SETRANGE(SourceDocumentType);
        end;

        // Dokumenten Nr.
        SourceFieldRef := SourceRecRef.FIELD(3);
        SourceDocumentNo := SourceFieldRef.VALUE;
        SourceFieldRef := SourceLongtextRecRef.FIELD(3);
        SourceFieldRef.SETRANGE(SourceDocumentNo);

        //  Belegnr.-Häufigkeit + Versionsnr.
        if SourceTableID in [DATABASE::"Sales Header Archive", DATABASE::"Purchase Header Archive",
                             DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecRef.FIELD(5048);
            SourceDocNoOcc := SourceFieldRef.VALUE;
            SourceFieldRef := SourceLongtextRecRef.FIELD(8);
            SourceFieldRef.SETRANGE(SourceDocNoOcc);

            SourceFieldRef := SourceRecRef.FIELD(5047);
            SourceVersionNo := SourceFieldRef.VALUE;
            SourceFieldRef := SourceLongtextRecRef.FIELD(7);
            SourceFieldRef.SETRANGE(SourceVersionNo);
        end;

        // Zeilen Nr.
        if SourceTableID in [DATABASE::"Sales Line", DATABASE::"Purchase Line",
                             DATABASE::"Sales Shipment Line", DATABASE::"Purch. Rcpt. Line",
                             DATABASE::"Sales Invoice Line", DATABASE::"Purch. Inv. Line",
                             DATABASE::"Sales Cr.Memo Line", DATABASE::"Purch. Cr. Memo Line",
                             DATABASE::"Return Shipment Line", DATABASE::"Return Receipt Line",
                             DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive",
                             DATABASE::"Return Shipment Line", DATABASE::"Return Receipt Line"]
        then begin
            SourceFieldRef := SourceRecRef.FIELD(4);
            SourceLineNo := SourceFieldRef.VALUE;
            SourceFieldRef := SourceLongtextRecRef.FIELD(5);
            SourceFieldRef.SETRANGE(SourceLineNo);
        end;


        // 2. Ziel
        TargetTableID := TargetRecRef.NUMBER;
        // Tabellen und Filterung über RecordRef's
        case TargetTableID of
            DATABASE::"Sales Header", DATABASE::"Sales Line",
        DATABASE::"Purchase Header", DATABASE::"Purchase Line":
                TargetLongtextRecRef.OPEN(DATABASE::"LBT PS Longtext Line");
            DATABASE::"Sales Shipment Header", DATABASE::"Sales Shipment Line",
        DATABASE::"Sales Invoice Header", DATABASE::"Sales Invoice Line",
        DATABASE::"Sales Cr.Memo Header", DATABASE::"Sales Cr.Memo Line",
        DATABASE::"Purch. Rcpt. Header", DATABASE::"Purch. Rcpt. Line",
        DATABASE::"Purch. Inv. Header", DATABASE::"Purch. Inv. Line",
        DATABASE::"Purch. Cr. Memo Hdr.", DATABASE::"Purch. Cr. Memo Line",
        DATABASE::"Return Shipment Header", DATABASE::"Return Shipment Line",
        DATABASE::"Return Receipt Header", DATABASE::"Return Receipt Line":
                TargetLongtextRecRef.OPEN(DATABASE::"LBT Posted PS Longtext Line");
            DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
        DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive":
                TargetLongtextRecRef.OPEN(DATABASE::"LBT Archive PS Longtext Line");
        end;
        TargetFieldRef := TargetLongtextRecRef.FIELD(1);
        TargetFieldRef.SETRANGE(TargetTableID);

        // Dokumententyp
        if TargetTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                             DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                             DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                             DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]
        then begin
            TargetFieldRef := TargetRecRef.FIELD(1);
            TargetDocumentType := TargetFieldRef.VALUE;
            TargetFieldRef := TargetLongtextRecRef.FIELD(2);
            TargetFieldRef.SETRANGE(TargetDocumentType);
        end;

        // Dokumenten Nr.
        TargetFieldRef := TargetRecRef.FIELD(3);
        TargetDocumentNo := TargetFieldRef.VALUE;
        TargetFieldRef := TargetLongtextRecRef.FIELD(3);
        TargetFieldRef.SETRANGE(TargetDocumentNo);

        //  Belegnr.-Häufigkeit + Versionsnr.
        if TargetTableID in [DATABASE::"Sales Header Archive", DATABASE::"Purchase Header Archive",
                             DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive"]
        then begin
            TargetFieldRef := TargetRecRef.FIELD(5048);
            TargetDocNoOcc := TargetFieldRef.VALUE;
            TargetFieldRef := TargetLongtextRecRef.FIELD(8);
            TargetFieldRef.SETRANGE(TargetDocNoOcc);

            TargetFieldRef := TargetRecRef.FIELD(5047);
            TargetVersionNo := TargetFieldRef.VALUE;
            TargetFieldRef := TargetLongtextRecRef.FIELD(7);
            TargetFieldRef.SETRANGE(TargetVersionNo);
        end;

        // Zeilen Nr.
        if TargetTableID in [DATABASE::"Sales Line", DATABASE::"Purchase Line",
                             DATABASE::"Sales Shipment Line", DATABASE::"Purch. Rcpt. Line",
                             DATABASE::"Sales Invoice Line", DATABASE::"Purch. Inv. Line",
                             DATABASE::"Sales Cr.Memo Line", DATABASE::"Purch. Cr. Memo Line",
                             DATABASE::"Return Shipment Line", DATABASE::"Return Receipt Line",
                             DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive",
                             DATABASE::"Return Shipment Line", DATABASE::"Return Receipt Line"]
        then begin
            TargetFieldRef := TargetRecRef.FIELD(4);
            TargetLineNo := TargetFieldRef.VALUE;
            TargetFieldRef := TargetLongtextRecRef.FIELD(5);
            TargetFieldRef.SETRANGE(TargetLineNo);
        end;

        // Sonderfall im Auftrag/Bestellung -- Kopf- & Fußtexte für Rechnung/Lieferung
        if (SourceTableID in [DATABASE::"Sales Header", DATABASE::"Purchase Header"]) and
           (SourceDocumentType = 1) //Auftrag/Bestellung
        then begin
            // wenn Ziel = Rechnung, dann prüfen, ob separate Texte
            if (TargetTableID in [DATABASE::"Sales Invoice Header", DATABASE::"Purch. Inv. Header"]) or
              ((TargetTableID = DATABASE::"Sales Invoice Header") and (TargetDocumentType = 2))
            then begin
                SourceFieldRef := SourceLongtextRecRef.FIELD(2);
                SourceFieldRef.SETRANGE(2); // Rechnung
                if SourceLongtextRecRef.ISEMPTY then
                    SourceFieldRef.SETRANGE(1); //Auftrag/Bestellung
            end;

            // wenn Ziel = Lieferschein, dann prüfen, ob separate Texte
            if (TargetTableID in [DATABASE::"Sales Shipment Header", DATABASE::"Purch. Rcpt. Header"])
            then begin
                SourceFieldRef := SourceLongtextRecRef.FIELD(2);
                SourceFieldRef.SETRANGE(6); // Lieferung
                if SourceLongtextRecRef.ISEMPTY then
                    SourceFieldRef.SETRANGE(1); // Auftrag/Bestellung
            end;

            // wenn Ziel = Auftrag, dann alles
            if (TargetTableID in [DATABASE::"Sales Header", DATABASE::"Purchase Header"]) and
               (TargetDocumentType = 1) // Auftrag/Bestellung
            then begin
                SourceFieldRef := SourceLongtextRecRef.FIELD(2);
                SourceFieldRef.SETRANGE;
            end;
        end;

        // Kopieren
        if SourceLongtextRecRef.FINDSET then begin
            // letzte Zielzeilennr. finden (falls beim Beleg kopieren noch da)
            if TargetLongtextRecRef.FINDLAST then begin
                TargetFieldRef := TargetLongtextRecRef.FIELD(6);
                LineNo := TargetFieldRef.VALUE;
            end else
                LineNo := 0;
            repeat
                LineNo += 10000;
                TargetLongtextRecRef.INIT;
                TargetFieldRef := TargetLongtextRecRef.FIELD(1);  // Table ID
                TargetFieldRef.VALUE := TargetTableID;
                // wenn Quelle und Ziel = Auftrag, dann originale Arten
                if ((SourceTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                                       DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                                       DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                                       DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]) and
                    (SourceDocumentType = 1)) and
                   ((TargetTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                                       DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                                       DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                                       DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]) and
                    (TargetDocumentType = 1))
                then begin
                    SourceFieldRef := SourceLongtextRecRef.FIELD(2);  // Document Type
                    TargetFieldRef := TargetLongtextRecRef.FIELD(2);  // Document Type
                    TargetFieldRef.VALUE := SourceFieldRef.VALUE;
                end else begin
                    if (TargetTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                                          DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                                          DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                                          DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"])
                    then begin
                        TargetFieldRef := TargetLongtextRecRef.FIELD(2);  // Document Type
                        TargetFieldRef.VALUE := TargetDocumentType;
                    end;
                end;
                TargetFieldRef := TargetLongtextRecRef.FIELD(3);  // Document No.
                TargetFieldRef.VALUE := TargetDocumentNo;
                SourceFieldRef := SourceLongtextRecRef.FIELD(4);  // Position
                TargetFieldRef := TargetLongtextRecRef.FIELD(4);  // Position
                TargetFieldRef.VALUE := SourceFieldRef.VALUE;
                TargetFieldRef := TargetLongtextRecRef.FIELD(5);  // Document Line No.
                TargetFieldRef.VALUE := TargetLineNo;
                TargetFieldRef := TargetLongtextRecRef.FIELD(6);  // Line No.
                TargetFieldRef.VALUE := LineNo;

                if TargetTableID in [DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                                     DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]
                then begin
                    TargetFieldRef := TargetLongtextRecRef.FIELD(7);  // Version No.
                    TargetFieldRef.VALUE := TargetVersionNo;
                    TargetFieldRef := TargetLongtextRecRef.FIELD(8);  // Doc. No. Occurrence
                    TargetFieldRef.VALUE := TargetDocNoOcc;
                end;
                SourceFieldRef := SourceLongtextRecRef.FIELD(10); // Type
                TargetFieldRef := TargetLongtextRecRef.FIELD(10); // Type
                TargetFieldRef.VALUE := SourceFieldRef.VALUE;
                SourceFieldRef := SourceLongtextRecRef.FIELD(11); // No.
                TargetFieldRef := TargetLongtextRecRef.FIELD(11); // No.
                TargetFieldRef.VALUE := SourceFieldRef.VALUE;
                SourceFieldRef := SourceLongtextRecRef.FIELD(12); // Description
                TargetFieldRef := TargetLongtextRecRef.FIELD(12); // Description
                TargetFieldRef.VALUE := SourceFieldRef.VALUE;

                if not TargetLongtextRecRef.INSERT then
                    TargetLongtextRecRef.MODIFY;
            until SourceLongtextRecRef.NEXT = 0;
        end;
    end;

    procedure DelLongtext(SourceRecRef: RecordRef)
    var
        LongtextLineRec: Record "LBT PS Longtext Line";
        SourceFieldRef: FieldRef;
        SourceDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        SourceDocumentNo: Code[20];
        SourceTableID: Integer;
        SourceLineNo: Integer;
    begin
        SourceTableID := SourceRecRef.NUMBER;
        if not (SourceTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                                  DATABASE::"Purchase Header", DATABASE::"Purchase Line"])
        then
            exit;

        SourceFieldRef := SourceRecRef.FIELD(1);
        SourceDocumentType := SourceFieldRef.VALUE;
        SourceFieldRef := SourceRecRef.FIELD(3);
        SourceDocumentNo := SourceFieldRef.VALUE;
        if SourceTableID in [DATABASE::"Sales Line", DATABASE::"Purchase Line"] then begin
            SourceFieldRef := SourceRecRef.FIELD(4);
            SourceLineNo := SourceFieldRef.VALUE;
        end else
            SourceLineNo := 0;

        LongtextLineRec.RESET;
        LongtextLineRec.SETRANGE("Table ID", SourceTableID);
        LongtextLineRec.SETRANGE("Document Type", SourceDocumentType);
        LongtextLineRec.SETRANGE("Document No.", SourceDocumentNo);
        LongtextLineRec.SETRANGE("Document Line No.", SourceLineNo);
        LongtextLineRec.DELETEALL;
    end;

    procedure InsertLongTextExtText(var PurchSalesTextRec: Record "LBT PS Longtext Line"; NewDocumentType: Integer)
    var
        ToPurchSalesTextRec: Record "LBT PS Longtext Line";
        FirstLine: Boolean;
        LineSpacing: Integer;
    begin
        ToPurchSalesTextRec.RESET;
        ToPurchSalesTextRec.SETRANGE("Table ID", PurchSalesTextRec."Table ID");
        ToPurchSalesTextRec.SETRANGE("Document Type", NewDocumentType);
        ToPurchSalesTextRec.SETRANGE("Document No.", PurchSalesTextRec."Document No.");
        ToPurchSalesTextRec.SETRANGE(Position, PurchSalesTextRec.Position);
        ToPurchSalesTextRec.SETRANGE("Document Line No.", PurchSalesTextRec."Document Line No.");
        ToPurchSalesTextRec := PurchSalesTextRec;
        if ToPurchSalesTextRec.FIND('>') then begin
            LineSpacing :=
              (ToPurchSalesTextRec."Line No." - PurchSalesTextRec."Line No.") div
              (1 + TempExtTextLineLongRec2.COUNT);
            if LineSpacing = 0 then
                ERROR(Text5272723);
        end else
            LineSpacing := 10000;

        NextLineNo := PurchSalesTextRec."Line No." + LineSpacing;
        FirstLine := true;

        TempExtTextLineLongRec2.RESET;
        if TempExtTextLineLongRec2.FIND('-') then begin
            repeat
                if FirstLine then begin
                    PurchSalesTextRec.Description := TempExtTextLineLongRec2.Description;
                    PurchSalesTextRec.MODIFY;
                    FirstLine := false;
                end else begin
                    ToPurchSalesTextRec.INIT;
                    ToPurchSalesTextRec."Table ID" := PurchSalesTextRec."Table ID";
                    ToPurchSalesTextRec."Document Type" := NewDocumentType;
                    ToPurchSalesTextRec."Document No." := PurchSalesTextRec."Document No.";
                    ToPurchSalesTextRec.Position := PurchSalesTextRec.Position;
                    ToPurchSalesTextRec."Document Line No." := PurchSalesTextRec."Document Line No.";
                    ToPurchSalesTextRec."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + LineSpacing;
                    ToPurchSalesTextRec.Description := TempExtTextLineLongRec2.Description;
                    ToPurchSalesTextRec.Type := ToPurchSalesTextRec.Type::"Text + Line break";
                    ToPurchSalesTextRec.INSERT;
                end;
            until TempExtTextLineLongRec2.NEXT = 0;
            MakeUpdateRequired := true;
        end;
        TempExtTextLineLongRec2.DELETEALL;
    end;

    procedure LongTextCheckIfAnyExtText(var ExtTextRec: Record "Extended Text Header"; Language: Code[10]; DocumentDate: Date): Boolean
    var
        ExtTextHeader: Record "Extended Text Header";
    begin
        ExtTextHeader.COPYFILTERS(ExtTextRec);
        exit(ReadLines(ExtTextHeader, DocumentDate, Language, true));
    end;

    local procedure ReadLines(var ExtTextHeader: Record "Extended Text Header"; DocDate: Date; LanguageCode: Code[10]; Longtext: Boolean) Result: Boolean
    var
        ExtTextLine: Record "Extended Text Line";
        ExtTextLineLongRec: Record "LBT Extended Text Line Long";
        InLongtext: Boolean;
    begin
        ExtTextHeader.SETCURRENTKEY(
          "Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
        ExtTextHeader.SETRANGE("Starting Date", 0D, DocDate);
        ExtTextHeader.SETFILTER("Ending Date", '%1..|%2', DocDate, 0D);
        if LanguageCode = '' then begin
            ExtTextHeader.SETRANGE("Language Code", '');
            if not ExtTextHeader.FINDSET then
                exit;
        end else begin
            ExtTextHeader.SETRANGE("Language Code", LanguageCode);
            if not ExtTextHeader.FINDSET then begin
                ExtTextHeader.SETRANGE("All Language Codes", true);
                ExtTextHeader.SETRANGE("Language Code", '');
                if not ExtTextHeader.FINDSET then
                    exit;
            end;
        end;

        if (ExtTextHeader."LBT Textchoice" = ExtTextHeader."LBT Textchoice"::standard) and (Longtext) then begin
            Longtext := false;
            InLongtext := true;
        end;

        if Longtext then begin
            ExtTextLineLongRec.SETRANGE(Table_ID, ExtTextHeader."Table Name");
            ExtTextLineLongRec.SETRANGE("No.", ExtTextHeader."No.");
            ExtTextLineLongRec.SETRANGE("Language Code", ExtTextHeader."Language Code");
            ExtTextLineLongRec.SETRANGE("Text No.", ExtTextHeader."Text No.");
            if ExtTextLineLongRec.FINDSET then begin
                TempExtTextLineLongRec2.DELETEALL;
                repeat
                    TempExtTextLineLongRec2 := ExtTextLineLongRec;
                    TempExtTextLineLongRec2.INSERT;
                until ExtTextLineLongRec.NEXT = 0;
                exit(true);
            end;
        end else begin
            if InLongtext then begin
                ExtTextLine.SETRANGE("Table Name", ExtTextHeader."Table Name");
                ExtTextLine.SETRANGE("No.", ExtTextHeader."No.");
                ExtTextLine.SETRANGE("Language Code", ExtTextHeader."Language Code");
                ExtTextLine.SETRANGE("Text No.", ExtTextHeader."Text No.");
                if ExtTextLine.FIND('-') then begin
                    TempExtTextLineLongRec2.DELETEALL;
                    repeat
                        TempExtTextLineLongRec2.TRANSFERFIELDS(ExtTextLine);
                        TempExtTextLineLongRec2.INSERT;
                    until ExtTextLine.NEXT = 0;
                    exit(true);
                end;
            end else begin
                TmpExtTextLine.DELETEALL;
                repeat
                    ExtTextLine.SETRANGE("Table Name", ExtTextHeader."Table Name");
                    ExtTextLine.SETRANGE("No.", ExtTextHeader."No.");
                    ExtTextLine.SETRANGE("Language Code", ExtTextHeader."Language Code");
                    ExtTextLine.SETRANGE("Text No.", ExtTextHeader."Text No.");
                    if ExtTextLine.FINDSET then begin
                        repeat
                            TmpExtTextLine := ExtTextLine;
                            TmpExtTextLine.INSERT;
                        until ExtTextLine.NEXT = 0;
                        Result := true;
                    end;
                until ExtTextHeader.NEXT = 0;
            end;
        end;
    end;

    procedure EditorRef(var SourceRecRef: RecordRef; Editable: Boolean)
    var
        SourceFieldRef: FieldRef;
        SourceKeyRef: KeyRef;
        TargetRecRef: RecordRef;
        TargetFieldRef: FieldRef;
        TargetKeyRef: KeyRef;
        I: Integer;
        LineNoFieldNo: Integer;
        CommentFieldNo: Integer;
        SourceRecNo: Integer;
        AllObjRec: Record AllObj;
    begin
        // Filterung universell, Voraussetzung: letztes Feld im Primärschlüssel ist die Zeile

        SourceRecRef.CURRENTKEYINDEX(1);
        SourceKeyRef := SourceRecRef.KEYINDEX(1);

        TargetRecRef := SourceRecRef.DUPLICATE;
        TargetKeyRef := TargetRecRef.KEYINDEX(1);

        if SourceRecRef.HASFILTER then begin
            for I := 1 to SourceKeyRef.FIELDCOUNT - 1 do begin
                SourceFieldRef := SourceKeyRef.FIELDINDEX(I);
                TargetFieldRef := TargetKeyRef.FIELDINDEX(I);
                TargetFieldRef.SETFILTER(SourceFieldRef.GETFILTER);
            end;
        end else begin
            for I := 1 to SourceKeyRef.FIELDCOUNT - 1 do begin
                SourceFieldRef := SourceKeyRef.FIELDINDEX(I);
                TargetFieldRef := TargetKeyRef.FIELDINDEX(I);
                TargetFieldRef.SETRANGE(SourceFieldRef.VALUE);
            end;
        end;

        // Feldnr. der Zeilennr.
        SourceFieldRef := SourceKeyRef.FIELDINDEX(SourceKeyRef.FIELDCOUNT);
        LineNoFieldNo := SourceFieldRef.NUMBER;

        // Feldnr. der Bemerkung
        // Behandlung wenn Temp-Table, da muss über den Namen die richtige Objektnr. ermittelt werden
        SourceRecNo := SourceRecRef.NUMBER;
        if SourceRecNo >= 2000100000 then begin
            AllObjRec.SETRANGE("Object Type", AllObjRec."Object Type"::Table);
            AllObjRec.SETRANGE("Object Name", SourceRecRef.NAME);
            if AllObjRec.FINDFIRST then
                SourceRecNo := AllObjRec."Object ID";
        end;
        case SourceRecNo of
            DATABASE::"Purch. Comment Line",
          DATABASE::"Sales Comment Line",
          DATABASE::"Comment Line":
                CommentFieldNo := 6;
            DATABASE::"Extended Text Line":
                CommentFieldNo := 6;
            DATABASE::"Inter. Log Entry Comment Line":
                CommentFieldNo := 7;
            DATABASE::"LBT Extended Text Line Long":
                CommentFieldNo := 6;
                // DATABASE::"Journal Line Memo":
                //     CommentFieldNo := 5;
            DATABASE::"LBT PS Longtext Line":
                CommentFieldNo := 12;
                // DATABASE::Table5159501:
                //  CommentFieldNo := 3;
                // DATABASE::Table5159513:
                //  CommentFieldNo := 9;
                // DATABASE::"Sales Notes":
                //  CommentFieldNo := 12;

                //
                // Hier sollten alle möglichen Bemerkungstabellen rein, die einen Aufruf für den Editor bekommen
                //
            else
                ERROR(Text5272728, SourceRecRef.NUMBER, SourceRecRef.CAPTION);
        end;
    end;

    local procedure TransferDocType(FromDocType: Option): Integer
    begin
        case FromDocType of
            1:
                exit(2);
            2:
                exit(3);
            3:
                exit(5);
            4:
                exit(1);
            5:
                exit(4);
            8:
                exit(9);
            9:
                exit(8);
        end;
    end;
}

