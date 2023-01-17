codeunit 5272731 "lbt cl Print Longtext"
{
    procedure GetEditorPosition(Position: Enum "lbt Position"): Enum "lbt Position"
    begin
        case Position of
            Position::Footer:
                exit(Position::EditorFooter);
            Position::Header:
                exit(Position::EditorHeader);
            Position::Longtext:
                exit(Position::EditorLine);
        end;
    end;

    procedure GetPrintText(vari: Variant; Position: Enum "lbt Position"; var TempBlobList: Codeunit "Temp Blob List"; OtherDocType: Integer)
    var
        LongLineRecRef: RecordRef;
    begin
        OpenRecRefAndSetFilters(vari, LongLineRecRef, OtherDocType);
        GetPrintText(TempBlobList, LongLineRecRef, Position);
    end;

    procedure GetPrintText(vari: Variant; Position: Enum "lbt Position"; var TempBlobList: Codeunit "Temp Blob List")
    begin
        GetPrintText(vari, Position, TempBlobList, -1);
    end;

    local procedure AddEditorText(var TempBlobList: Codeunit "Temp Blob List"; var LongLineRecRef: RecordRef)
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
        EditorHelper: Codeunit "lbt cl EditorHelper";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        buffer: Text;
        Txt: Text;
    begin
        TempBlob.FromRecordRef(LongLineRecRef, PSLongtextLine.FieldNo("Editor Content"));
        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        while not InStr.EOS do begin
            InStr.Read(buffer);
            Txt += buffer;
        end;
        Txt := EditorHelper.PrepareHtmltoprint(Txt);
        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        OutStr.Write(Txt);
        TempBlobList.Add(TempBlob);
    end;

    local procedure CombineText(RecRef: RecordRef; var CombinedText: Text)
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
    begin
        CombinedText += Format(RecRef.Field(PSLongtextLine.FieldNo(Description)).Value);
        if Format(RecRef.Field(PSLongtextLine.FieldNo(Type)).Value) = Format(PSLongtextLine.Type::"Text + Line break") then
            CombinedText += '<br>';
    end;

    local procedure GetPrintText(var TempBlobList: Codeunit "Temp Blob List"; LongLineRecRef: RecordRef; Position: Enum "lbt Position")
    var
        CombinedText: Text;
    begin
        Clear(TempBlobList);
        SetPositionFilter(LongLineRecRef, GetEditorPosition(Position));
        if LongLineRecRef.FindFirst() then begin
            AddEditorText(TempBlobList, LongLineRecRef);
            exit;
        end;

        SetPositionFilter(LongLineRecRef, Position);
        if LongLineRecRef.FindSet() then
            repeat
                if IsNewPage(LongLineRecRef) then
                    WriteToNewTempblob(TempBlobList, CombinedText)
                else
                    CombineText(LongLineRecRef, CombinedText);
            until LongLineRecRef.Next() = 0;
        WriteToNewTempblob(TempBlobList, CombinedText)
    end;

    local procedure GetTableIdAndFieldNos(RecRef: RecordRef; var TableId: Integer; var FieldNo_DocType: Integer; var FieldNo_DocNo: Integer; var FieldNo_LineNo: Integer; var FieldNo_Version: Integer; var FieldNo_DocNoOccurence: Integer)
    var
        SalesLineArchive: Record "Sales Line Archive";
    begin
        TableId := RecRef.Number;
        FieldNo_DocType := SalesLineArchive.FieldNo("Document Type");
        FieldNo_DocNo := SalesLineArchive.FieldNo("Document No.");
        FieldNo_LineNo := SalesLineArchive.FieldNo("Line No.");
        FieldNo_Version := SalesLineArchive.FieldNo("Version No.");
        FieldNo_DocNoOccurence := SalesLineArchive.FieldNo("Doc. No. Occurrence");

        OnAfterGetTableIdsAndFieldNos(RecRef, TableId, FieldNo_DocType, FieldNo_DocNo, FieldNo_LineNo, FieldNo_Version, FieldNo_DocNoOccurence);
    end;

    local procedure gettype(TableId: Integer) Type: Integer
    var
        UnsupportedTableErr: Label 'Unsupported Table %1 for Longtext', Comment = '%1 - TableId';
    begin
        case TableId of
            ///Unposted
            Database::"Sales Header",
            Database::"Sales Line",
            Database::"Purchase Header",
            Database::"Purchase Line",
            Database::"Service Header",
            Database::"Service Item Line",
            Database::"Service Line",
            Database::"Service Contract Line":
                Type := 1;
            ///Posted
            Database::"Sales Shipment Header",
            Database::"Sales Shipment Line",
            Database::"Sales Invoice Header",
            Database::"Sales Invoice Line",
            Database::"Sales Cr.Memo Header",
            Database::"Sales Cr.Memo Line",
            Database::"Purch. Rcpt. Header",
            Database::"Purch. Rcpt. Line",
            Database::"Purch. Inv. Header",
            Database::"Purch. Inv. Line",
            Database::"Purch. Cr. Memo Hdr.",
            Database::"Purch. Cr. Memo Line",
            Database::"Service Shipment Item Line",
            Database::"Service Shipment Header",
            Database::"Service Shipment Line",
            Database::"Service Invoice Header",
            Database::"Service Invoice Line",
            Database::"Service Cr.Memo Header",
            Database::"Service Cr.Memo Line":
                Type := 2;
            ///archived
            Database::"Sales Header Archive",
            Database::"Sales Line Archive",
            Database::"Purchase Header Archive",
            Database::"Purchase Line Archive":
                //TODO: "Service Item Line Archive" IR
                Type := 3;
            else
                OnGetType_CaseElse(TableId, Type);
        end;
        if Type = 0 then
            Error(UnsupportedTableErr, TableId);
    end;

    local procedure IsLine(TableId: Integer) Result: Boolean
    begin
        Result := TableId in [
            Database::"Sales Line",
            Database::"Purchase Line",
            Database::"Sales Shipment Line",
            Database::"Sales Invoice Line",
            Database::"Sales Cr.Memo Line",
            Database::"Purch. Rcpt. Line",
            Database::"Purch. Inv. Line",
            Database::"Purch. Cr. Memo Line",
            Database::"Sales Line Archive",
            Database::"Purchase Line Archive"
            ];

        OnAfterIsLine(TableId, Result);
    end;

    local procedure IsNewPage(var RecRef: RecordRef): Boolean
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
    begin
        exit(Format(RecRef.Field(PSLongtextLine.FieldNo(Type)).Value) = Format(PSLongtextLine.Type::"New Page"));
    end;

    local procedure OpenRecRefAndSetFilters(vari: Variant; var LongLineRecRef: RecordRef; OtherDocType: Integer)
    var
        DummyLongtext: Record "lbt Archive PS Longtext Line";
        RecRef: RecordRef;
        FieldNo_DocNo: Integer;
        FieldNo_DocNoOccurence: Integer;
        FieldNo_DocType: Integer;
        FieldNo_LineNo: Integer;
        FieldNo_Version: Integer;
        TableId: Integer;
        Type: Integer;
    begin
        RecRef.GetTable(vari);
        GetTableIdAndFieldNos(RecRef, TableId, FieldNo_DocType, FieldNo_DocNo, FieldNo_LineNo, FieldNo_Version, FieldNo_DocNoOccurence);

        Type := gettype(TableId);
        case Type of
            1:
                begin
                    LongLineRecRef.Open(Database::"lbt PS Longtext Line");
                    SetDocTypeFilter(LongLineRecRef, RecRef, FieldNo_DocType, OtherDocType);
                end;
            2:
                LongLineRecRef.Open(Database::"lbt Posted PS Longtext Line");
            3:
                begin
                    LongLineRecRef.Open(Database::"lbt Archive PS Longtext Line");
                    SetDocTypeFilter(LongLineRecRef, RecRef, FieldNo_DocType, OtherDocType);
                    LongLineRecRef.Field(DummyLongtext.FieldNo("Doc. No. Occurrence")).SetRange(RecRef.Field(FieldNo_DocNoOccurence).Value);
                    LongLineRecRef.Field(DummyLongtext.FieldNo("Version No.")).SetRange(RecRef.Field(FieldNo_Version).Value);
                end;
        end;
        LongLineRecRef.Field(DummyLongtext.FieldNo("Table ID")).SetRange(TableId);
        LongLineRecRef.Field(DummyLongtext.FieldNo("Document No.")).SetRange(RecRef.Field(FieldNo_DocNo).Value);
        if IsLine(TableId) then
            LongLineRecRef.Field(DummyLongtext.FieldNo("Document Line No.")).SetRange(RecRef.Field(FieldNo_LineNo).Value);
    end;

    local procedure SetDocTypeFilter(var LongLineRecRef: RecordRef; RecRef: RecordRef; FieldNo_DocType: Integer; OtherDocType: Integer)
    var
        DummyLongtext: Record "lbt Archive PS Longtext Line";
    begin
        if OtherDocType <> -1 then
            LongLineRecRef.Field(DummyLongtext.FieldNo("Document Type")).SetRange(OtherDocType)
        else
            LongLineRecRef.Field(DummyLongtext.FieldNo("Document Type")).SetRange(RecRef.Field(FieldNo_DocType).Value);
    end;

    local procedure SetPositionFilter(var LongLineRecRef: RecordRef; Position: Enum "lbt Position")
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
    begin
        LongLineRecRef.Field(PSLongtextLine.FieldNo(Position)).SetRange(Position);
    end;

    local procedure WriteToNewTempblob(var TempBlobList: Codeunit "Temp Blob List"; var CombinedText: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        outs: OutStream;
    begin
        if CombinedText = '' then
            exit;
        TempBlob.CreateOutStream(outs, TextEncoding::UTF8);
        outs.Write(CombinedText);
        CombinedText := '';
        TempBlobList.Add(TempBlob);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetTableIdsAndFieldNos(RecRef: RecordRef; var TableId: Integer; var FieldNo_DocType: Integer; var FieldNo_DocNo: Integer; var FieldNo_LineNo: Integer; var FieldNo_Version: Integer; var FieldNo_DocNoOccurence: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterIsLine(TableId: Integer; var result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGetType_CaseElse(TableId: Integer; var Type: Integer)
    begin
    end;
}
