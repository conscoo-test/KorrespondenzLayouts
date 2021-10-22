codeunit 5272723 "lbt Longtext Mgt."
{
    var
        TempExtendedTextLineLong: Record "lbt Extended Text Line Long" temporary;
        TempExtendedTextLine: Record "Extended Text Line" temporary;
        NotEnoughSpaceErr: Label 'There is not enough space to insert extended text lines.';
        NextLineNo: Integer;

    procedure CopyLongTextForGetShipmentLines(SalesShipmentLine: Record "Sales Shipment Line"; SalesLine: Record "Sales Line")
    var
        OrderSalesLine: Record "Sales Line";
    begin
        if (SalesShipmentLine.Type <> SalesShipmentLine.Type::" ") and
          OrderSalesLine.Get(OrderSalesLine."Document Type"::Order, SalesShipmentLine."Order No.", SalesShipmentLine."Order Line No.")
        then
            CopyLongtext(OrderSalesLine, SalesLine);
    end;

    procedure CopyLongTextForGetPurchRcptLines(PurchRcptLine: Record "Purch. Rcpt. Line"; PurchaseLine: Record "Purchase Line")
    var
        OrderPurchaseLine: Record "Purchase Line";
    begin
        if (PurchRcptLine.Type <> PurchRcptLine.Type::" ") and
          OrderPurchaseLine.Get(OrderPurchaseLine."Document Type"::Order, PurchRcptLine."Order No.", PurchRcptLine."Order Line No.")
        then
            CopyLongtext(OrderPurchaseLine, PurchaseLine);
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

    procedure ShowLongtextLines(SourceVariant: Variant; Position: Option Header,Footer,Longtext)
    var
        SourceRecordRef: RecordRef;
    begin
        SourceRecordRef.GetTable(SourceVariant);
        LookupLongtext(SourceRecordRef, Position);
    end;

    local procedure LookupLongtext(SourceRecordRef: RecordRef; Position: Option Header,Footer,Longtext)
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
        PostedPSLongtextLine: Record "lbt Posted PS Longtext Line";
        ArchivePSLongtextLine: Record "lbt Archive PS Longtext Line";
        SourceFieldRef: FieldRef;
        SourceDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        SourceDocumentNo: Code[20];
        SourceDocNoOcc: Integer;
        SourceVersionNo: Integer;
        SourceLineNo: Integer;
        SourceTableID: Integer;
    begin
        SourceTableID := SourceRecordRef.Number();
        case SourceTableID of
            DATABASE::"Sales Header", DATABASE::"Sales Line",
            DATABASE::"Purchase Header", DATABASE::"Purchase Line":
                begin
                    // Filter bestimmen
                    SourceFieldRef := SourceRecordRef.FIELD(1);
                    SourceDocumentType := SourceFieldRef.Value();
                    SourceFieldRef := SourceRecordRef.FIELD(3);
                    SourceDocumentNo := SourceFieldRef.Value();
                    if SourceDocumentNo = '' then
                        exit;
                    if SourceTableID in [DATABASE::"Sales Line", DATABASE::"Purchase Line"] then begin
                        SourceFieldRef := SourceRecordRef.FIELD(4);
                        SourceLineNo := SourceFieldRef.Value();
                        if SourceLineNo = 0 then
                            exit;
                    end else
                        SourceLineNo := 0;

                    //Filter setzen
                    PSLongtextLine.SetRange("Table ID", SourceTableID);
                    PSLongtextLine.SetRange("Document Type", SourceDocumentType);
                    PSLongtextLine.SetRange("Document No.", SourceDocumentNo);
                    PSLongtextLine.SetRange(Position, Position);
                    PSLongtextLine.SetRange("Document Line No.", SourceLineNo);

                    // Page öffnen
                    PAGE.RUNMODAL(PAGE::"lbt PS Longtext Lines", PSLongtextLine)
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
                    SourceFieldRef := SourceRecordRef.FIELD(3);
                    SourceDocumentNo := SourceFieldRef.Value();
                    if SourceDocumentNo = '' then
                        exit;
                    if SourceTableID in [DATABASE::"Sales Shipment Line", DATABASE::"Sales Invoice Line", DATABASE::"Sales Cr.Memo Line",
                                         DATABASE::"Purch. Rcpt. Line", DATABASE::"Purch. Inv. Line", DATABASE::"Purch. Cr. Memo Line",
                                         DATABASE::"Return Shipment Line", DATABASE::"Return Receipt Line"]
                    then begin
                        SourceFieldRef := SourceRecordRef.FIELD(4);
                        SourceLineNo := SourceFieldRef.Value();
                        if SourceLineNo = 0 then
                            exit;
                    end else
                        SourceLineNo := 0;

                    //Filter setzen
                    PostedPSLongtextLine.SetRange("Table ID", SourceTableID);
                    PostedPSLongtextLine.SetRange("Document No.", SourceDocumentNo);
                    PostedPSLongtextLine.SetRange(Position, Position);
                    PostedPSLongtextLine.SetRange("Document Line No.", SourceLineNo);

                    // Page öffnen
                    PAGE.RUNMODAL(PAGE::"lbt Posted PS Longtext Lines", PostedPSLongtextLine)
                end;

            DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
            DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive":
                begin
                    // Filter bestimmen
                    SourceFieldRef := SourceRecordRef.FIELD(1);
                    SourceDocumentType := SourceFieldRef.Value();
                    SourceFieldRef := SourceRecordRef.FIELD(3);
                    SourceDocumentNo := SourceFieldRef.Value();
                    if SourceDocumentNo = '' then
                        exit;
                    if SourceTableID in [DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive"]
                    then begin
                        SourceFieldRef := SourceRecordRef.FIELD(4);
                        SourceLineNo := SourceFieldRef.Value();
                        if SourceLineNo = 0 then
                            exit;
                    end else
                        SourceLineNo := 0;

                    SourceFieldRef := SourceRecordRef.FIELD(5048);
                    SourceDocNoOcc := SourceFieldRef.Value();
                    SourceFieldRef := SourceRecordRef.FIELD(5047);
                    SourceVersionNo := SourceFieldRef.Value();


                    //Filter setzen
                    ArchivePSLongtextLine.SetRange("Table ID", SourceTableID);
                    ArchivePSLongtextLine.SetRange("Document Type", SourceDocumentType);
                    ArchivePSLongtextLine.SetRange("Document No.", SourceDocumentNo);
                    ArchivePSLongtextLine.SetRange("Doc. No. Occurrence", SourceDocNoOcc);
                    ArchivePSLongtextLine.SetRange("Version No.", SourceVersionNo);
                    ArchivePSLongtextLine.SetRange(Position, Position);
                    ArchivePSLongtextLine.SetRange("Document Line No.", SourceLineNo);

                    // Page öffnen
                    PAGE.RUNMODAL(PAGE::"lbt Arch. PS Longtext Lines", ArchivePSLongtextLine)
                end;
        end;
    end;

    procedure ExistLongtext(SourceVariant: Variant): Boolean
    var
        SourceRecordRef: RecordRef;
    begin
        SourceRecordRef.GetTable(SourceVariant);
        exit(ExistLongtext(SourceRecordRef))
    end;

    procedure ExistLongtext(SourceRecordRef: RecordRef): Boolean
    var
        SourceLongtextRecordRef: RecordRef;
        SourceFieldRef: FieldRef;
        SourceDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        SourceDocumentNo: Code[20];
        SourceTableID: Integer;
        SourceDocNoOcc: Integer;
        SourceVersionNo: Integer;
        SourceLineNo: Integer;
    begin
        // 1. Herkunft
        SourceTableID := SourceRecordRef.Number();
        // Tabellen und Filterung über RecordRef's
        case SourceTableID of
            DATABASE::"Sales Header", DATABASE::"Sales Line",
        DATABASE::"Purchase Header", DATABASE::"Purchase Line":
                SourceLongtextRecordRef.OPEN(DATABASE::"lbt PS Longtext Line");
            DATABASE::"Sales Shipment Header", DATABASE::"Sales Shipment Line",
        DATABASE::"Sales Invoice Header", DATABASE::"Sales Invoice Line",
        DATABASE::"Sales Cr.Memo Header", DATABASE::"Sales Cr.Memo Line",
        DATABASE::"Purch. Rcpt. Header", DATABASE::"Purch. Rcpt. Line",
        DATABASE::"Purch. Inv. Header", DATABASE::"Purch. Inv. Line",
        DATABASE::"Purch. Cr. Memo Hdr.", DATABASE::"Purch. Cr. Memo Line",
        DATABASE::"Return Shipment Header", DATABASE::"Return Shipment Line",
        DATABASE::"Return Receipt Header", DATABASE::"Return Receipt Line":
                SourceLongtextRecordRef.OPEN(DATABASE::"lbt Posted PS Longtext Line");
            DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
        DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive":
                SourceLongtextRecordRef.OPEN(DATABASE::"lbt Archive PS Longtext Line");
        end;
        SourceFieldRef := SourceLongtextRecordRef.FIELD(1);
        SourceFieldRef.SetRange(SourceTableID);

        // Dokumentenart
        if SourceTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                             DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                             DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                             DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecordRef.FIELD(1);
            SourceDocumentType := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.FIELD(2);
            SourceFieldRef.SetRange(SourceDocumentType);
        end;

        // Dokumenten Nr.
        SourceFieldRef := SourceRecordRef.FIELD(3);
        SourceDocumentNo := SourceFieldRef.Value();
        SourceFieldRef := SourceLongtextRecordRef.FIELD(3);
        SourceFieldRef.SetRange(SourceDocumentNo);

        // Belegnr.-Häufigkeit + Versionsnr.
        if SourceTableID in [DATABASE::"Sales Header Archive", DATABASE::"Purchase Header Archive",
                             DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecordRef.FIELD(5048);
            SourceDocNoOcc := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.FIELD(8);
            SourceFieldRef.SetRange(SourceDocNoOcc);

            SourceFieldRef := SourceRecordRef.FIELD(5047);
            SourceVersionNo := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.FIELD(7);
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
            SourceFieldRef := SourceRecordRef.FIELD(4);
            SourceLineNo := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.FIELD(5);
            SourceFieldRef.SetRange(SourceLineNo);
        end;

        // nicht leer, dann vorhanden :)
        exit(not SourceLongtextRecordRef.IsEmpty());
    end;


    procedure CopyLongtext(SourceVariant: Variant; TargetVariant: Variant)
    var
        SourceRecordRef: RecordRef;
        TargetRecordRef: RecordRef;
    begin
        SourceRecordRef.GetTable(SourceVariant);
        TargetRecordRef.GetTable(TargetVariant);
        CopyLongtext(SourceRecordRef, TargetRecordRef);
    end;

    procedure CopyLongtext(SourceRecordRef: RecordRef; TargetRecordRef: RecordRef)
    var
        SourceLongtextRecordRef: RecordRef;
        TargetLongtextRecordRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
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
        handled: Boolean;

    begin
        // Funktion derzeit nur fürs Kopieren von Belegen, nicht das verbuchen/Archivieren von Belegen
        // Könnte jedoch bei beid Bedarf und Gelegenheit zusammengeführt werden

        // 1. Herkunft
        onbeforeCopyLongtext(sourcerecordref, targetRecordref, handled);
        if handled then
            exit;
        SourceTableID := SourceRecordRef.Number();
        // Tabellen und Filterung über RecordRef's
        case SourceTableID of
            DATABASE::"Sales Header", DATABASE::"Sales Line",
        DATABASE::"Purchase Header", DATABASE::"Purchase Line":
                SourceLongtextRecordRef.OPEN(DATABASE::"lbt PS Longtext Line");
            DATABASE::"Sales Shipment Header", DATABASE::"Sales Shipment Line",
        DATABASE::"Sales Invoice Header", DATABASE::"Sales Invoice Line",
        DATABASE::"Sales Cr.Memo Header", DATABASE::"Sales Cr.Memo Line",
        DATABASE::"Purch. Rcpt. Header", DATABASE::"Purch. Rcpt. Line",
        DATABASE::"Purch. Inv. Header", DATABASE::"Purch. Inv. Line",
        DATABASE::"Purch. Cr. Memo Hdr.", DATABASE::"Purch. Cr. Memo Line",
        DATABASE::"Return Shipment Header", DATABASE::"Return Shipment Line",
        DATABASE::"Return Receipt Header", DATABASE::"Return Receipt Line":
                SourceLongtextRecordRef.OPEN(DATABASE::"lbt Posted PS Longtext Line");
            DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
        DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive":
                SourceLongtextRecordRef.OPEN(DATABASE::"lbt Archive PS Longtext Line");

        end;
        SourceFieldRef := SourceLongtextRecordRef.FIELD(1);
        SourceFieldRef.SetRange(SourceTableID);

        // Dokumententyp
        if SourceTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                             DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                             DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                             DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecordRef.FIELD(1);
            SourceDocumentType := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.FIELD(2);
            SourceFieldRef.SetRange(SourceDocumentType);
        end;
        if SourceTableID in [DATABASE::"Service Header", database::"service line", database::"Service item Line"]
        then begin
            SourceFieldRef := SourceRecordRef.FIELD(43);
            SourceDocumentType := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.FIELD(43);
            SourceFieldRef.SetRange(SourceDocumentType);
        end;


        // Dokumenten Nr.
        SourceFieldRef := SourceRecordRef.FIELD(3);
        SourceDocumentNo := SourceFieldRef.Value();
        SourceFieldRef := SourceLongtextRecordRef.FIELD(3);
        SourceFieldRef.SetRange(SourceDocumentNo);


        //  Belegnr.-Häufigkeit + Versionsnr.
        if SourceTableID in [DATABASE::"Sales Header Archive", DATABASE::"Purchase Header Archive",
                             DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecordRef.FIELD(5048);
            SourceDocNoOcc := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.FIELD(8);
            SourceFieldRef.SetRange(SourceDocNoOcc);

            SourceFieldRef := SourceRecordRef.FIELD(5047);
            SourceVersionNo := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.FIELD(7);
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
            SourceFieldRef := SourceRecordRef.FIELD(4);
            SourceLineNo := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.FIELD(5);
            SourceFieldRef.SetRange(SourceLineNo);
        end;



        // 2. Ziel
        TargetTableID := TargetRecordRef.Number();
        // Tabellen und Filterung über RecordRef's
        case TargetTableID of
            DATABASE::"Sales Header", DATABASE::"Sales Line",
        DATABASE::"Purchase Header", DATABASE::"Purchase Line":
                TargetLongtextRecordRef.OPEN(DATABASE::"lbt PS Longtext Line");
            DATABASE::"Sales Shipment Header", DATABASE::"Sales Shipment Line",
        DATABASE::"Sales Invoice Header", DATABASE::"Sales Invoice Line",
        DATABASE::"Sales Cr.Memo Header", DATABASE::"Sales Cr.Memo Line",
        DATABASE::"Purch. Rcpt. Header", DATABASE::"Purch. Rcpt. Line",
        DATABASE::"Purch. Inv. Header", DATABASE::"Purch. Inv. Line",
        DATABASE::"Purch. Cr. Memo Hdr.", DATABASE::"Purch. Cr. Memo Line",
        DATABASE::"Return Shipment Header", DATABASE::"Return Shipment Line",
        DATABASE::"Return Receipt Header", DATABASE::"Return Receipt Line":
                TargetLongtextRecordRef.OPEN(DATABASE::"lbt Posted PS Longtext Line");
            DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
        DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive":
                TargetLongtextRecordRef.OPEN(DATABASE::"lbt Archive PS Longtext Line");
        end;
        TargetFieldRef := TargetLongtextRecordRef.FIELD(1);
        TargetFieldRef.SetRange(TargetTableID);

        // Dokumententyp
        if TargetTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                             DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                             DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                             DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]
        then begin
            TargetFieldRef := TargetRecordRef.FIELD(1);
            TargetDocumentType := TargetFieldRef.Value();
            TargetFieldRef := TargetLongtextRecordRef.FIELD(2);
            TargetFieldRef.SetRange(TargetDocumentType);
        end;

        // Dokumenten Nr.
        TargetFieldRef := TargetRecordRef.FIELD(3);
        TargetDocumentNo := TargetFieldRef.Value();
        TargetFieldRef := TargetLongtextRecordRef.FIELD(3);
        TargetFieldRef.SetRange(TargetDocumentNo);

        //  Belegnr.-Häufigkeit + Versionsnr.
        if TargetTableID in [DATABASE::"Sales Header Archive", DATABASE::"Purchase Header Archive",
                             DATABASE::"Sales Line Archive", DATABASE::"Purchase Line Archive"]
        then begin
            TargetFieldRef := TargetRecordRef.FIELD(5048);
            TargetDocNoOcc := TargetFieldRef.Value();
            TargetFieldRef := TargetLongtextRecordRef.FIELD(8);
            TargetFieldRef.SetRange(TargetDocNoOcc);

            TargetFieldRef := TargetRecordRef.FIELD(5047);
            TargetVersionNo := TargetFieldRef.Value();
            TargetFieldRef := TargetLongtextRecordRef.FIELD(7);
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
            TargetFieldRef := TargetRecordRef.FIELD(4);
            TargetLineNo := TargetFieldRef.Value();
            TargetFieldRef := TargetLongtextRecordRef.FIELD(5);
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
                SourceFieldRef := SourceLongtextRecordRef.FIELD(2);
                SourceFieldRef.SetRange(2); // Rechnung
                if SourceLongtextRecordRef.IsEmpty() then
                    SourceFieldRef.SetRange(1); //Auftrag/Bestellung
            end;

            // wenn Ziel = Lieferschein, dann prüfen, ob separate Texte
            if (TargetTableID in [DATABASE::"Sales Shipment Header", DATABASE::"Purch. Rcpt. Header"])
            then begin
                SourceFieldRef := SourceLongtextRecordRef.FIELD(2);
                SourceFieldRef.SetRange(6); // Lieferung
                if SourceLongtextRecordRef.IsEmpty() then
                    SourceFieldRef.SetRange(1); // Auftrag/Bestellung
            end;

            // wenn Ziel = Auftrag, dann alles
            if (TargetTableID in [DATABASE::"Sales Header", DATABASE::"Purchase Header"]) and
               (TargetDocumentType = 1) // Auftrag/Bestellung
            then begin
                SourceFieldRef := SourceLongtextRecordRef.FIELD(2);
                SourceFieldRef.SetRange();
            end;
        end;

        // Kopieren
        if SourceLongtextRecordRef.FindSet() then begin
            // letzte Zielzeilennr. finden (falls beim Beleg kopieren noch da)
            if TargetLongtextRecordRef.FindLast() then begin
                TargetFieldRef := TargetLongtextRecordRef.FIELD(6);
                LineNo := TargetFieldRef.Value();
            end else
                LineNo := 0;
            repeat
                LineNo += 10000;
                TargetLongtextRecordRef.Init();
                TargetFieldRef := TargetLongtextRecordRef.FIELD(1);  // Table ID
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
                    SourceFieldRef := SourceLongtextRecordRef.FIELD(2);  // Document Type
                    TargetFieldRef := TargetLongtextRecordRef.FIELD(2);  // Document Type
                    TargetFieldRef.Value := SourceFieldRef.Value();
                end else
                    if (TargetTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                                          DATABASE::"Purchase Header", DATABASE::"Purchase Line",
                                          DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                                          DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"])
                    then begin
                        TargetFieldRef := TargetLongtextRecordRef.FIELD(2);  // Document Type
                        TargetFieldRef.Value := TargetDocumentType;
                    end;

                TargetFieldRef := TargetLongtextRecordRef.FIELD(3);  // Document No.
                TargetFieldRef.Value := TargetDocumentNo;
                SourceFieldRef := SourceLongtextRecordRef.FIELD(4);  // Position
                TargetFieldRef := TargetLongtextRecordRef.FIELD(4);  // Position
                TargetFieldRef.Value := SourceFieldRef.Value();
                TargetFieldRef := TargetLongtextRecordRef.FIELD(5);  // Document Line No.
                TargetFieldRef.Value := TargetLineNo;
                TargetFieldRef := TargetLongtextRecordRef.FIELD(6);  // Line No.
                TargetFieldRef.Value := LineNo;

                if TargetTableID in [DATABASE::"Sales Header Archive", DATABASE::"Sales Line Archive",
                                     DATABASE::"Purchase Header Archive", DATABASE::"Purchase Line Archive"]
                then begin
                    TargetFieldRef := TargetLongtextRecordRef.FIELD(7);  // Version No.
                    TargetFieldRef.Value := TargetVersionNo;
                    TargetFieldRef := TargetLongtextRecordRef.FIELD(8);  // Doc. No. Occurrence
                    TargetFieldRef.Value := TargetDocNoOcc;
                end;
                SourceFieldRef := SourceLongtextRecordRef.FIELD(10); // Type
                TargetFieldRef := TargetLongtextRecordRef.FIELD(10); // Type
                TargetFieldRef.Value := SourceFieldRef.Value();
                SourceFieldRef := SourceLongtextRecordRef.FIELD(11); // No.
                TargetFieldRef := TargetLongtextRecordRef.FIELD(11); // No.
                TargetFieldRef.Value := SourceFieldRef.Value();
                SourceFieldRef := SourceLongtextRecordRef.FIELD(12); // Description
                TargetFieldRef := TargetLongtextRecordRef.FIELD(12); // Description
                TargetFieldRef.Value := SourceFieldRef.Value();

                SourceFieldRef := SourceLongtextRecordRef.FIELD(21); // Editor
                TargetFieldRef := TargetLongtextRecordRef.field(21); //Editor
                clear(TempBlob);
                TempBlob.FromFieldRef(SourceFieldRef);
                TempBlob.ToFieldRef(TargetfieldRef);

                if not TargetLongtextRecordRef.Insert() then
                    TargetLongtextRecordRef.Modify();
            until SourceLongtextRecordRef.Next() = 0;
        end;
    end;

    procedure DelLongtext(SourceVariant: Variant)
    var
        SourceRecordRef: RecordRef;
    begin
        SourceRecordRef.GetTable(SourceVariant);
        DelLongtext(SourceRecordRef);
    end;

    procedure DelLongtext(SourceRecordRef: RecordRef)
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
        SourceFieldRef: FieldRef;
        SourceDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        SourceDocumentNo: Code[20];
        SourceTableID: Integer;
        SourceLineNo: Integer;
    begin
        SourceTableID := SourceRecordRef.Number();
        if not (SourceTableID in [DATABASE::"Sales Header", DATABASE::"Sales Line",
                                  DATABASE::"Purchase Header", DATABASE::"Purchase Line"])
        then
            exit;

        SourceFieldRef := SourceRecordRef.FIELD(1);
        SourceDocumentType := SourceFieldRef.Value();
        SourceFieldRef := SourceRecordRef.FIELD(3);
        SourceDocumentNo := SourceFieldRef.Value();
        if SourceTableID in [DATABASE::"Sales Line", DATABASE::"Purchase Line"] then begin
            SourceFieldRef := SourceRecordRef.FIELD(4);
            SourceLineNo := SourceFieldRef.Value();
        end else
            SourceLineNo := 0;

        PSLongtextLine.Reset();
        PSLongtextLine.SetRange("Table ID", SourceTableID);
        PSLongtextLine.SetRange("Document Type", SourceDocumentType);
        PSLongtextLine.SetRange("Document No.", SourceDocumentNo);
        PSLongtextLine.SetRange("Document Line No.", SourceLineNo);
        PSLongtextLine.DeleteAll();
    end;

    procedure InsertLongTextExtText(var FromPSLongtextLine: Record "lbt PS Longtext Line"; NewDocumentType: Integer)
    var
        ToPSLongtextLine: Record "lbt PS Longtext Line";
        FirstLine: Boolean;
        LineSpacing: Integer;
    begin
        ToPSLongtextLine.Reset();
        ToPSLongtextLine.SetRange("Table ID", FromPSLongtextLine."Table ID");
        ToPSLongtextLine.SetRange("Document Type", NewDocumentType);
        ToPSLongtextLine.SetRange("Document No.", FromPSLongtextLine."Document No.");
        ToPSLongtextLine.SetRange(Position, FromPSLongtextLine.Position);
        ToPSLongtextLine.SetRange("Document Line No.", FromPSLongtextLine."Document Line No.");
        ToPSLongtextLine := FromPSLongtextLine;
        if ToPSLongtextLine.FIND('>') then begin
            LineSpacing :=
              (ToPSLongtextLine."Line No." - FromPSLongtextLine."Line No.") div
              (1 + TempExtendedTextLineLong.Count());
            if LineSpacing = 0 then
                ERROR(NotEnoughSpaceErr);
        end else
            LineSpacing := 10000;

        NextLineNo := FromPSLongtextLine."Line No." + LineSpacing;
        FirstLine := true;

        TempExtendedTextLineLong.Reset();
        if TempExtendedTextLineLong.FIND('-') then
            repeat
                if FirstLine then begin
                    FromPSLongtextLine.Description := TempExtendedTextLineLong.Description;
                    FromPSLongtextLine.Type := ToPSLongtextLine.Type::"Text + Line break";
                    FromPSLongtextLine.Modify();
                    FirstLine := false;
                end else begin
                    ToPSLongtextLine.Init();
                    ToPSLongtextLine."Table ID" := FromPSLongtextLine."Table ID";
                    ToPSLongtextLine."Document Type" := NewDocumentType;
                    ToPSLongtextLine."Document No." := FromPSLongtextLine."Document No.";
                    ToPSLongtextLine.Position := FromPSLongtextLine.Position;
                    ToPSLongtextLine."Document Line No." := FromPSLongtextLine."Document Line No.";
                    ToPSLongtextLine."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + LineSpacing;
                    ToPSLongtextLine.Description := TempExtendedTextLineLong.Description;
                    ToPSLongtextLine.Type := ToPSLongtextLine.Type::"Text + Line break";
                    ToPSLongtextLine.Insert();
                end;
            until TempExtendedTextLineLong.Next() = 0;
        TempExtendedTextLineLong.DeleteAll();
    end;

    procedure LongTextCheckIfAnyExtText(var ExtendedTextHeader: Record "Extended Text Header"; Language: Code[10]; DocumentDate: Date): Boolean
    begin
        exit(ReadLines(ExtendedTextHeader, DocumentDate, Language, true));
    end;

    local procedure ReadLines(var ExtendedTextHeader: Record "Extended Text Header"; DocDate: Date; LanguageCode: Code[10]; Longtext: Boolean) Result: Boolean
    var
        ExtendedTextLine: Record "Extended Text Line";
        ExtendedTextLineLong: Record "lbt Extended Text Line Long";
        InLongtext: Boolean;
    begin
        ExtendedTextHeader.SETCURRENTKEY(
          "Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
        ExtendedTextHeader.SetRange("Starting Date", 0D, DocDate);
        ExtendedTextHeader.SETFILTER("Ending Date", '%1..|%2', DocDate, 0D);
        if LanguageCode = '' then begin
            ExtendedTextHeader.SetRange("Language Code", '');
            if not ExtendedTextHeader.FindSet() then
                exit;
        end else begin
            ExtendedTextHeader.SetRange("Language Code", LanguageCode);
            if not ExtendedTextHeader.FindSet() then begin
                ExtendedTextHeader.SetRange("All Language Codes", true);
                ExtendedTextHeader.SetRange("Language Code", '');
                if not ExtendedTextHeader.FindSet() then
                    exit;
            end;
        end;

        if (ExtendedTextHeader."lbt Textchoice" = ExtendedTextHeader."lbt Textchoice"::standard) and (Longtext) then begin
            Longtext := false;
            InLongtext := true;
        end;

        if Longtext then begin
            ExtendedTextLineLong.SetRange(Table_ID, ExtendedTextHeader."Table Name");
            ExtendedTextLineLong.SetRange("No.", ExtendedTextHeader."No.");
            ExtendedTextLineLong.SetRange("Language Code", ExtendedTextHeader."Language Code");
            ExtendedTextLineLong.SetRange("Text No.", ExtendedTextHeader."Text No.");
            if ExtendedTextLineLong.FindSet() then begin
                TempExtendedTextLineLong.DeleteAll();
                repeat
                    TempExtendedTextLineLong := ExtendedTextLineLong;
                    TempExtendedTextLineLong.Insert();
                until ExtendedTextLineLong.Next() = 0;
                exit(true);
            end;
        end else
            if InLongtext then begin
                ExtendedTextLine.SetRange("Table Name", ExtendedTextHeader."Table Name");
                ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
                ExtendedTextLine.SetRange("Language Code", ExtendedTextHeader."Language Code");
                ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
                if ExtendedTextLine.FIND('-') then begin
                    TempExtendedTextLineLong.DeleteAll();
                    repeat
                        TempExtendedTextLineLong.TRANSFERFIELDS(ExtendedTextLine);
                        TempExtendedTextLineLong.Insert();
                    until ExtendedTextLine.Next() = 0;
                    exit(true);
                end;
            end else begin
                TempExtendedTextLine.DeleteAll();
                repeat
                    ExtendedTextLine.SetRange("Table Name", ExtendedTextHeader."Table Name");
                    ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
                    ExtendedTextLine.SetRange("Language Code", ExtendedTextHeader."Language Code");
                    ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
                    if ExtendedTextLine.FindSet() then begin
                        repeat
                            TempExtendedTextLine := ExtendedTextLine;
                            TempExtendedTextLine.Insert();
                        until ExtendedTextLine.Next() = 0;
                        Result := true;
                    end;
                until ExtendedTextHeader.Next() = 0;
            end;

    end;

    [BusinessEvent(true)]
    local procedure onbeforeCopyLongText(Sourcerecref: recordref; targetRecRef: recordref; var handled: Boolean)
    begin
    end;
}

