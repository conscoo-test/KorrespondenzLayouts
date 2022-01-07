codeunit 5272729 "lbt cl EditorHelper"
{
    procedure TextEditor(var data: Text; HTML: Boolean) Result: Boolean
    var
        Editor: Page "lbt cl Editor";
    begin
        Editor.SetText(data, html);
        Editor.LookupMode(true);
        Editor.RunModal();
        if Editor.IfLookupOk() then begin
            data := Editor.GetText();
            Result := true;
        end;
    end;

    procedure deleteLongText(vari: variant; otherDocType: integer)
    var
        recref: recordref;
    begin
        recref.GetTable(vari);
        DeleteLongText(recref, otherDocType);
    end;

    procedure deleteLongText(recRef: recordref; otherDocType: integer)
    var
        PSLongtextLn: Record "lbt PS Longtext Line";
        PstdPSLongtextLn: Record "lbt Posted PS Longtext Line";
        ArchivePSLongtextLn: Record "lbt Archive PS Longtext Line";
        tableid: integer;
        Tabletype: integer;

    begin
        tableid := recref.Number;
        Tabletype := gettype(tableid);

        case tabletype of
            1:
                begin
                    SetPsLongtextLineFilter(PSLongtextLn, PSLongtextLn.Position::EditorFooter, otherDocType, recref, false);
                    PSLongtextLn.SetRange(Position);
                    PSLongtextLn.DeleteAll(true);
                end;
            2:
                begin
                    SetPstdPsLongtextLineFilter(PstdPSLongtextLn, PstdPSLongtextLn.Position::EditorFooter, recref, false);
                    PstdPSLongtextLn.SetRange(Position);
                    PstdPSLongtextLn.DeleteAll(true);

                end;
            3:
                begin
                    SetArchPsLongtextLineFilter(ArchivePSLongtextLn, PstdPSLongtextLn.Position::EditorFooter, recref, false);
                    PstdPSLongtextLn.setrange(Position);
                    PstdPSLongtextLn.DeleteAll(true);
                    //result := ArchivePSLongtextLn.ReadContentData(false);
                end;
        end;

    end;

    procedure getPrintData(vari: Variant; Position: Enum "lbt Position"; otherDocType: integer) Result: text
    var
        recref: RecordRef;
    begin
        recref.GetTable(vari);
        result := GetPrintData(recref, Position, otherDocType);
    end;

    procedure getPrintData(recRef: recordref; Position: Enum "lbt Position"; otherDocType: integer) Result: text
    var
        PSLongtextLn: Record "lbt PS Longtext Line";
        PstdPSLongtextLn: Record "lbt Posted PS Longtext Line";
        ArchivePSLongtextLn: Record "lbt Archive PS Longtext Line";
        tableid: integer;
        Tabletype: integer;

    begin
        tableid := recref.Number;
        Tabletype := gettype(tableid);

        case tabletype of
            1:
                begin
                    SetPsLongtextLineFilter(PSLongtextLn, position, otherDocType, recref, false);
                    if PSLongtextLn.findfirst() then
                        result := PSLongtextLn.ReadContentData(false);
                end;
            2:
                begin
                    SetPstdPsLongtextLineFilter(PstdPSLongtextLn, position, recref, false);
                    if PstdPSLongtextLn.findfirst() then
                        result := PstdPSLongtextLn.ReadContentData(false);
                end;
            3:
                begin
                    SetArchPsLongtextLineFilter(ArchivePSLongtextLn, position, recref, false);
                    if ArchivePSLongtextLn.findfirst() then
                        result := ArchivePSLongtextLn.ReadContentData(false);
                end;


        end;
        result := PrepareHtmltoprint(result);

    end;

    procedure hasEditorValue(vari: variant; Position: Enum "lbt Position"; otherDocType: integer) Result: Boolean
    var
        recRef: RecordRef;
    begin
        recref.GetTable(vari);
        result := hasEditorValue(recref, Position, otherDocType);
    end;

    procedure hasEditorValue(RecRef: recordref; Position: Enum "lbt Position"; otherDocType: integer) Result: Boolean
    var
        PSLongtextLn: Record "lbt PS Longtext Line";
        PstdPSLongtextLn: Record "lbt Posted PS Longtext Line";
        ArchivePSLongtextLn: Record "lbt Archive PS Longtext Line";
        tableid: integer;
        Tabletype: integer;

    begin
        tableid := recref.Number;
        Tabletype := gettype(tableid);

        case tabletype of
            1:
                begin
                    SetPsLongtextLineFilter(PSLongtextLn, position, otherDoctype, recref, false);
                    exit(not PSLongtextLn.IsEmpty());
                end;
            2:
                begin
                    SetPstdPsLongtextLineFilter(PstdPSLongtextLn, position, recref, false);
                    exit(not PstdPSLongtextLn.IsEmpty());

                end;
            3:
                begin
                    SetArchPsLongtextLineFilter(ArchivePSLongtextLn, position, recref, false);
                    exit(not PstdPSLongtextLn.IsEmpty());

                end;


        end;
    end;

    procedure editData(vari: variant; Position: Enum "lbt Position"; otherDocType: integer)
    var
        RecRef: RecordRef;
    begin
        recref.GetTable(vari);
        editData(recref, position, otherDocType);

    end;

    procedure editData(recRef: recordref; Position: Enum "lbt Position"; otherDocType: integer)
    var
        PSLongtextLn: Record "lbt PS Longtext Line";
        PstdPSLongtextLn: Record "lbt Posted PS Longtext Line";
        ArchivePSLongtextLn: Record "lbt Archive PS Longtext Line";

        Tabletype: integer;

    begin

        Tabletype := gettype(recref.number);
        case Tabletype of
            1:
                begin
                    SetPsLongtextLineFilter(PSLongtextLn, position, otherDocType, recref, true);
                    PSLongtextLn.EditData();
                    if not PSLongtextLn."Editor Content".HasValue() then
                        if PSLongtextLn.delete(true) then;
                end;
            2:
                begin
                    SetPstdPsLongtextLineFilter(pstdPSLongtextLn, position, recref, true);
                    pstdPSLongtextLn.EditData();
                    if not pstdPSLongtextLn."Editor Content".HasValue() then
                        if pstdPSLongtextLn.delete(true) then;
                end;
            3:
                begin
                    SetArchPsLongtextLineFilter(ArchivePSLongtextLn, position, recref, true);
                    ArchivePSLongtextLn.EditData();
                    if not ArchivePSLongtextLn."Editor Content".HasValue() then
                        if ArchivePSLongtextLn.delete(true) then;
                end;
        end;
    end;

    internal procedure PrepareHtmltoprint(content: Text) Result: Text
    var
        TypeHelper: Codeunit "Type Helper";
        chr: Char;
        text: text;
        textList: list of [text];
        textLine: text;
        tb: TextBuilder;
        tab: integer;
        i: integer;
    begin
        tab := 5;
        text := content;
        ///del kopftext


        for i := 1 to 10 do
            text := text.replace(strsubstno('<p class="ql-indent-%1">', i), strsubstno('<p>%1', getSpace(i * tab)));
        chr := 9;
        text := text.replace(chr, getspace(1 * tab));
        textlist := text.Split(TypeHelper.LFSeparator());
        textlist := text.Split('</p>');
        foreach textline in textlist do
            if not textline.Contains('######') then
                tb.AppendLine(textLine + '</p>');

        // for i := 1 to 10 do
        //     text := text.replace(strsubstno('<li class="ql-indent-%1">', i), strsubstno('<li>%1', getSpace(i * tab)));
        result := tb.ToText();
        //result := text;

    end;

    internal procedure editorVisible(TableId: integer): Boolean
    begin
        exit(true);
    end;


    local procedure getSpace(no: integer) Result: text
    var
        i: Integer;
    begin
        for i := 1 to no do
            result += '&nbsp;';
    end;


    local procedure gettype(tableid: Integer) Result: Integer
    begin
        ///Unposted
        if tableid in [36, 37, 38, 39, 5900, 5901, 5902, 5964, 5965, 5968] then
            exit(1);
        ///Posted
        if tableid in [110, 111, 112, 113, 114, 115, 120, 121, 122, 123, 124, 125, 5989, 5990, 5991, 5992, 5993, 5994, 5995] then
            exit(2);
        ///archived
        if tableid in [5107, 5108, 5109, 5110, 5102781] then
            exit(3);
    end;

    local procedure SetPsLongtextLineFilter(var PSLongtextLn: Record "lbt PS Longtext Line"; Position: Enum "lbt Position"; otherDocType: integer; recref: RecordRef; insertIfEmpty: Boolean)
    var
        fields_No: array[10] of integer;
        docno_fieldno: integer;
        doctype_fieldno: integer;
        lineNo_fieldNo: integer;
    begin
        doctype_fieldNo := 1;
        docno_fieldno := 3;
        if recref.number in [37, 39, 111, 113, 115, 121, 123, 125, 5108, 5110] then
            lineNo_fieldNo := 4;
        if isserviceTable(recref.number, fields_No) <> 0 then begin
            doctype_fieldNo := fields_No[1];
            docno_fieldno := fields_No[2];
            lineNo_fieldNo := fields_No[3];
        end;


        PSLongtextLn.SetRange("Table ID", recref.Number);
        if (otherDocType = 0) and (doctype_fieldno <> 0) then
            PSLongtextLn.SetRange("document type", recref.field(doctype_fieldno).value)
        else
            PSLongtextLn.SetRange("document type", otherdoctype);

        PSLongtextLn.setrange("Document No.", recref.field(docno_fieldno).value);
        PSLongtextLn.setrange(Position, Position);
        if lineNo_fieldNo <> 0 then
            PSLongtextLn.SetRange("Document Line No.", recref.field(lineNo_fieldNo).value);
        if not insertifempty then
            exit;
        if PSLongtextLn.findfirst() then
            exit;
        PSLongtextLn.init();
        PSLongtextLn."Table ID" := recref.number;
        if doctype_fieldno <> 0 then
            PSLongtextLn."document type" := otherdoctype;//recref.field(doctype_fieldno).Value;
        PSLongtextLn."Document No." := recref.field(docno_fieldno).value;
        if lineNo_fieldNo <> 0 then
            PSLongtextLn."document Line No." := recref.field(lineNo_fieldNo).value;
        PSLongtextLn.Position := position;
        PSLongtextLn.insert(true);
        commit();
    end;

    local procedure SetPstdPsLongtextLineFilter(var PstdPSLongtextLn: Record "lbt Posted PS Longtext Line"; Position: Enum "lbt Position"; recref: RecordRef; insertIfEmpty: Boolean)
    var
        fields_no: array[10] of integer;
        docNo_fieldno: integer;
        lineNo_fieldNo: integer;
    begin
        docno_fieldno := 3;
        if recref.number in [37, 39, 111, 113, 115, 121, 123, 125, 5108, 5110] then
            lineNo_fieldNo := 4;

        if isserviceTable(recref.number, fields_No) <> 0 then begin
            docno_fieldno := fields_No[2];
            lineNo_fieldNo := fields_No[3];
        end;

        PstdPSLongtextLn.SetRange("Table ID", recref.number);
        //PstdPSLongtextLn.SetRange("document type", rec."Document Type");
        PstdPSLongtextLn.setrange("Document No.", recref.field(docNo_fieldno).value);
        PstdPSLongtextLn.setrange(Position, position);
        if lineNo_fieldNo <> 0 then
            PstdPSLongtextLn.SetRange("Document Line No.", recref.field(lineNo_fieldNo).value);

        if not insertifempty then
            exit;
        if PstdPSLongtextLn.findfirst() then
            exit;
        PstdPSLongtextLn.init();
        PstdPSLongtextLn."Table ID" := recref.number;
        //PstdPSLongtextLn."document type" := recref.field(1).Value;
        PstdPSLongtextLn."Document No." := recref.field(docNo_fieldno).value;
        PstdPSLongtextLn."document Line No." := recref.field(lineNo_fieldNo).value;
        PstdPSLongtextLn.Position := position;
        PstdPSLongtextLn.insert(true);
        commit();
    end;

    local procedure SetArchPsLongtextLineFilter(var ArchivePSLongtextLn: Record "lbt Archive PS Longtext Line"; Position: Enum "lbt Position"; recref: RecordRef; insertIfEmpty: Boolean)
    var
        fields_no: array[10] of integer;
        doctype_fieldno: integer;
        docNo_fieldno: integer;
        lineNo_fieldNo: integer;
        docOccur_FieldNo: integer;
        version_FieldNo: integer;
    begin
        doctype_fieldNo := 1;
        docno_fieldno := 3;
        if recref.number in [37, 39, 111, 113, 115, 121, 123, 125, 5108, 5110] then
            lineNo_fieldNo := 4;
        if recref.number in [5107, 5108, 5109, 5110] then begin
            docOccur_FieldNo := 5048;
            version_FieldNo := 5047;
        end;

        if isserviceTable(recref.number, fields_No) <> 0 then begin
            doctype_fieldno := fields_No[1];
            docno_fieldno := fields_No[2];
            lineNo_fieldNo := fields_No[3];
            docOccur_FieldNo := fields_no[4];
            version_FieldNo := fields_no[5];
        end;

        ///TODO Archive Filter
        ArchivePSLongtextLn.SetRange("Table ID", recref.number);
        if doctype_fieldno <> 0 then
            ArchivePSLongtextLn.SetRange("document type", recref.field(docType_fieldno).value);
        ArchivePSLongtextLn.setrange("Document No.", recref.field(docNo_fieldno).value);
        ArchivePSLongtextLn.setrange(Position, position);
        if lineNo_fieldNo <> 0 then
            ArchivePSLongtextLn.SetRange("Document Line No.", recref.field(LineNo_fieldno).value);
        if docOccur_FieldNo <> 0 then
            ArchivePSLongtextLn.SetRange("Doc. No. Occurrence", recref.field(docOccur_FieldNo).value);
        if version_FieldNo <> 0 then
            ArchivePSLongtextLn.SetRange("Version no.", recref.field(version_FieldNo).value);
        if not insertifempty then
            exit;
        if ArchivePSLongtextLn.findfirst() then
            exit;
        ArchivePSLongtextLn.init();
        ArchivePSLongtextLn."Table ID" := recref.number;
        if doctype_fieldno <> 0 then
            ArchivePSLongtextLn."document type" := recref.field(docNo_fieldno).value;
        ArchivePSLongtextLn."Document No." := recref.field(docNo_fieldno).value;
        ArchivePSLongtextLn."document Line No." := recref.field(lineNo_fieldNo).value;
        ArchivePSLongtextLn.Position := position;
        ArchivePSLongtextLn.insert(true);
        commit();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"lbt Longtext Mgt.", 'onbeforeCopyLongText', '', true, true)]
    local procedure lbtLongtextMgt_onbeforeCopyLongText(Sourcerecref: RecordRef; targetRecRef: RecordRef; var handled: Boolean)
    var
        TempBlob: Codeunit "Temp Blob";
        TargetMemo: RecordRef;
        SourceMemo: recordref;
        SourceMemoField: fieldref;
        TargetMemoField: fieldref;
        SourceRecField: fieldref;

        targettype: integer;
        sourcetype: integer;
        source_Fields: array[10] of integer;
        target_fields: array[10] of integer;

    begin
        sourcetype := isserviceTable(Sourcerecref.Number, source_Fields);
        targettype := isserviceTable(targetrecref.Number, target_fields);
        if (targettype = 0) and (sourcetype = 0) then
            exit;
        if sourcetype in [1, 2] then
            SourceMemo.open(database::"lbt PS Longtext Line");
        if sourcetype in [3, 4] then
            SourceMemo.open(database::"lbt Posted PS Longtext Line");
        if targettype in [1, 2] then
            targetMemo.open(database::"lbt PS Longtext Line");
        if targettype in [3, 4] then
            targetMemo.open(database::"lbt Posted PS Longtext Line");

        ///TableId
        SourceMemoField := Sourcememo.field(1);
        SourceMemoField.SetRange(Sourcerecref.Number);
        ///doctype
        if source_Fields[1] <> 0 then begin
            SourceRecField := Sourcerecref.field(source_Fields[1]);
            SourceMemoField := SourceMemo.field(2);
            SourceMemoField.SetRange(SourceRecField.value);
        end;
        ///DocNo
        if source_Fields[2] <> 0 then begin
            SourceRecField := Sourcerecref.field(source_Fields[2]);
            SourceMemoField := SourceMemo.field(3);
            SourceMemoField.SetRange(SourceRecField.value);
        end;
        /// 
        ///lineno
        if source_Fields[3] <> 0 then begin
            SourceRecField := Sourcerecref.field(source_Fields[3]);
            SourceMemoField := SourceMemo.field(5);
            SourceMemoField.SetRange(SourceRecField.value);
        end;
        ///

        if SourceMemo.findset() then
            repeat
                TargetMemo.init();
                TargetMemo.field(1).value := targetRecRef.number;
                if target_fields[1] <> 0 then
                    TargetMemo.field(2).value := targetRecRef.field(target_fields[1]).value;
                if target_fields[2] <> 0 then
                    TargetMemo.field(3).value := targetRecRef.field(target_fields[2]).value;
                if target_fields[3] <> 0 then
                    TargetMemo.field(5).value := targetRecRef.field(target_fields[3]).value;

                TargetMemo.field(4).value := sourcememo.field(4).value;

                TargetMemo.field(6).value := sourcememo.field(6).value;
                TargetMemo.field(10).value := sourcememo.field(10).value;
                TargetMemo.field(11).value := sourcememo.field(11).value;
                TargetMemo.field(12).value := sourcememo.field(12).value;
                clear(TempBlob);
                sourcememofield := SourceMemo.field(21);
                targetMemoField := TargetMemo.field(21);
                TempBlob.FromFieldRef(SourceMemoField);
                TempBlob.ToFieldRef(TargetMemofield);
                targetmemo.insert();

            until sourcememo.next() = 0;

        handled := true;
    end;

    local procedure isserviceTable(TableId: integer; var field_No: array[10] of integer) result: integer
    begin
        if tableid in [database::"service header", database::"service contract Header", database::"Service Contract Template"] then
            result := 1;
        if tableid in [database::"service line", database::"Service item Line", Database::"Service Contract Line"] then
            result := 2;

        if tableid in [database::"service invoice header", database::"Service Shipment Header", database::"Service Cr.Memo Header"] then
            result := 3;
        if tableid in [database::"service invoice line", database::"Service Shipment Line", database::"Service Cr.Memo Line", database::"Service Shipment Item Line"] then
            result := 4;

        case tableid of
            database::"Service item Line":
                begin
                    field_No[1] := 43;
                    field_No[2] := 1;
                    field_No[3] := 2;
                end;
            database::"Service Shipment Item Line":
                begin
                    field_No[1] := 0;
                    field_No[2] := 1;
                    field_No[3] := 2;
                end;
            database::"Service Line":
                begin
                    field_No[1] := 1;
                    field_No[2] := 3;
                    field_No[3] := 4;
                end;
            database::"Service shipment Line", database::"Service Cr.Memo Line", database::"Service Invoice Line":
                begin
                    field_No[1] := 0;
                    field_No[2] := 3;
                    field_No[3] := 4;
                end;
            database::"Service header":
                begin
                    field_No[1] := 1;
                    field_No[2] := 3;
                    field_No[3] := 0;
                end;
            database::"Service shipment header", database::"Service Cr.Memo header", database::"Service Invoice header":
                begin
                    field_No[1] := 0;
                    field_No[2] := 3;
                    field_No[3] := 0;
                end;
            database::"Service Contract Header":
                begin
                    field_No[1] := 2;
                    field_No[2] := 1;
                    field_No[3] := 0;
                end;
            database::"Service Contract line":
                begin
                    field_No[1] := 1;
                    field_No[2] := 2;
                    field_No[3] := 3;
                end;
            database::"Service Contract template":
                begin
                    field_No[1] := 0;
                    field_No[2] := 1;
                    field_No[3] := 0;
                end;

        end;
    end;

}
