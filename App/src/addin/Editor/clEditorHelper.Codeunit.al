codeunit 5272729 "lbt cl EditorHelper"
{
    procedure TextEditor(var data: Text; HTML: Boolean) Result: Boolean
    var
        Editor: Page "lbt cl Editor";
    begin
        Editor.SetText(data, HTML);
        Editor.LookupMode(true);
        Editor.RunModal();
        if Editor.IfLookupOk() then begin
            data := Editor.GetText();
            Result := true;
        end;
    end;

    procedure deleteLongText(vari: Variant; OtherDocType: Integer)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(vari);
        deleteLongText(RecRef, OtherDocType);
    end;

    procedure deleteLongText(RecRef: RecordRef; OtherDocType: Integer)
    var
        PSLongtextLn: Record "lbt PS Longtext Line";
        PstdPSLongtextLn: Record "lbt Posted PS Longtext Line";
        ArchivePSLongtextLn: Record "lbt Archive PS Longtext Line";
        TableId: Integer;
        Tabletype: Integer;

    begin
        TableId := RecRef.Number;
        Tabletype := GetType(TableId);

        case Tabletype of
            1:
                begin
                    SetPsLongtextLineFilter(PSLongtextLn, PSLongtextLn.Position::EditorFooter, OtherDocType, RecRef, false);
                    PSLongtextLn.SetRange(Position);
                    PSLongtextLn.DeleteAll(true);
                end;
            2:
                begin
                    SetPstdPsLongtextLineFilter(PstdPSLongtextLn, PstdPSLongtextLn.Position::EditorFooter, RecRef, false);
                    PstdPSLongtextLn.SetRange(Position);
                    PstdPSLongtextLn.DeleteAll(true);

                end;
            3:
                begin
                    SetArchPsLongtextLineFilter(ArchivePSLongtextLn, PstdPSLongtextLn.Position::EditorFooter, RecRef, false);
                    PstdPSLongtextLn.SetRange(Position);
                    PstdPSLongtextLn.DeleteAll(true);
                end;
        end;

    end;

    procedure getPrintData(vari: Variant; Position: Enum "lbt Position"; OtherDocType: Integer) Result: Text
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(vari);
        Result := getPrintData(RecRef, Position, OtherDocType);
    end;

    procedure getPrintData(RecRef: RecordRef; Position: Enum "lbt Position"; OtherDocType: Integer) Result: Text
    var
        PSLongtextLn: Record "lbt PS Longtext Line";
        PstdPSLongtextLn: Record "lbt Posted PS Longtext Line";
        ArchivePSLongtextLn: Record "lbt Archive PS Longtext Line";
        TableId: Integer;
        Tabletype: Integer;

    begin
        TableId := RecRef.Number;
        Tabletype := GetType(TableId);

        case Tabletype of
            1:
                begin
                    SetPsLongtextLineFilter(PSLongtextLn, Position, OtherDocType, RecRef, false);
                    if PSLongtextLn.FindFirst() then
                        Result := PSLongtextLn.ReadContentData(false);
                end;
            2:
                begin
                    SetPstdPsLongtextLineFilter(PstdPSLongtextLn, Position, RecRef, false);
                    if PstdPSLongtextLn.FindFirst() then
                        Result := PstdPSLongtextLn.ReadContentData(false);
                end;
            3:
                begin
                    SetArchPsLongtextLineFilter(ArchivePSLongtextLn, Position, RecRef, false);
                    if ArchivePSLongtextLn.FindFirst() then
                        Result := ArchivePSLongtextLn.ReadContentData(false);
                end;


        end;
        Result := PrepareHtmltoprint(Result);

    end;

    procedure hasEditorValue(vari: Variant; Position: Enum "lbt Position"; OtherDocType: Integer) Result: Boolean
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(vari);
        Result := hasEditorValue(RecRef, Position, OtherDocType);
    end;

    procedure hasEditorValue(RecRef: RecordRef; Position: Enum "lbt Position"; OtherDocType: Integer) Result: Boolean
    var
        PSLongtextLn: Record "lbt PS Longtext Line";
        PstdPSLongtextLn: Record "lbt Posted PS Longtext Line";
        ArchivePSLongtextLn: Record "lbt Archive PS Longtext Line";
        TableId: Integer;
        Tabletype: Integer;

    begin
        TableId := RecRef.Number;
        Tabletype := GetType(TableId);

        case Tabletype of
            1:
                begin
                    SetPsLongtextLineFilter(PSLongtextLn, Position, OtherDocType, RecRef, false);
                    exit(not PSLongtextLn.IsEmpty());
                end;
            2:
                begin
                    SetPstdPsLongtextLineFilter(PstdPSLongtextLn, Position, RecRef, false);
                    exit(not PstdPSLongtextLn.IsEmpty());

                end;
            3:
                begin
                    SetArchPsLongtextLineFilter(ArchivePSLongtextLn, Position, RecRef, false);
                    exit(not PstdPSLongtextLn.IsEmpty());

                end;


        end;
    end;

    procedure editData(vari: Variant; Position: Enum "lbt Position"; OtherDocType: Integer)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(vari);
        editData(RecRef, Position, OtherDocType);

    end;

    procedure editData(RecRef: RecordRef; Position: Enum "lbt Position"; OtherDocType: Integer)
    begin
        case GetType(RecRef.Number) of
            1:
                EditLongtext(RecRef, Position, OtherDocType);
            2:
                EditPostedLongtext(RecRef, Position);
            3:
                EditArchivedLongtext(RecRef, Position);
        end;
    end;

    internal procedure PrepareHtmltoprint(content: Text) Result: Text
    var
        TypeHelper: Codeunit "Type Helper";
        IndentClassLbl: Label '<p class="ql-indent-%1">', Locked = true;
        SpaceTemplateLbl: Label '<p>%1', Locked = true;
        chr: Char;
        text: Text;
        TextList: List of [Text];
        TextLine: Text;
        tb: TextBuilder;
        tab: Integer;
        i: Integer;
    begin
        tab := 5;
        text := content;

        for i := 1 to 10 do
            text := text.Replace(StrSubstNo(IndentClassLbl, i), StrSubstNo(SpaceTemplateLbl, getSpace(i * tab)));
        chr := 9;
        text := text.Replace(chr, getSpace(1 * tab));
        TextList := text.Split(TypeHelper.LFSeparator());
        TextList := text.Split('</p>');
        foreach TextLine in TextList do
            if not TextLine.Contains('######') then
                tb.AppendLine(TextLine + '</p>');

        Result := tb.ToText();

    end;

    internal procedure editorVisible(TableId: Integer): Boolean
    begin
        exit(true);
    end;


    local procedure getSpace(no: Integer) Result: Text
    var
        i: Integer;
    begin
        for i := 1 to no do
            Result += '&nbsp;';
    end;


    local procedure GetType(TableId: Integer): Integer
    begin
        ///Unposted
        if tableid in [36, 37, 38, 39, 5900, 5901, 5902, 5964, 5965, 5968] then
            exit(1);
        ///Posted
        if TableId in [110, 111, 112, 113, 114, 115, 120, 121, 122, 123, 124, 125, 5989, 5990, 5991, 5992, 5993, 5994, 5995] then
            exit(2);
        ///archived
        if TableId in [5107, 5108, 5109, 5110, 5102781] then
            exit(3);
    end;

    local procedure SetPsLongtextLineFilter(var PSLongtextLn: Record "lbt PS Longtext Line"; Position: Enum "lbt Position"; OtherDocType: Integer; RecRef: RecordRef; InsertIfEmpty: Boolean)
    var
        DocNo_FieldNo: Integer;
        DocType_FieldNo: Integer;
        LineNo_FieldNo: Integer;
    begin
        AssignFieldNos(RecRef, DocNo_FieldNo, DocType_FieldNo, LineNo_FieldNo);

        PSLongtextLn.SetRange("Table ID", RecRef.Number);
        if OtherDocType = 0 then
            PSLongtextLn.SetRange("Document Type", RecRef.Field(DocType_FieldNo).Value)
        else
            PSLongtextLn.SetRange("Document Type", OtherDocType);

        PSLongtextLn.SetRange("Document No.", RecRef.Field(DocNo_FieldNo).Value);
        PSLongtextLn.SetRange(Position, Position);
        if LineNo_FieldNo <> 0 then
            PSLongtextLn.SetRange("Document Line No.", RecRef.Field(LineNo_FieldNo).Value);
        if not InsertIfEmpty then
            exit;
        if PSLongtextLn.FindFirst() then
            exit;
        PSLongtextLn.Init();
        PSLongtextLn."Table ID" := RecRef.Number;
        PSLongtextLn."Document Type" := OtherDocType;
        PSLongtextLn."Document No." := RecRef.Field(DocNo_FieldNo).Value;
        if LineNo_FieldNo <> 0 then
            PSLongtextLn."Document Line No." := RecRef.Field(LineNo_FieldNo).Value;
        PSLongtextLn.Position := Position;
        PSLongtextLn.Insert(true);
        Commit(); //TODO: explain Commit
    end;

    local procedure SetPstdPsLongtextLineFilter(var PstdPSLongtextLn: Record "lbt Posted PS Longtext Line"; Position: Enum "lbt Position"; RecRef: RecordRef; InsertIfEmpty: Boolean)
    var
        Field_Nos: array[10] of Integer;
        DocNo_FieldNo: Integer;
        LineNo_FieldNo: Integer;
    begin
        DocNo_FieldNo := 3;
        if RecRef.Number in [37, 39, 111, 113, 115, 121, 123, 125, 5108, 5110] then
            LineNo_FieldNo := 4;

        if isserviceTable(RecRef.Number, Field_Nos) <> 0 then begin
            DocNo_FieldNo := Field_Nos[2];
            LineNo_FieldNo := Field_Nos[3];
        end;

        PstdPSLongtextLn.SetRange("Table ID", RecRef.Number);
        PstdPSLongtextLn.SetRange("Document No.", RecRef.Field(DocNo_FieldNo).Value);
        PstdPSLongtextLn.SetRange(Position, Position);
        PstdPSLongtextLn.SetRange("Document Line No.", RecRef.Field(LineNo_FieldNo).Value);
        if not InsertIfEmpty then
            exit;
        if PstdPSLongtextLn.FindFirst() then
            exit;
        PstdPSLongtextLn.Init();
        PstdPSLongtextLn."Table ID" := RecRef.Number;
        PstdPSLongtextLn."Document No." := RecRef.Field(DocNo_FieldNo).Value;
        PstdPSLongtextLn."Document Line No." := RecRef.Field(LineNo_FieldNo).Value;
        PstdPSLongtextLn.Position := Position;
        PstdPSLongtextLn.Insert(true);
        Commit(); //TODO: explain Commit
    end;

    local procedure SetArchPsLongtextLineFilter(var ArchivePSLongtextLn: Record "lbt Archive PS Longtext Line"; Position: Enum "lbt Position"; RecRef: RecordRef; InsertIfEmpty: Boolean)
    var
        DocType_FieldNo: Integer;
        DocNo_FieldNo: Integer;
        LineNo_FieldNo: Integer;
        docOccur_FieldNo: Integer;
        version_FieldNo: Integer;
    begin
        AssignFieldNos(RecRef, DocType_FieldNo, DocNo_FieldNo, LineNo_FieldNo, docOccur_FieldNo, version_FieldNo);

        ///TODO Archive Filter
        ArchivePSLongtextLn.SetRange("Table ID", RecRef.Number);
        ArchivePSLongtextLn.SetRange("Document Type", RecRef.Field(DocType_FieldNo).Value);
        ArchivePSLongtextLn.SetRange("Document No.", RecRef.Field(DocNo_FieldNo).Value);
        ArchivePSLongtextLn.SetRange(Position, Position);
        if LineNo_FieldNo <> 0 then
            ArchivePSLongtextLn.SetRange("Document Line No.", RecRef.Field(LineNo_FieldNo).Value);
        if docOccur_FieldNo <> 0 then
            ArchivePSLongtextLn.SetRange("Doc. No. Occurrence", RecRef.Field(docOccur_FieldNo).Value);
        if version_FieldNo <> 0 then
            ArchivePSLongtextLn.SetRange("Version No.", RecRef.Field(version_FieldNo).Value);
        if not InsertIfEmpty then
            exit;
        if ArchivePSLongtextLn.FindFirst() then
            exit;
        ArchivePSLongtextLn.Init();
        ArchivePSLongtextLn."Table ID" := RecRef.Number;
        ArchivePSLongtextLn."Document Type" := RecRef.Field(DocNo_FieldNo).Value;
        ArchivePSLongtextLn."Document No." := RecRef.Field(DocNo_FieldNo).Value;
        ArchivePSLongtextLn."Document Line No." := RecRef.Field(LineNo_FieldNo).Value;
        ArchivePSLongtextLn.Position := Position;
        ArchivePSLongtextLn.Insert(true);
        Commit(); //TODO: Explain commit
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"lbt Longtext Mgt.", 'onbeforeCopyLongText', '', true, true)]
    local procedure lbtLongtextMgt_onbeforeCopyLongText(Sourcerecref: RecordRef; TargetRecRef: RecordRef; var handled: Boolean)
    var
        TargetMemo: RecordRef;
        SourceMemo: RecordRef;

        TargetType: Integer;
        SourceType: Integer;
        source_Fields: array[10] of Integer;
        target_fields: array[10] of Integer;

    begin
        SourceType := isserviceTable(Sourcerecref.Number, source_Fields);
        TargetType := isserviceTable(TargetRecRef.Number, target_fields);
        if (TargetType = 0) and (SourceType = 0) then
            exit;
        OpenMemo(SourceMemo, SourceType);
        OpenMemo(TargetMemo, TargetType);

        SetMemoFilters(Sourcerecref, SourceMemo, source_Fields);

        if SourceMemo.FindSet() then
            repeat
                InitMemoFields(TargetRecRef, TargetMemo, target_fields);
                CopyMemoFields(TargetMemo, SourceMemo);
                TargetMemo.Insert();
            until SourceMemo.Next() = 0;

        handled := true;
    end;

    local procedure isserviceTable(TableId: Integer; var field_No: array[10] of Integer) TableType: Integer
    begin
        TableType := GetServiceTableType(TableId);
        case TableId of
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

    local procedure GetServiceTableType(TableId: Integer) TableType: Integer
    begin
        case TableId of
            database::"Service Header":
                TableType := 1;
            database::"Service Line",
            database::"Service Item Line":
                TableType := 2;
            database::"Service Invoice Header",
            database::"Service Shipment Header",
            database::"Service Cr.Memo Header":
                TableType := 3;
            database::"Service Invoice Line",
            database::"Service Shipment Line",
            database::"Service Cr.Memo Line",
            database::"Service Shipment Item Line":
                TableType := 4;
        end;
    end;

    local procedure SetMemoFilters(var Sourcerecref: RecordRef; var SourceMemo: RecordRef; source_Fields: array[10] of Integer)
    var
        SourceRecField: FieldRef;
        SourceMemoField: FieldRef;
    begin
        ///TableId
        SourceMemoField := SourceMemo.Field(1);
        SourceMemoField.SetRange(Sourcerecref.Number);

        ///doctype
        if source_Fields[1] <> 0 then begin
            SourceRecField := Sourcerecref.Field(source_Fields[1]);
            SourceMemoField := SourceMemo.Field(2);
            SourceMemoField.SetRange(SourceRecField.Value);
        end;

        ///DocNo
        if source_Fields[2] <> 0 then begin
            SourceRecField := Sourcerecref.Field(source_Fields[2]);
            SourceMemoField := SourceMemo.Field(3);
            SourceMemoField.SetRange(SourceRecField.Value);
        end;

        ///lineno
        if source_Fields[3] <> 0 then begin
            SourceRecField := Sourcerecref.Field(source_Fields[3]);
            SourceMemoField := SourceMemo.Field(5);
            SourceMemoField.SetRange(SourceRecField.Value);
        end;
    end;

    local procedure OpenMemo(var SourceMemo: RecordRef; SourceType: Integer)
    begin
        case SourceType of
            1, 2:
                SourceMemo.Open(database::"lbt PS Longtext Line");
            3, 4:
                SourceMemo.Open(database::"lbt Posted PS Longtext Line");
        end;
    end;

    local procedure InitMemoFields(var RecRef: RecordRef; var Memo: RecordRef; KeyFields: array[10] of Integer)
    begin
        Memo.Init();
        Memo.Field(1).Value := RecRef.Number;
        if KeyFields[1] <> 0 then
            Memo.Field(2).Value := RecRef.Field(KeyFields[1]).Value;
        if KeyFields[2] <> 0 then
            Memo.Field(3).Value := RecRef.Field(KeyFields[2]).Value;
        if KeyFields[3] <> 0 then
            Memo.Field(5).Value := RecRef.Field(KeyFields[3]).Value;
    end;

    local procedure CopyMemoFields(var TargetMemo: RecordRef; var SourceMemo: RecordRef)
    var
        TempBlob: Codeunit "Temp Blob";
        SourceMemoField: FieldRef;
        TargetMemoField: FieldRef;
    begin
        TargetMemo.Field(4).Value := SourceMemo.Field(4).Value;
        TargetMemo.Field(6).Value := SourceMemo.Field(6).Value;
        TargetMemo.Field(10).Value := SourceMemo.Field(10).Value;
        TargetMemo.Field(11).Value := SourceMemo.Field(11).Value;
        TargetMemo.Field(12).Value := SourceMemo.Field(12).Value;
        Clear(TempBlob);
        SourceMemoField := SourceMemo.Field(21);
        TargetMemoField := TargetMemo.Field(21);
        TempBlob.FromFieldRef(SourceMemoField);
        TempBlob.ToFieldRef(TargetMemoField);
    end;

    local procedure AssignFieldNos(var RecRef: RecordRef; var DocType_FieldNo: Integer; var DocNo_FieldNo: Integer; var LineNo_FieldNo: Integer; var docOccur_FieldNo: Integer; var version_FieldNo: Integer)
    var
        Field_Nos: array[10] of Integer;
    begin
        AssignFieldNos(RecRef, DocNo_FieldNo, DocType_FieldNo, LineNo_FieldNo);

        if RecRef.Number in [5107, 5108, 5109, 5110] then begin
            docOccur_FieldNo := 5048;
            version_FieldNo := 5047;
        end;

        if isserviceTable(RecRef.Number, Field_Nos) <> 0 then begin
            docOccur_FieldNo := Field_Nos[4];
            version_FieldNo := Field_Nos[5];
        end;
    end;

    local procedure AssignFieldNos(var RecRef: RecordRef; var DocNo_FieldNo: Integer; var DocType_FieldNo: Integer; var LineNo_FieldNo: Integer)
    var
        Field_Nos: array[10] of Integer;
    begin
        DocType_FieldNo := 1;
        DocNo_FieldNo := 3;
        if RecRef.Number in [37, 39, 111, 113, 115, 121, 123, 125, 5108, 5110] then
            LineNo_FieldNo := 4;
        if isserviceTable(RecRef.Number, Field_Nos) <> 0 then begin
            DocType_FieldNo := Field_Nos[1];
            DocNo_FieldNo := Field_Nos[2];
            LineNo_FieldNo := Field_Nos[3];
        end;
    end;

    local procedure EditLongtext(var RecRef: RecordRef; Position: Enum "lbt Position"; OtherDocType: Integer)
    var
        PSLongtextLn: Record "lbt PS Longtext Line";
    begin
        SetPsLongtextLineFilter(PSLongtextLn, Position, OtherDocType, RecRef, true);
        PSLongtextLn.EditData();
        if not PSLongtextLn."Editor Content".HasValue() then
            if PSLongtextLn.Delete(true) then;
    end;

    local procedure EditPostedLongtext(var RecRef: RecordRef; Position: Enum "lbt Position")
    var
        PstdPSLongtextLn: Record "lbt Posted PS Longtext Line";
    begin
        SetPstdPsLongtextLineFilter(PstdPSLongtextLn, Position, RecRef, true);
        PstdPSLongtextLn.EditData();
        if not PstdPSLongtextLn."Editor Content".HasValue() then
            if PstdPSLongtextLn.Delete(true) then;
    end;

    local procedure EditArchivedLongtext(var RecRef: RecordRef; Position: Enum "lbt Position")
    var
        ArchivePSLongtextLn: Record "lbt Archive PS Longtext Line";
    begin
        SetArchPsLongtextLineFilter(ArchivePSLongtextLn, Position, RecRef, true);
        ArchivePSLongtextLn.EditData();
        if not ArchivePSLongtextLn."Editor Content".HasValue() then
            if ArchivePSLongtextLn.Delete(true) then;
    end;

}
