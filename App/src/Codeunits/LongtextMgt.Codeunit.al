codeunit 50723 "lbt Longtext Mgt."
{
    var
        TempExtendedTextLineLong: Record "lbt Extended Text Line Long" temporary;
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

    local procedure LookupLongtextLines(SourceRecordRef: RecordRef; Position: Option Header,Footer,Longtext)
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
        TempSalesLine: Record "Sales Line" temporary;
        SourceDocumentType: Integer;
        SourceDocumentNo: Code[20];
        SourceLineNo: Integer;
        SourceTableID: Integer;
    begin
        SourceTableID := SourceRecordRef.Number();

        // Filter bestimmen
        SourceDocumentType := GetValue(SourceRecordRef, TempSalesLine.FieldNo("Document Type"));
        SourceDocumentNo := GetValue(SourceRecordRef, TempSalesLine.FieldNo("Document No."));
        if SourceDocumentNo = '' then
            exit;
        if SourceTableID in [Database::"Sales Line", Database::"Purchase Line"] then begin
            SourceLineNo := GetValue(SourceRecordRef, TempSalesLine.FieldNo("Line No."));
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
        Page.RunModal(Page::"lbt PS Longtext Lines", PSLongtextLine)
    end;

    local procedure LookupPostedLongtextLines(SourceRecordRef: RecordRef; Position: Option Header,Footer,Longtext)
    var
        PostedPSLongtextLine: Record "lbt Posted PS Longtext Line";
        TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
        SourceDocumentNo: Code[20];
        SourceLineNo: Integer;
        SourceTableID: Integer;
    begin
        SourceTableID := SourceRecordRef.Number();

        // Filter bestimmen
        SourceDocumentNo := GetValue(SourceRecordRef, TempSalesInvoiceLine.FieldNo("Document No."));
        if SourceDocumentNo = '' then
            exit;
        if SourceTableID in [Database::"Sales Shipment Line", Database::"Sales Invoice Line", Database::"Sales Cr.Memo Line",
                             Database::"Purch. Rcpt. Line", Database::"Purch. Inv. Line", Database::"Purch. Cr. Memo Line",
                             Database::"Return Shipment Line", Database::"Return Receipt Line"]
        then begin
            SourceLineNo := GetValue(SourceRecordRef, TempSalesInvoiceLine.FieldNo("Line No."));
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
        Page.RunModal(Page::"lbt Posted PS Longtext Lines", PostedPSLongtextLine)
    end;

    local procedure LookupArchiveLongtextLines(SourceRecordRef: RecordRef; Position: Option Header,Footer,Longtext)
    var
        ArchivePSLongtextLine: Record "lbt Archive PS Longtext Line";
        TempSalesLineArchive: Record "Sales Line Archive" temporary;
        SourceDocumentType: Integer;
        SourceDocumentNo: Code[20];
        SourceDocNoOcc: Integer;
        SourceVersionNo: Integer;
        SourceLineNo: Integer;
        SourceTableID: Integer;
    begin
        SourceTableID := SourceRecordRef.Number();

        // Filter bestimmen
        SourceDocumentType := GetValue(SourceRecordRef, TempSalesLineArchive.FieldNo("Document Type"));
        SourceDocumentNo := GetValue(SourceRecordRef, TempSalesLineArchive.FieldNo("Document No."));
        if SourceDocumentNo = '' then
            exit;
        if SourceTableID in [Database::"Sales Line Archive", Database::"Purchase Line Archive"]
        then begin
            SourceLineNo := GetValue(SourceRecordRef, TempSalesLineArchive.FieldNo("Line No."));
            if SourceLineNo = 0 then
                exit;
        end else
            SourceLineNo := 0;
        SourceDocNoOcc := GetValue(SourceRecordRef, TempSalesLineArchive.FieldNo("Doc. No. Occurrence"));
        SourceVersionNo := GetValue(SourceRecordRef, TempSalesLineArchive.FieldNo("Version No."));

        //Filter setzen
        ArchivePSLongtextLine.SetRange("Table ID", SourceTableID);
        ArchivePSLongtextLine.SetRange("Document Type", SourceDocumentType);
        ArchivePSLongtextLine.SetRange("Document No.", SourceDocumentNo);
        ArchivePSLongtextLine.SetRange("Doc. No. Occurrence", SourceDocNoOcc);
        ArchivePSLongtextLine.SetRange("Version No.", SourceVersionNo);
        ArchivePSLongtextLine.SetRange(Position, Position);
        ArchivePSLongtextLine.SetRange("Document Line No.", SourceLineNo);

        // Page öffnen
        Page.RunModal(Page::"lbt Arch. PS Longtext Lines", ArchivePSLongtextLine)
    end;

    local procedure LookupLongtext(SourceRecordRef: RecordRef; Position: Option Header,Footer,Longtext)
    begin
        case SourceRecordRef.Number() of
            Database::"Sales Header", Database::"Sales Line",
            Database::"Purchase Header", Database::"Purchase Line":
                LookupLongtextLines(SourceRecordRef, Position);

            Database::"Sales Shipment Header", Database::"Sales Shipment Line",
            Database::"Sales Invoice Header", Database::"Sales Invoice Line",
            Database::"Sales Cr.Memo Header", Database::"Sales Cr.Memo Line",
            Database::"Purch. Rcpt. Header", Database::"Purch. Rcpt. Line",
            Database::"Purch. Inv. Header", Database::"Purch. Inv. Line",
            Database::"Purch. Cr. Memo Hdr.", Database::"Purch. Cr. Memo Line",
            Database::"Return Shipment Header", Database::"Return Shipment Line",
            Database::"Return Receipt Header", Database::"Return Receipt Line":
                LookupPostedLongtextLines(SourceRecordRef, Position);

            Database::"Sales Header Archive", Database::"Sales Line Archive",
            Database::"Purchase Header Archive", Database::"Purchase Line Archive":
                LookupArchiveLongtextLines(SourceRecordRef, Position);
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
        SourceDocumentType: Enum "Sales Document Type";
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
            Database::"Sales Header", Database::"Sales Line",
            Database::"Purchase Header", Database::"Purchase Line":
                SourceLongtextRecordRef.Open(Database::"lbt PS Longtext Line");

            Database::"Sales Shipment Header", Database::"Sales Shipment Line",
            Database::"Sales Invoice Header", Database::"Sales Invoice Line",
            Database::"Sales Cr.Memo Header", Database::"Sales Cr.Memo Line",
            Database::"Purch. Rcpt. Header", Database::"Purch. Rcpt. Line",
            Database::"Purch. Inv. Header", Database::"Purch. Inv. Line",
            Database::"Purch. Cr. Memo Hdr.", Database::"Purch. Cr. Memo Line",
            Database::"Return Shipment Header", Database::"Return Shipment Line",
            Database::"Return Receipt Header", Database::"Return Receipt Line":
                SourceLongtextRecordRef.Open(Database::"lbt Posted PS Longtext Line");

            Database::"Sales Header Archive", Database::"Sales Line Archive",
            Database::"Purchase Header Archive", Database::"Purchase Line Archive":
                SourceLongtextRecordRef.Open(Database::"lbt Archive PS Longtext Line");
        end;
        SourceFieldRef := SourceLongtextRecordRef.Field(1);
        SourceFieldRef.SetRange(SourceTableID);

        // Dokumentenart
        if SourceTableID in [Database::"Sales Header", Database::"Sales Line",
                             Database::"Purchase Header", Database::"Purchase Line",
                             Database::"Sales Header Archive", Database::"Sales Line Archive",
                             Database::"Purchase Header Archive", Database::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecordRef.Field(1);
            SourceDocumentType := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.Field(2);
            SourceFieldRef.SetRange(SourceDocumentType);
        end;

        // Dokumenten Nr.
        SourceFieldRef := SourceRecordRef.Field(3);
        SourceDocumentNo := SourceFieldRef.Value();
        SourceFieldRef := SourceLongtextRecordRef.Field(3);
        SourceFieldRef.SetRange(SourceDocumentNo);

        // Belegnr.-Häufigkeit + Versionsnr.
        if SourceTableID in [Database::"Sales Header Archive", Database::"Purchase Header Archive",
                             Database::"Sales Line Archive", Database::"Purchase Line Archive"]
        then begin
            SourceFieldRef := SourceRecordRef.Field(5048);
            SourceDocNoOcc := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.Field(8);
            SourceFieldRef.SetRange(SourceDocNoOcc);

            SourceFieldRef := SourceRecordRef.Field(5047);
            SourceVersionNo := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.Field(7);
            SourceFieldRef.SetRange(SourceVersionNo);
        end;

        // Zeilen Nr.
        if SourceTableID in [Database::"Sales Line", Database::"Purchase Line",
                             Database::"Sales Shipment Line", Database::"Purch. Rcpt. Line",
                             Database::"Sales Invoice Line", Database::"Purch. Inv. Line",
                             Database::"Sales Cr.Memo Line", Database::"Purch. Cr. Memo Line",
                             Database::"Return Shipment Line", Database::"Return Receipt Line",
                             Database::"Sales Line Archive", Database::"Purchase Line Archive",
                             Database::"Return Shipment Line", Database::"Return Receipt Line"]
        then begin
            SourceFieldRef := SourceRecordRef.Field(4);
            SourceLineNo := SourceFieldRef.Value();
            SourceFieldRef := SourceLongtextRecordRef.Field(5);
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
        SourceFieldRef: FieldRef;
        SourceDocumentType: Enum "Sales Document Type";
        TargetDocumentType: Enum "Sales Document Type";
        TargetDocumentNo: Code[20];
        TargetTableID: Integer;
        SourceTableID: Integer;
        TargetDocNoOcc: Integer;
        TargetVersionNo: Integer;
        TargetLineNo: Integer;
        handled: Boolean;
        SourceDocumentNo: Code[20];
        SourceDocNoOcc: Integer;
        SourceVersionNo: Integer;
        SourceLineNo: Integer;
    begin
        // Funktion derzeit nur fürs Kopieren von Belegen, nicht das verbuchen/Archivieren von Belegen
        // Könnte jedoch bei beid Bedarf und Gelegenheit zusammengeführt werden

        onbeforeCopyLongText(SourceRecordRef, TargetRecordRef, handled);
        if handled then
            exit;
        // 1. Herkunft
        FilterRecRef(SourceRecordRef, SourceLongtextRecordRef, SourceDocumentType, SourceDocumentNo, SourceTableID, SourceDocNoOcc, SourceVersionNo, SourceLineNo);

        // 2. Ziel
        FilterRecRef(TargetRecordRef, TargetLongtextRecordRef, TargetDocumentType, TargetDocumentNo, TargetTableID, TargetDocNoOcc, TargetVersionNo, TargetLineNo);

        // Sonderfall im Auftrag/Bestellung -- Kopf- & Fußtexte für Rechnung/Lieferung
        HandleSourceIsOrder(SourceLongtextRecordRef, SourceDocumentType, TargetDocumentType, TargetTableID, SourceTableID);

        // Kopieren
        CopyStuff(SourceLongtextRecordRef, TargetLongtextRecordRef, SourceFieldRef, SourceDocumentType, TargetDocumentType, TargetDocumentNo, TargetTableID, SourceTableID, TargetDocNoOcc, TargetVersionNo, TargetLineNo);
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
        SourceDocumentType: Enum "Sales Document Type";
        SourceDocumentNo: Code[20];
        SourceTableID: Integer;
        SourceLineNo: Integer;
    begin
        SourceTableID := SourceRecordRef.Number();
        if not (SourceTableID in [Database::"Sales Header", Database::"Sales Line",
                                  Database::"Purchase Header", Database::"Purchase Line"])
        then
            exit;

        SourceFieldRef := SourceRecordRef.Field(1);
        SourceDocumentType := SourceFieldRef.Value();
        SourceFieldRef := SourceRecordRef.Field(3);
        SourceDocumentNo := SourceFieldRef.Value();
        if SourceTableID in [Database::"Sales Line", Database::"Purchase Line"] then begin
            SourceFieldRef := SourceRecordRef.Field(4);
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

    procedure InsertLongTextExtText(var FromPSLongtextLine: Record "lbt PS Longtext Line"; NewDocumentType: Enum "Sales Document Type")
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
        if ToPSLongtextLine.Find('>') then begin
            LineSpacing :=
              (ToPSLongtextLine."Line No." - FromPSLongtextLine."Line No.") div
              (1 + TempExtendedTextLineLong.Count());
            if LineSpacing = 0 then
                Error(NotEnoughSpaceErr);
        end else
            LineSpacing := 10000;

        NextLineNo := FromPSLongtextLine."Line No." + LineSpacing;
        FirstLine := true;

        TempExtendedTextLineLong.Reset();
        if TempExtendedTextLineLong.Find('-') then
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
        exit(ReadLines(ExtendedTextHeader, DocumentDate, Language));
    end;

    local procedure ReadLines(var ExtendedTextHeader: Record "Extended Text Header"; DocDate: Date; LanguageCode: Code[10]): Boolean
    var
        ExtendedTextLine: Record "Extended Text Line";
        ExtendedTextLineLong: Record "lbt Extended Text Line Long";
    begin
        if not FindExtendedTextHeader(ExtendedTextHeader, LanguageCode, DocDate) then
            exit(false);

        if (ExtendedTextHeader."lbt Textchoice" = ExtendedTextHeader."lbt Textchoice"::standard) then begin
            ExtendedTextLine.SetRange("Table Name", ExtendedTextHeader."Table Name");
            ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
            ExtendedTextLine.SetRange("Language Code", ExtendedTextHeader."Language Code");
            ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
            exit(not ExtendedTextLine.IsEmpty());
        end;

        ExtendedTextLineLong.SetRange(Table_ID, ExtendedTextHeader."Table Name");
        ExtendedTextLineLong.SetRange("No.", ExtendedTextHeader."No.");
        ExtendedTextLineLong.SetRange("Language Code", ExtendedTextHeader."Language Code");
        ExtendedTextLineLong.SetRange("Text No.", ExtendedTextHeader."Text No.");
        exit(not ExtendedTextLineLong.IsEmpty());

    end;

    local procedure FilterRecRef(var RecRef: RecordRef; var LongtextRecordRef: RecordRef; var DocumentType: Enum "Sales Document Type"; var TargetDocumentNo: Code[20]; var TableID: Integer; var TargetDocNoOcc: Integer; var TargetVersionNo: Integer; var TargetLineNo: Integer)
    var
        FRef: FieldRef;
    begin
        TableID := RecRef.Number();
        // Tabellen und Filterung über RecordRef's
        case TableID of
            Database::"Sales Header", Database::"Sales Line",
        Database::"Purchase Header", Database::"Purchase Line":
                LongtextRecordRef.Open(Database::"lbt PS Longtext Line");
            Database::"Sales Shipment Header", Database::"Sales Shipment Line",
        Database::"Sales Invoice Header", Database::"Sales Invoice Line",
        Database::"Sales Cr.Memo Header", Database::"Sales Cr.Memo Line",
        Database::"Purch. Rcpt. Header", Database::"Purch. Rcpt. Line",
        Database::"Purch. Inv. Header", Database::"Purch. Inv. Line",
        Database::"Purch. Cr. Memo Hdr.", Database::"Purch. Cr. Memo Line",
        Database::"Return Shipment Header", Database::"Return Shipment Line",
        Database::"Return Receipt Header", Database::"Return Receipt Line":
                LongtextRecordRef.Open(Database::"lbt Posted PS Longtext Line");
            Database::"Sales Header Archive", Database::"Sales Line Archive",
        Database::"Purchase Header Archive", Database::"Purchase Line Archive":
                LongtextRecordRef.Open(Database::"lbt Archive PS Longtext Line");
        end;
        FRef := LongtextRecordRef.Field(1);
        FRef.SetRange(TableID);

        // Dokumententyp
        if TableID in [Database::"Sales Header", Database::"Sales Line",
                             Database::"Purchase Header", Database::"Purchase Line",
                             Database::"Sales Header Archive", Database::"Sales Line Archive",
                             Database::"Purchase Header Archive", Database::"Purchase Line Archive"]
        then begin
            FRef := RecRef.Field(1);
            DocumentType := FRef.Value();
            FRef := LongtextRecordRef.Field(2);
            FRef.SetRange(DocumentType);
        end;

        // Dokumenten Nr.
        FRef := RecRef.Field(3);
        TargetDocumentNo := FRef.Value();
        FRef := LongtextRecordRef.Field(3);
        FRef.SetRange(TargetDocumentNo);

        //  Belegnr.-Häufigkeit + Versionsnr.
        if TableID in [Database::"Sales Header Archive", Database::"Purchase Header Archive",
                             Database::"Sales Line Archive", Database::"Purchase Line Archive"]
        then begin
            FRef := RecRef.Field(5048);
            TargetDocNoOcc := FRef.Value();
            FRef := LongtextRecordRef.Field(8);
            FRef.SetRange(TargetDocNoOcc);

            FRef := RecRef.Field(5047);
            TargetVersionNo := FRef.Value();
            FRef := LongtextRecordRef.Field(7);
            FRef.SetRange(TargetVersionNo);
        end;

        // Zeilen Nr.
        if TableID in [Database::"Sales Line", Database::"Purchase Line",
                             Database::"Sales Shipment Line", Database::"Purch. Rcpt. Line",
                             Database::"Sales Invoice Line", Database::"Purch. Inv. Line",
                             Database::"Sales Cr.Memo Line", Database::"Purch. Cr. Memo Line",
                             Database::"Return Shipment Line", Database::"Return Receipt Line",
                             Database::"Sales Line Archive", Database::"Purchase Line Archive",
                             Database::"Return Shipment Line", Database::"Return Receipt Line"]
        then begin
            FRef := RecRef.Field(4);
            TargetLineNo := FRef.Value();
            FRef := LongtextRecordRef.Field(5);
            FRef.SetRange(TargetLineNo);
        end;
    end;

    local procedure HandleSourceIsOrder(var SourceLongtextRecordRef: RecordRef; SourceDocumentType: Enum "Sales Document Type"; TargetDocumentType: Enum "Sales Document Type"; TargetTableID: Integer; SourceTableID: Integer)
    var
        SourceFieldRef: FieldRef;
    begin
        SourceFieldRef := SourceLongtextRecordRef.Field(2);

        if not IsOrder(SourceDocumentType, SourceTableID) then
            exit;

        // wenn Ziel = Rechnung, dann prüfen, ob separate Texte
        if IsInvoice(TargetDocumentType, TargetTableID) then begin
            SourceFieldRef.SetRange(SourceDocumentType::Invoice);
            if SourceLongtextRecordRef.IsEmpty() then
                SourceFieldRef.SetRange(SourceDocumentType::Order);
        end;

        // wenn Ziel = Lieferschein, dann prüfen, ob separate Texte
        if (TargetTableID in [Database::"Sales Shipment Header", Database::"Purch. Rcpt. Header"])
        then begin
            SourceFieldRef.SetRange(SourceDocumentType::"lbt cl Shipment/Receipt");
            if SourceLongtextRecordRef.IsEmpty() then
                SourceFieldRef.SetRange(SourceDocumentType::Order);
        end;

        // wenn Ziel = Auftrag, dann alles
        if IsOrder(TargetDocumentType, TargetTableID) then
            SourceFieldRef.SetRange();
    end;

    local procedure CopyStuff(var SourceLongtextRecordRef: RecordRef; var TargetLongtextRecordRef: RecordRef; var SourceFieldRef: FieldRef; var SourceDocumentType: Enum "Sales Document Type"; var TargetDocumentType: Enum "Sales Document Type"; TargetDocumentNo: Code[20]; TargetTableID: Integer; SourceTableID: Integer; TargetDocNoOcc: Integer; TargetVersionNo: Integer; TargetLineNo: Integer)
    var
        TempBlob: Codeunit "Temp Blob";
        TargetFieldRef: FieldRef;
        LineNo: Integer;
    begin
        if SourceLongtextRecordRef.FindSet() then begin
            // letzte Zielzeilennr. finden (falls beim Beleg kopieren noch da)
            LineNo := FindLastLineNo(TargetLongtextRecordRef);
            repeat
                LineNo += 10000;
                TargetLongtextRecordRef.Init();
                TargetFieldRef := TargetLongtextRecordRef.Field(1);  // Table ID
                TargetFieldRef.Value := TargetTableID;
                AssignTargetDocumentType(SourceLongtextRecordRef, TargetLongtextRecordRef, SourceDocumentType, TargetDocumentType, TargetTableID, SourceTableID);

                TargetFieldRef := TargetLongtextRecordRef.Field(3);  // Document No.
                TargetFieldRef.Value := TargetDocumentNo;
                SourceFieldRef := SourceLongtextRecordRef.Field(4);  // Position
                TargetFieldRef := TargetLongtextRecordRef.Field(4);  // Position
                TargetFieldRef.Value := SourceFieldRef.Value();
                TargetFieldRef := TargetLongtextRecordRef.Field(5);  // Document Line No.
                TargetFieldRef.Value := TargetLineNo;
                TargetFieldRef := TargetLongtextRecordRef.Field(6);  // Line No.
                TargetFieldRef.Value := LineNo;

                if TargetTableID in [Database::"Sales Header Archive", Database::"Sales Line Archive",
                                     Database::"Purchase Header Archive", Database::"Purchase Line Archive"]
                then begin
                    TargetFieldRef := TargetLongtextRecordRef.Field(7);  // Version No.
                    TargetFieldRef.Value := TargetVersionNo;
                    TargetFieldRef := TargetLongtextRecordRef.Field(8);  // Doc. No. Occurrence
                    TargetFieldRef.Value := TargetDocNoOcc;
                end;
                SourceFieldRef := SourceLongtextRecordRef.Field(10); // Type
                TargetFieldRef := TargetLongtextRecordRef.Field(10); // Type
                TargetFieldRef.Value := SourceFieldRef.Value();
                SourceFieldRef := SourceLongtextRecordRef.Field(11); // No.
                TargetFieldRef := TargetLongtextRecordRef.Field(11); // No.
                TargetFieldRef.Value := SourceFieldRef.Value();
                SourceFieldRef := SourceLongtextRecordRef.Field(12); // Description
                TargetFieldRef := TargetLongtextRecordRef.Field(12); // Description
                TargetFieldRef.Value := SourceFieldRef.Value();

                SourceFieldRef := SourceLongtextRecordRef.Field(21); // Editor
                TargetFieldRef := TargetLongtextRecordRef.Field(21); //Editor
                Clear(TempBlob);
                TempBlob.FromFieldRef(SourceFieldRef);
                TempBlob.ToFieldRef(TargetFieldRef);

                if not TargetLongtextRecordRef.Insert() then
                    TargetLongtextRecordRef.Modify();
            until SourceLongtextRecordRef.Next() = 0;
        end;
    end;

    local procedure FindLastLineNo(var LongtextRecordRef: RecordRef) LineNo: Integer
    var
        FRef: FieldRef;
    begin
        if LongtextRecordRef.FindLast() then begin
            FRef := LongtextRecordRef.Field(6);
            LineNo := FRef.Value();
        end else
            LineNo := 0;
    end;

    local procedure AssignTargetDocumentType(var SourceLongtextRecordRef: RecordRef; var TargetLongtextRecordRef: RecordRef; var SourceDocumentType: Enum "Sales Document Type"; var TargetDocumentType: Enum "Sales Document Type"; TargetTableID: Integer; SourceTableID: Integer)
    var
        SourceFieldRef: FieldRef;
        TargetFieldRef: FieldRef;
    begin
        // wenn Quelle und Ziel = Auftrag, dann originale Arten
        if (IsSalesOrPurchase(SourceTableID) and (SourceDocumentType = SourceDocumentType::Order)) and
           (IsSalesOrPurchase(TargetTableID) and (TargetDocumentType = TargetDocumentType::Order))
        then begin
            SourceFieldRef := SourceLongtextRecordRef.Field(2);  // Document Type
            TargetFieldRef := TargetLongtextRecordRef.Field(2);  // Document Type
            TargetFieldRef.Value := SourceFieldRef.Value();
            exit;
        end;
        if (TargetTableID in [Database::"Sales Header", Database::"Sales Line",
                              Database::"Purchase Header", Database::"Purchase Line",
                              Database::"Sales Header Archive", Database::"Sales Line Archive",
                              Database::"Purchase Header Archive", Database::"Purchase Line Archive"])
        then begin
            TargetFieldRef := TargetLongtextRecordRef.Field(2);  // Document Type
            TargetFieldRef.Value := TargetDocumentType;
        end;
    end;

    local procedure IsSalesOrPurchase(TableID: Integer): Boolean
    begin
        exit((TableID in [Database::"Sales Header", Database::"Sales Line",
                            Database::"Purchase Header", Database::"Purchase Line",
                            Database::"Sales Header Archive", Database::"Sales Line Archive",
                            Database::"Purchase Header Archive", Database::"Purchase Line Archive"]));
    end;

    local procedure IsOrder(DocumentType: Enum "Sales Document Type"; TableID: Integer): Boolean
    begin
        exit((TableID in [Database::"Sales Header", Database::"Purchase Header"]) and
           (DocumentType = DocumentType::Order)) //Auftrag/Bestellung;
    end;

    local procedure IsInvoice(DocumentType: Enum "Sales Document Type"; TableID: Integer): Boolean
    begin
        exit(
            (TableID in [Database::"Sales Invoice Header", Database::"Purch. Inv. Header"]) or
            ((TableID in [Database::"Sales Header", Database::"Purchase Header"]) and (DocumentType = DocumentType::Invoice))
         );
    end;

    local procedure FindExtendedTextHeader(var ExtendedTextHeader: Record "Extended Text Header"; LanguageCode: Code[10]; DocDate: Date): Boolean
    begin
        ExtendedTextHeader.SetCurrentKey("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
        ExtendedTextHeader.SetRange("Starting Date", 0D, DocDate);
        ExtendedTextHeader.SetFilter("Ending Date", '%1..|%2', DocDate, 0D);

        if LanguageCode = '' then begin
            ExtendedTextHeader.SetRange("Language Code", '');
            if not ExtendedTextHeader.FindSet() then
                exit(false);
        end else begin
            ExtendedTextHeader.SetRange("Language Code", LanguageCode);
            if not ExtendedTextHeader.FindSet() then begin
                ExtendedTextHeader.SetRange("All Language Codes", true);
                ExtendedTextHeader.SetRange("Language Code", '');
                if not ExtendedTextHeader.FindSet() then
                    exit(false);
            end;
        end;
        exit(true);
    end;

    local procedure GetValue(var RecRef: RecordRef; FieldNo: Integer): Variant
    var
        FRef: FieldRef;
    begin
        FRef := RecRef.Field(FieldNo);
        exit(FRef.Value());
    end;

    [BusinessEvent(true)]
    local procedure onbeforeCopyLongText(Sourcerecref: RecordRef; TargetRecRef: RecordRef; var handled: Boolean)
    begin
    end;
}

