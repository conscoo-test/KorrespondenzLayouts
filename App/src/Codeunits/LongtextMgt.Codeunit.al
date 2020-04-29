codeunit 5272723 "lbt Longtext Mgt."
{
    trigger OnRun()
    begin
    end;

    var
        TempExtTextLineLongRec2: Record "lbt Extended Text Line Long" temporary;
        TmpExtTextLine: Record "Extended Text Line" temporary;
        HeaderExistsErr: Label 'Header/footer texts already exists. Do you want to delete this?';
        NotEnoughSpaceErr: Label 'There is not enough space to insert extended text lines.';
        NextLineNo: Integer;
        MakeUpdateRequired: Boolean;
        NotTableExistErr: Label 'This Message ist for Developer:\\\ Table %1 %2 is not exist.', Comment = '%1 - Table No., %2 - Table Caption';

    procedure CopyLongTextForSalesCopyMgt(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; var FromSalesHeader: Record "Sales Header"; var FromSalesLine: Record "Sales Line"; var CopyThisLine: Boolean; FromSalesDocType: Option; WithSalesHeader: Boolean)
    var
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
        CopyDocumentMgt: Codeunit "Copy Document Mgt.";
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
        SalesDocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
        FromDocOccurrenceNo: Integer;
        FromDocVersionNo: Integer;
    begin
        if WithSalesHeader then begin
            TargetRecRef.GETTABLE(ToSalesHeader);
            if ExistLongtext(TargetRecRef) then
                if CONFIRM(HeaderExistsErr) then
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
                    FromSalesShptLine.GET(FromSalesHeader."No.", FromSalesLine."lbt Source Document Line No.");
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
                    FromSalesInvLine.GET(FromSalesHeader."No.", FromSalesLine."lbt Source Document Line No.");
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
                    FromReturnRcptLine.GET(FromSalesHeader."No.", FromSalesLine."lbt Source Document Line No.");
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
                    FromSalesCrMemoLine.GET(FromSalesHeader."No.", FromSalesLine."lbt Source Document Line No.");
                    SourceRecRef.GETTABLE(FromSalesCrMemoLine);
                    TargetRecRef.GETTABLE(ToSalesLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
            SalesDocType::"Arch. Quote",
            SalesDocType::"Arch. Order",
            SalesDocType::"Arch. Blanket Order",
            SalesDocType::"Arch. Return Order":
                begin
                    FromDocOccurrenceNo := 0;
                    FromDocVersionNo := 0;
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
        CopyDocumentMgt: Codeunit "Copy Document Mgt.";
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
        PurchDocType: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Receipt","Posted Invoice","Posted Return Shipment","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
        FromDocOccurrenceNo: Integer;
        FromDocVersionNo: Integer;
    begin
        if WithPurchHeader then begin
            TargetRecRef.GETTABLE(ToPurchHeader);
            if ExistLongtext(TargetRecRef) then
                if CONFIRM(HeaderExistsErr) then
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
                    FromPurchRcptLine.GET(FromPurchHeader."No.", FromPurchLine."lbt Source Document Line No.");
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
                    FromPurchInvLine.GET(FromPurchHeader."No.", FromPurchLine."lbt Source Document Line No.");
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
                    FromReturnShptLine.GET(FromPurchHeader."No.", FromPurchLine."lbt Source Document Line No.");
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
                    FromPurchCrMemoLine.GET(FromPurchHeader."No.", FromPurchLine."lbt Source Document Line No.");
                    SourceRecRef.GETTABLE(FromPurchCrMemoLine);
                    TargetRecRef.GETTABLE(ToPurchLine);
                    CopyLongtext(SourceRecRef, TargetRecRef);
                end;
            PurchDocType::"Arch. Order",
            PurchDocType::"Arch. Quote",
            PurchDocType::"Arch. Blanket Order",
            PurchDocType::"Arch. Return Order":
                begin
                    FromDocOccurrenceNo := 0;
                    FromDocVersionNo := 0;
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
        SalesLine."lbt Indentation" := TempSalesLine."lbt Indentation";
        SalesLine."lbt Pos. No." := TempSalesLine."lbt Pos. No.";
        SalesLine."lbt Printoption" := TempSalesLine."lbt Printoption";
        SalesLine."lbt Summation" := TempSalesLine."lbt Summation";
        if RunModify then
            SalesLine.Modify();
    end;

    procedure CopyFieldInfoAfterCreatePurchLine(var PurchaseLine: Record "Purchase Line"; var TempPurchaseLine: Record "Purchase Line" temporary; RunModify: Boolean)
    begin
        PurchaseLine."lbt Indentation" := TempPurchaseLine."lbt Indentation";
        PurchaseLine."lbt Pos. No." := TempPurchaseLine."lbt Pos. No.";
        PurchaseLine."lbt Printoption" := TempPurchaseLine."lbt Printoption";
        PurchaseLine."lbt Summation" := TempPurchaseLine."lbt Summation";
        if RunModify then
            PurchaseLine.Modify();
    end;

    procedure ShowLongtextLines(var SourceRecRef: RecordRef; Position: Option Header,Footer,Longtext)
    begin
        LookupLongtext(SourceRecRef, Position);
    end;

    local procedure LookupLongtext(SourceRecRef: RecordRef; Position: Option Header,Footer,Longtext)
    var
        LongtextRec: Record "lbt PS Longtext Line";
        PostedLongtextRec: Record "lbt Posted PS Longtext Line";
        ArchivedLongtextRec: Record "lbt Archive PS Longtext Line";
        SourceFieldRef: FieldRef;
        SourceDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        SourceDocumentNo: Code[20];
        SourceDocNoOcc: Integer;
        SourceVersionNo: Integer;
        SourceLineNo: Integer;
        SourceTableID: Integer;
    begin
        SourceTableID := SourceRecRef.Number();
        case SourceTableID of
            DATABASE::"Sales Header", DATABASE::"Sales Line",
            DATABASE::"Purchase Header", DATABASE::"Purchase Line":
                begin
                    // Filter bestimmen
                    SourceFieldRef := SourceRecRef.FIELD(1);
                    SourceDocumentType := SourceFieldRef.Value();
                    SourceFieldRef := SourceRecRef.FIELD(3);
                    SourceDocumentNo := SourceFieldRef.Value();
                    if SourceDocumentNo = '' then
                        exit;
                    if SourceTableID in [DATABASE::"Sales Line", DATABASE::"Purchase Line"] then begin
                        SourceFieldRef := SourceRecRef.FIELD(4);
                        SourceLineNo := SourceFieldRef.Value();
                        if SourceLineNo = 0 then
                            exit;
                    end else
                        SourceLineNo := 0;

                    //Filter setzen
                    LongtextRec.SetRange("Table ID", SourceTableID);
                    LongtextRec.SetRange("Document Type", SourceDocumentType);
                    LongtextRec.SetRange("Document No.", SourceDocumentNo);
                    LongtextRec.SetRange(Position, Position);
                    LongtextRec.SetRange("Document Line No.", SourceLineNo);

                    // Page öffnen
                    PAGE.RUNMODAL(PAGE::"lbt PS Longtext Lines", LongtextRec)
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
                    SourceDocumentNo := SourceFieldRef.Value();
                    if SourceDocumentNo = '' then
                        exit;
                    if SourceTableID in [DATABASE::"Sales Shipment Line", DATABASE::"Sales Invoice Line", DATABASE::"Sales Cr.Memo Line",
                                         DATABASE::"Purch. Rcpt. Line", DATABASE::"Purch. Inv. Line", DATABASE::"Purch. Cr. Memo Line",
                                         DATABASE::"Return Shipment Line", DATABASE::"Return Receipt Line"]
                    then begin
                        SourceFieldRef := SourceRecRef.FIELD(4);
                        SourceLineNo := SourceFieldRef.Value();
                        if SourceLineNo = 0 then
                            exit;
                    end else
                        SourceLineNo := 0;

                    //Filter setzen
                    PostedLongtextRec.SetRange("Table ID", SourceTableID);
                    PostedLongtextRec.SetRange("Document No.", SourceDocumentNo);
                    PostedLongtextRec.SetRange(Position, Position);
                    PostedLongtextRec.SetRange("Document Line No.", SourceLineNo);

                    // Page öffnen
                    PAGE.RUNMODAL(PAGE::"lbt Posted PS Longtext Lines", PostedLongtextRec)
                end;

            DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
            DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive":
                begin
                    // Filter bestimmen
                    SourceFieldRef := SourceRecRef.FIELD(1);
                    SourceDocumentType := SourceFieldRef.Value();
                    SourceFieldRef := SourceRecRef.FIELD(3);
                    SourceDocumentNo := SourceFieldRef.Value();
                    if SourceDocumentNo = '' then
                        exit;
                    if SourceTableID in [DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive"]
                    then begin
                        SourceFieldRef := SourceRecRef.FIELD(4);
                        SourceLineNo := SourceFieldRef.Value();
                        if SourceLineNo = 0 then
                            exit;
                    end else
                        SourceLineNo := 0;

                    SourceFieldRef := SourceRecRef.FIELD(5048);
                    SourceDocNoOcc := SourceFieldRef.Value();
                    SourceFieldRef := SourceRecRef.FIELD(5047);
                    SourceVersionNo := SourceFieldRef.Value();


                    //Filter setzen
                    ArchivedLongtextRec.SetRange("Table ID", SourceTableID);
                    ArchivedLongtextRec.SetRange("Document Type", SourceDocumentType);
                    ArchivedLongtextRec.SetRange("Document No.", SourceDocumentNo);
                    ArchivedLongtextRec.SetRange("Doc. No. Occurrence", SourceDocNoOcc);
                    ArchivedLongtextRec.SetRange("Version No.", SourceVersionNo);
                    ArchivedLongtextRec.SetRange(Position, Position);
                    ArchivedLongtextRec.SetRange("Document Line No.", SourceLineNo);

                    // Page öffnen
                    PAGE.RUNMODAL(PAGE::"lbt Arch. PS Longtext Lines", ArchivedLongtextRec)
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
        SourceTableID := SourceRecRef.Number();
        // Tabellen und Filterung über RecordRef's
        case SourceTableID of
            DATABASE::"Sales Header", DATABASE::"Sales Line",
        DATABASE::"Purchase Header", DATABASE::"Purchase Line":
                SourceLongtextRecRef.OPEN(DATABASE::"lbt PS Longtext Line");
            DATABASE::"Sales Shipment Header", DATABASE::"Sales Shipment Line",
        DATABASE::"Sales Invoice Header", DATABASE::"Sales Invoice Line",
        DATABASE::"Sales Cr.Memo Header", DATABASE::"Sales Cr.Memo Line",
        DATABASE::"Purch. Rcpt. Header", DATABASE::"Purch. Rcpt. Line",
        DATABASE::"Purch. Inv. Header", DATABASE::"Purch. Inv. Line",
        DATABASE::"Purch. Cr. Memo Hdr.", DATABASE::"Purch. Cr. Memo Line",
        DATABASE::"Return Shipment Header", DATABASE::"Return Shipment Line",
        DATABASE::"Return Receipt Header", DATABASE::"Return Receipt Line":
                SourceLongtextRecRef.OPEN(DATABASE::"lbt Posted PS Longtext Line");
            DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
        DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive":
                SourceLongtextRecRef.OPEN(DATABASE::"lbt Archive PS Longtext Line");
        end;
        SourceFieldRef := SourceLongtextRecRef.FIELD(1);
        SourceFieldRef.SetRange(SourceTableID);

        // Dokumentenart
        if SourceTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                             DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                             DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                             DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecRef.FIELD(1);
            SourceDocumentType := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecRef.FIELD(2);
            SourceFieldRef.SetRange(SourceDocumentType);
        end;

        // Dokumenten Nr.
        SourceFieldRef := SourceRecRef.FIELD(3);
        SourceDocumentNo := SourceFieldRef.Value();
        SourceFieldRef := SourceLongtextRecRef.FIELD(3);
        SourceFieldRef.SetRange(SourceDocumentNo);

        // Belegnr.-Häufigkeit + Versionsnr.
        if SourceTableID in [DATABASE::"Sales Header Archive", DATABASE::"Purchase Header Archive",
                             DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecRef.FIELD(5048);
            SourceDocNoOcc := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecRef.FIELD(8);
            SourceFieldRef.SetRange(SourceDocNoOcc);

            SourceFieldRef := SourceRecRef.FIELD(5047);
            SourceVersionNo := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecRef.FIELD(7);
            SourceFieldRef.SetRange(SourceVersionNo);
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
            SourceLineNo := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecRef.FIELD(5);
            SourceFieldRef.SetRange(SourceLineNo);
        end;

        // nicht leer, dann vorhanden :)
        exit(not SourceLongtextRecRef.IsEmpty());
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
        SourceTableID := SourceRecRef.Number();
        // Tabellen und Filterung über RecordRef's
        case SourceTableID of
            DATABASE::"Sales Header", DATABASE::"Sales Line",
        DATABASE::"Purchase Header", DATABASE::"Purchase Line":
                SourceLongtextRecRef.OPEN(DATABASE::"lbt PS Longtext Line");
            DATABASE::"Sales Shipment Header", DATABASE::"Sales Shipment Line",
        DATABASE::"Sales Invoice Header", DATABASE::"Sales Invoice Line",
        DATABASE::"Sales Cr.Memo Header", DATABASE::"Sales Cr.Memo Line",
        DATABASE::"Purch. Rcpt. Header", DATABASE::"Purch. Rcpt. Line",
        DATABASE::"Purch. Inv. Header", DATABASE::"Purch. Inv. Line",
        DATABASE::"Purch. Cr. Memo Hdr.", DATABASE::"Purch. Cr. Memo Line",
        DATABASE::"Return Shipment Header", DATABASE::"Return Shipment Line",
        DATABASE::"Return Receipt Header", DATABASE::"Return Receipt Line":
                SourceLongtextRecRef.OPEN(DATABASE::"lbt Posted PS Longtext Line");
            DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
        DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive":
                SourceLongtextRecRef.OPEN(DATABASE::"lbt Archive PS Longtext Line");
        end;
        SourceFieldRef := SourceLongtextRecRef.FIELD(1);
        SourceFieldRef.SetRange(SourceTableID);

        // Dokumententyp
        if SourceTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                             DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                             DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                             DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecRef.FIELD(1);
            SourceDocumentType := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecRef.FIELD(2);
            SourceFieldRef.SetRange(SourceDocumentType);
        end;

        // Dokumenten Nr.
        SourceFieldRef := SourceRecRef.FIELD(3);
        SourceDocumentNo := SourceFieldRef.Value();
        SourceFieldRef := SourceLongtextRecRef.FIELD(3);
        SourceFieldRef.SetRange(SourceDocumentNo);

        //  Belegnr.-Häufigkeit + Versionsnr.
        if SourceTableID in [DATABASE::"Sales Header Archive", DATABASE::"Purchase Header Archive",
                             DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecRef.FIELD(5048);
            SourceDocNoOcc := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecRef.FIELD(8);
            SourceFieldRef.SetRange(SourceDocNoOcc);

            SourceFieldRef := SourceRecRef.FIELD(5047);
            SourceVersionNo := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecRef.FIELD(7);
            SourceFieldRef.SetRange(SourceVersionNo);
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
            SourceLineNo := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecRef.FIELD(5);
            SourceFieldRef.SetRange(SourceLineNo);
        end;


        // 2. Ziel
        TargetTableID := TargetRecRef.Number();
        // Tabellen und Filterung über RecordRef's
        case TargetTableID of
            DATABASE::"Sales Header", DATABASE::"Sales Line",
        DATABASE::"Purchase Header", DATABASE::"Purchase Line":
                TargetLongtextRecRef.OPEN(DATABASE::"lbt PS Longtext Line");
            DATABASE::"Sales Shipment Header", DATABASE::"Sales Shipment Line",
        DATABASE::"Sales Invoice Header", DATABASE::"Sales Invoice Line",
        DATABASE::"Sales Cr.Memo Header", DATABASE::"Sales Cr.Memo Line",
        DATABASE::"Purch. Rcpt. Header", DATABASE::"Purch. Rcpt. Line",
        DATABASE::"Purch. Inv. Header", DATABASE::"Purch. Inv. Line",
        DATABASE::"Purch. Cr. Memo Hdr.", DATABASE::"Purch. Cr. Memo Line",
        DATABASE::"Return Shipment Header", DATABASE::"Return Shipment Line",
        DATABASE::"Return Receipt Header", DATABASE::"Return Receipt Line":
                TargetLongtextRecRef.OPEN(DATABASE::"lbt Posted PS Longtext Line");
            DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
        DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive":
                TargetLongtextRecRef.OPEN(DATABASE::"lbt Archive PS Longtext Line");
        end;
        TargetFieldRef := TargetLongtextRecRef.FIELD(1);
        TargetFieldRef.SetRange(TargetTableID);

        // Dokumententyp
        if TargetTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                             DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                             DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                             DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]
        then begin
            TargetFieldRef := TargetRecRef.FIELD(1);
            TargetDocumentType := TargetFieldRef.Value();
            TargetFieldRef := TargetLongtextRecRef.FIELD(2);
            TargetFieldRef.SetRange(TargetDocumentType);
        end;

        // Dokumenten Nr.
        TargetFieldRef := TargetRecRef.FIELD(3);
        TargetDocumentNo := TargetFieldRef.Value();
        TargetFieldRef := TargetLongtextRecRef.FIELD(3);
        TargetFieldRef.SetRange(TargetDocumentNo);

        //  Belegnr.-Häufigkeit + Versionsnr.
        if TargetTableID in [DATABASE::"Sales Header Archive", DATABASE::"Purchase Header Archive",
                             DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive"]
        then begin
            TargetFieldRef := TargetRecRef.FIELD(5048);
            TargetDocNoOcc := TargetFieldRef.Value();
            TargetFieldRef := TargetLongtextRecRef.FIELD(8);
            TargetFieldRef.SetRange(TargetDocNoOcc);

            TargetFieldRef := TargetRecRef.FIELD(5047);
            TargetVersionNo := TargetFieldRef.Value();
            TargetFieldRef := TargetLongtextRecRef.FIELD(7);
            TargetFieldRef.SetRange(TargetVersionNo);
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
            TargetLineNo := TargetFieldRef.Value();
            TargetFieldRef := TargetLongtextRecRef.FIELD(5);
            TargetFieldRef.SetRange(TargetLineNo);
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
                SourceFieldRef.SetRange(2); // Rechnung
                if SourceLongtextRecRef.IsEmpty() then
                    SourceFieldRef.SetRange(1); //Auftrag/Bestellung
            end;

            // wenn Ziel = Lieferschein, dann prüfen, ob separate Texte
            if (TargetTableID in [DATABASE::"Sales Shipment Header", DATABASE::"Purch. Rcpt. Header"])
            then begin
                SourceFieldRef := SourceLongtextRecRef.FIELD(2);
                SourceFieldRef.SetRange(6); // Lieferung
                if SourceLongtextRecRef.IsEmpty() then
                    SourceFieldRef.SetRange(1); // Auftrag/Bestellung
            end;

            // wenn Ziel = Auftrag, dann alles
            if (TargetTableID in [DATABASE::"Sales Header", DATABASE::"Purchase Header"]) and
               (TargetDocumentType = 1) // Auftrag/Bestellung
            then begin
                SourceFieldRef := SourceLongtextRecRef.FIELD(2);
                SourceFieldRef.SetRange();
            end;
        end;

        // Kopieren
        if SourceLongtextRecRef.FindSet() then begin
            // letzte Zielzeilennr. finden (falls beim Beleg kopieren noch da)
            if TargetLongtextRecRef.FindLast() then begin
                TargetFieldRef := TargetLongtextRecRef.FIELD(6);
                LineNo := TargetFieldRef.Value();
            end else
                LineNo := 0;
            repeat
                LineNo += 10000;
                TargetLongtextRecRef.Init();
                TargetFieldRef := TargetLongtextRecRef.FIELD(1);  // Table ID
                TargetFieldRef.Value := TargetTableID;
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
                    TargetFieldRef.Value := SourceFieldRef.Value();
                end else
                    if (TargetTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                                          DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                                          DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                                          DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"])
                    then begin
                        TargetFieldRef := TargetLongtextRecRef.FIELD(2);  // Document Type
                        TargetFieldRef.Value := TargetDocumentType;
                    end;

                TargetFieldRef := TargetLongtextRecRef.FIELD(3);  // Document No.
                TargetFieldRef.Value := TargetDocumentNo;
                SourceFieldRef := SourceLongtextRecRef.FIELD(4);  // Position
                TargetFieldRef := TargetLongtextRecRef.FIELD(4);  // Position
                TargetFieldRef.Value := SourceFieldRef.Value();
                TargetFieldRef := TargetLongtextRecRef.FIELD(5);  // Document Line No.
                TargetFieldRef.Value := TargetLineNo;
                TargetFieldRef := TargetLongtextRecRef.FIELD(6);  // Line No.
                TargetFieldRef.Value := LineNo;

                if TargetTableID in [DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                                     DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]
                then begin
                    TargetFieldRef := TargetLongtextRecRef.FIELD(7);  // Version No.
                    TargetFieldRef.Value := TargetVersionNo;
                    TargetFieldRef := TargetLongtextRecRef.FIELD(8);  // Doc. No. Occurrence
                    TargetFieldRef.Value := TargetDocNoOcc;
                end;
                SourceFieldRef := SourceLongtextRecRef.FIELD(10); // Type
                TargetFieldRef := TargetLongtextRecRef.FIELD(10); // Type
                TargetFieldRef.Value := SourceFieldRef.Value();
                SourceFieldRef := SourceLongtextRecRef.FIELD(11); // No.
                TargetFieldRef := TargetLongtextRecRef.FIELD(11); // No.
                TargetFieldRef.Value := SourceFieldRef.Value();
                SourceFieldRef := SourceLongtextRecRef.FIELD(12); // Description
                TargetFieldRef := TargetLongtextRecRef.FIELD(12); // Description
                TargetFieldRef.Value := SourceFieldRef.Value();

                if not TargetLongtextRecRef.Insert() then
                    TargetLongtextRecRef.Modify();
            until SourceLongtextRecRef.Next() = 0;
        end;
    end;

    procedure DelLongtext(SourceRecRef: RecordRef)
    var
        LongtextLineRec: Record "lbt PS Longtext Line";
        SourceFieldRef: FieldRef;
        SourceDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        SourceDocumentNo: Code[20];
        SourceTableID: Integer;
        SourceLineNo: Integer;
    begin
        SourceTableID := SourceRecRef.Number();
        if not (SourceTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                                  DATABASE::"Purchase Header", DATABASE::"Purchase Line"])
        then
            exit;

        SourceFieldRef := SourceRecRef.FIELD(1);
        SourceDocumentType := SourceFieldRef.Value();
        SourceFieldRef := SourceRecRef.FIELD(3);
        SourceDocumentNo := SourceFieldRef.Value();
        if SourceTableID in [DATABASE::"Sales Line", DATABASE::"Purchase Line"] then begin
            SourceFieldRef := SourceRecRef.FIELD(4);
            SourceLineNo := SourceFieldRef.Value();
        end else
            SourceLineNo := 0;

        LongtextLineRec.Reset();
        LongtextLineRec.SetRange("Table ID", SourceTableID);
        LongtextLineRec.SetRange("Document Type", SourceDocumentType);
        LongtextLineRec.SetRange("Document No.", SourceDocumentNo);
        LongtextLineRec.SetRange("Document Line No.", SourceLineNo);
        LongtextLineRec.DeleteAll();
    end;

    procedure InsertLongTextExtText(var PurchSalesTextRec: Record "lbt PS Longtext Line"; NewDocumentType: Integer)
    var
        ToPurchSalesTextRec: Record "lbt PS Longtext Line";
        FirstLine: Boolean;
        LineSpacing: Integer;
    begin
        ToPurchSalesTextRec.Reset();
        ToPurchSalesTextRec.SetRange("Table ID", PurchSalesTextRec."Table ID");
        ToPurchSalesTextRec.SetRange("Document Type", NewDocumentType);
        ToPurchSalesTextRec.SetRange("Document No.", PurchSalesTextRec."Document No.");
        ToPurchSalesTextRec.SetRange(Position, PurchSalesTextRec.Position);
        ToPurchSalesTextRec.SetRange("Document Line No.", PurchSalesTextRec."Document Line No.");
        ToPurchSalesTextRec := PurchSalesTextRec;
        if ToPurchSalesTextRec.FIND('>') then begin
            LineSpacing :=
              (ToPurchSalesTextRec."Line No." - PurchSalesTextRec."Line No.") div
              (1 + TempExtTextLineLongRec2.Count());
            if LineSpacing = 0 then
                ERROR(NotEnoughSpaceErr);
        end else
            LineSpacing := 10000;

        NextLineNo := PurchSalesTextRec."Line No." + LineSpacing;
        FirstLine := true;

        TempExtTextLineLongRec2.Reset();
        if TempExtTextLineLongRec2.FIND('-') then begin
            repeat
                if FirstLine then begin
                    PurchSalesTextRec.Description := TempExtTextLineLongRec2.Description;
                    PurchSalesTextRec.Modify();
                    FirstLine := false;
                end else begin
                    ToPurchSalesTextRec.Init();
                    ToPurchSalesTextRec."Table ID" := PurchSalesTextRec."Table ID";
                    ToPurchSalesTextRec."Document Type" := NewDocumentType;
                    ToPurchSalesTextRec."Document No." := PurchSalesTextRec."Document No.";
                    ToPurchSalesTextRec.Position := PurchSalesTextRec.Position;
                    ToPurchSalesTextRec."Document Line No." := PurchSalesTextRec."Document Line No.";
                    ToPurchSalesTextRec."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + LineSpacing;
                    ToPurchSalesTextRec.Description := TempExtTextLineLongRec2.Description;
                    ToPurchSalesTextRec.Type := ToPurchSalesTextRec.Type::"Text + Line break";
                    ToPurchSalesTextRec.Insert();
                end;
            until TempExtTextLineLongRec2.Next() = 0;
            MakeUpdateRequired := true;
        end;
        TempExtTextLineLongRec2.DeleteAll();
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
        ExtTextLineLongRec: Record "lbt Extended Text Line Long";
        InLongtext: Boolean;
    begin
        ExtTextHeader.SETCURRENTKEY(
          "Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
        ExtTextHeader.SetRange("Starting Date", 0D, DocDate);
        ExtTextHeader.SETFILTER("Ending Date", '%1..|%2', DocDate, 0D);
        if LanguageCode = '' then begin
            ExtTextHeader.SetRange("Language Code", '');
            if not ExtTextHeader.FindSet() then
                exit;
        end else begin
            ExtTextHeader.SetRange("Language Code", LanguageCode);
            if not ExtTextHeader.FindSet() then begin
                ExtTextHeader.SetRange("All Language Codes", true);
                ExtTextHeader.SetRange("Language Code", '');
                if not ExtTextHeader.FindSet() then
                    exit;
            end;
        end;

        if (ExtTextHeader."lbt Textchoice" = ExtTextHeader."lbt Textchoice"::standard) and (Longtext) then begin
            Longtext := false;
            InLongtext := true;
        end;

        if Longtext then begin
            ExtTextLineLongRec.SetRange(Table_ID, ExtTextHeader."Table Name");
            ExtTextLineLongRec.SetRange("No.", ExtTextHeader."No.");
            ExtTextLineLongRec.SetRange("Language Code", ExtTextHeader."Language Code");
            ExtTextLineLongRec.SetRange("Text No.", ExtTextHeader."Text No.");
            if ExtTextLineLongRec.FindSet() then begin
                TempExtTextLineLongRec2.DeleteAll();
                repeat
                    TempExtTextLineLongRec2 := ExtTextLineLongRec;
                    TempExtTextLineLongRec2.Insert();
                until ExtTextLineLongRec.Next() = 0;
                exit(true);
            end;
        end else
            if InLongtext then begin
                ExtTextLine.SetRange("Table Name", ExtTextHeader."Table Name");
                ExtTextLine.SetRange("No.", ExtTextHeader."No.");
                ExtTextLine.SetRange("Language Code", ExtTextHeader."Language Code");
                ExtTextLine.SetRange("Text No.", ExtTextHeader."Text No.");
                if ExtTextLine.FIND('-') then begin
                    TempExtTextLineLongRec2.DeleteAll();
                    repeat
                        TempExtTextLineLongRec2.TRANSFERFIELDS(ExtTextLine);
                        TempExtTextLineLongRec2.Insert();
                    until ExtTextLine.Next() = 0;
                    exit(true);
                end;
            end else begin
                TmpExtTextLine.DeleteAll();
                repeat
                    ExtTextLine.SetRange("Table Name", ExtTextHeader."Table Name");
                    ExtTextLine.SetRange("No.", ExtTextHeader."No.");
                    ExtTextLine.SetRange("Language Code", ExtTextHeader."Language Code");
                    ExtTextLine.SetRange("Text No.", ExtTextHeader."Text No.");
                    if ExtTextLine.FindSet() then begin
                        repeat
                            TmpExtTextLine := ExtTextLine;
                            TmpExtTextLine.Insert();
                        until ExtTextLine.Next() = 0;
                        Result := true;
                    end;
                until ExtTextHeader.Next() = 0;
            end;

    end;

    procedure EditorRef(var SourceRecRef: RecordRef; Editable: Boolean)
    var
        AllObjRec: Record AllObj;
        TargetRecRef: RecordRef;
        SourceFieldRef: FieldRef;
        TargetFieldRef: FieldRef;
        SourceKeyRef: KeyRef;
        TargetKeyRef: KeyRef;
        I: Integer;
        LineNoFieldNo: Integer;
        CommentFieldNo: Integer;
        SourceRecNo: Integer;
    begin
        // Filterung universell, Voraussetzung: letztes Feld im Primärschlüssel ist die Zeile

        SourceRecRef.CURRENTKEYINDEX(1);
        SourceKeyRef := SourceRecRef.KEYINDEX(1);

        TargetRecRef := SourceRecRef.Duplicate();
        TargetKeyRef := TargetRecRef.KEYINDEX(1);

        if SourceRecRef.HasFilter() then
            for I := 1 to SourceKeyRef.FieldCount() - 1 do begin
                SourceFieldRef := SourceKeyRef.FieldIndex(I);
                TargetFieldRef := TargetKeyRef.FieldIndex(I);
                TargetFieldRef.SETFILTER(SourceFieldRef.GetFilter());
            end
        else
            for I := 1 to SourceKeyRef.FieldCount() - 1 do begin
                SourceFieldRef := SourceKeyRef.FieldIndex(I);
                TargetFieldRef := TargetKeyRef.FieldIndex(I);
                TargetFieldRef.SetRange(SourceFieldRef.Value());
            end;


        // Feldnr. der Zeilennr.
        SourceFieldRef := SourceKeyRef.FieldIndex(SourceKeyRef.FieldCount());
        LineNoFieldNo := SourceFieldRef.Number();

        // Feldnr. der Bemerkung
        // Behandlung wenn Temp-Table, da muss über den Namen die richtige Objektnr. ermittelt werden
        SourceRecNo := SourceRecRef.Number();
        if SourceRecNo >= 2000100000 then begin
            AllObjRec.SetRange("Object Type", AllObjRec."Object Type"::Table);
            AllObjRec.SetRange("Object Name", SourceRecRef.Name());
            if AllObjRec.FindFirst() then
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
            DATABASE::"lbt Extended Text Line Long":
                CommentFieldNo := 6;
            // DATABASE::"Journal Line Memo":
            //     CommentFieldNo := 5;
            DATABASE::"lbt PS Longtext Line":
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
                ERROR(NotTableExistErr, SourceRecRef.Number(), SourceRecRef.Caption());
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

