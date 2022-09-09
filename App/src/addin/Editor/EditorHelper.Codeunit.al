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

    procedure ShowTextEditor(data: Text; IsHTML: Boolean) Result: Boolean
    var
        Editor: Page "lbt cl Editor";
    begin
        Editor.SetText(data, IsHTML);
        Editor.Editable(false);
        Editor.RunModal();
    end;

    procedure deleteLongText(vari: Variant)
    begin
        deleteLongText(vari, 0);
    end;

    procedure deleteLongTextSysId(vari: Variant)
    begin
        deleteLongText(vari, 0);
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
        PSLongtextSystemId: Record "lbt clPSLongtextSystemId";
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
            5:
                begin
                    PSLongtextSystemId.SetRange("Table Id", RecRef.Number);
                    PSLongtextSystemId.SetRange("Source System Id", RecRef.Field(RecRef.SystemIdNo).Value);
                    PSLongtextSystemId.DeleteAll(true);
                end;
        end;

    end;

    procedure getPrintDataSysId(vari: Variant; Position: Enum "lbt Position"; OtherDocType: Integer) Result: Text
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(vari);
        Result := getPrintData(RecRef, Position, OtherDocType);
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
        PSLongtextSystemId: Record "lbt clPSLongtextSystemId";
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
            5:
                begin
                    PSLongtextSystemId.SetRange("Table Id", RecRef.Number);
                    PSLongtextSystemId.SetRange("Source System Id", RecRef.Field(RecRef.SystemIdNo).Value);
                    if PSLongtextSystemId.FindFirst() then
                        Result := PSLongtextSystemId.ReadContentData(false);
                end;


        end;
        Result := PrepareHtmltoprint(Result);

    end;

    procedure hasEditorValue(vari: Variant; Position: Enum "lbt Position") Result: Boolean
    begin
        Result := hasEditorValue(vari, Position, 0);
    end;

    procedure hasEditorValue(vari: Variant; Position: Enum "lbt Position"; OtherDocType: Integer) Result: Boolean
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(vari);
        Result := hasEditorValue(RecRef, Position, OtherDocType);
    end;

    procedure hasEditorValueSysId(vari: Variant; Position: Enum "lbt Position"; OtherDocType: Integer) Result: Boolean
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
        PSLongtextSystemId: Record "lbt clPSLongtextSystemId";

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
            5:
                begin
                    SetPSLongTextLineSysIdFilter(PSLongtextSystemId, Position, OtherDocType, RecRef, false);
                    exit(not PSLongtextSystemId.IsEmpty());
                end;

        end;
    end;

    procedure editData(vari: Variant; Position: Enum "lbt Position")
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(vari);
        editData(RecRef, Position, 0, true);
    end;

    procedure editData(vari: Variant; Position: Enum "lbt Position"; OtherDocType: Integer)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(vari);
        editData(RecRef, Position, OtherDocType, true);

    end;

    procedure editDataSysId(vari: Variant; Position: Enum "lbt Position"; OtherDocType: Integer): Boolean
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(vari);
        editData(RecRef, Position, OtherDocType, true);

    end;

    procedure ShowDataSysId(vari: Variant; Position: Enum "lbt Position"; OtherDocType: Integer): Boolean
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(vari);
        editData(RecRef, Position, OtherDocType, false);

    end;


    procedure editData(RecRef: RecordRef; Position: Enum "lbt Position"; OtherDocType: Integer; editable: Boolean)
    begin
        case GetType(RecRef.Number) of
            1:
                EditLongtext(RecRef, Position, OtherDocType);
            2:
                EditPostedLongtext(RecRef, Position);
            3:
                EditArchivedLongtext(RecRef, Position);
            5:
                EditLongtextSysId(RecRef, Position, OtherDocType, editable);
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


    local procedure GetType(TableId: Integer) Result: Integer
    var
        handled: Boolean;
    begin
        case TableId of
            Database::"Sales Header",
            Database::"Sales Line",
            Database::"Purchase Header",
            Database::"Purchase Line",
            Database::"Service Header",
            Database::"Service Item Line",
            Database::"Service Line",
            Database::"Service Contract Line",
            Database::"Service Contract Header",
            Database::"Service Contract Template":
                Result := 1; ///Unposted

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
                Result := 2; ///Posted

            Database::"Sales Header Archive",
            Database::"Sales Line Archive",
            Database::"Purchase Header Archive",
            Database::"Purchase Line Archive":
                Result := 3; ///archived

            Database::Customer,
            Database::Job,
            Database::"Job Planning Line",
            Database::"Standard Sales Code",
            Database::"Standard Sales Line",
            Database::"Standard Customer Sales Code",
            Database::"Assembly Line":
                Result := 5;
        end;

        OnAfterGetType(TableId, handled, Result);
    end;

    local procedure SetPsLongtextLineFilter(var PSLongtextLn: Record "lbt PS Longtext Line"; Position: Enum "lbt Position"; OtherDocType: Integer;
                                                                                                           RecRef: RecordRef;
                                                                                                           InsertIfEmpty: Boolean)
    var
        DocNo_FieldNo: Integer;
        DocType_FieldNo: Integer;
        LineNo_FieldNo: Integer;
    begin
        AssignFieldNos(RecRef, DocNo_FieldNo, DocType_FieldNo, LineNo_FieldNo);
        PSLongtextLn.SetRange("Table ID", RecRef.Number);
        if OtherDocType = 0 then begin
            if DocType_FieldNo <> 0 then
                PSLongtextLn.SetRange("Document Type", RecRef.Field(DocType_FieldNo).Value);
        end else
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
        PSLongtextLn."Document Type" := "Sales Document Type".FromInteger(OtherDocType);
        PSLongtextLn."Document No." := RecRef.Field(DocNo_FieldNo).Value;
        if LineNo_FieldNo <> 0 then
            PSLongtextLn."Document Line No." := RecRef.Field(LineNo_FieldNo).Value;
        PSLongtextLn.Position := Position;
        PSLongtextLn.Insert(true);
        Commit(); //TODO: explain Commit
    end;

    local procedure SetPstdPsLongtextLineFilter(var PstdPSLongtextLn: Record "lbt Posted PS Longtext Line"; Position: Enum "lbt Position"; RecRef: RecordRef;
                                                                                                                          InsertIfEmpty: Boolean)
    var
        Field_Nos: array[10] of Integer;
        DocNo_FieldNo: Integer;
        LineNo_FieldNo: Integer;
    begin
        GetKeyFields(RecRef.Number, Field_Nos);
        DocNo_FieldNo := Field_Nos[2];
        LineNo_FieldNo := Field_Nos[3];

        PstdPSLongtextLn.SetRange("Table ID", RecRef.Number);
        PstdPSLongtextLn.SetRange("Document No.", RecRef.Field(DocNo_FieldNo).Value);
        PstdPSLongtextLn.SetRange(Position, Position);
        if LineNo_FieldNo <> 0 then
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

    local procedure SetArchPsLongtextLineFilter(var ArchivePSLongtextLn: Record "lbt Archive PS Longtext Line"; Position: Enum "lbt Position"; RecRef: RecordRef;
                                                                                                                              InsertIfEmpty: Boolean)
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

    local procedure SetPSLongTextLineSysIdFilter(var PSLongtextSystemId: Record "lbt clPSLongtextSystemId"; Position: Enum "lbt Position"; OtherDocType: Integer; RecRef: RecordRef; insertIfEmpty: Boolean)
    begin
        PSLongtextSystemId.SetRange("Table Id", RecRef.Number);
        PSLongtextSystemId.SetRange("Source System Id", RecRef.Field(RecRef.SystemIdNo).Value);
        PSLongtextSystemId.SetRange("Document Type", OtherDocType);
        PSLongtextSystemId.SetRange(Position, Position);
        if not insertIfEmpty then
            exit;
        if PSLongtextSystemId.FindFirst() then
            exit;
        PSLongtextSystemId.Init();
        PSLongtextSystemId."Table Id" := RecRef.Number;
        PSLongtextSystemId."Source System Id" := RecRef.Field(RecRef.SystemIdNo).Value;
        PSLongtextSystemId.Position := Position;
        PSLongtextSystemId."Document Type" := "Sales Document Type".FromInteger(OtherDocType);
        PSLongtextSystemId.Insert(true);
        Commit(); //TODO: explain Commit
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"lbt Longtext Mgt.", 'onbeforeCopyLongText', '', true, true)]
    local procedure lbtLongtextMgt_onbeforeCopyLongText(SourceRecRef: RecordRef; TargetRecRef: RecordRef; var handled: Boolean)
    var
        TargetMemo: RecordRef;
        SourceMemo: RecordRef;

        SourceMemoField: FieldRef;
        TargetType: Integer;
        SourceType: Integer;
        source_Fields: array[10] of Integer;
        target_fields: array[10] of Integer;

    begin
        if handled then
            exit;
        SourceType := GetType(SourceRecRef.Number);
        TargetType := GetType(TargetRecRef.Number);

        if (SourceType = 0) or (TargetType = 0) then
            exit;

        GetKeyFields(TargetRecRef.Number, target_fields);
        GetKeyFields(SourceRecRef.Number, source_Fields);

        OpenMemo(SourceMemo, SourceType);
        OpenMemo(TargetMemo, TargetType);

        SetMemoFilters(SourceRecRef, TargetRecRef, SourceMemo, source_Fields, SourceType);

        if SourceRecRef.Number = Database::Job then begin
            SourceMemoField := SourceMemo.Field(3);
            SourceMemoField.SetRange(Enum::"Sales Document Type"::Invoice);
        end;

        if SourceMemo.FindSet() then
            repeat
                InitMemoFields(TargetRecRef, TargetMemo, target_fields, TargetType);
                if IsOrderOrCustomer(TargetRecRef) then
                    if SourceType = 5 then
                        TargetMemo.Field(2).Value := SourceMemo.Field(3).Value
                    else
                        TargetMemo.Field(2).Value := SourceMemo.Field(2).Value;
                CopyMemoFields(TargetMemo, SourceMemo);
                if TargetMemo.Insert() then;
            until SourceMemo.Next() = 0;

        handled := true;
    end;

    local procedure SetMemoFilters(var Sourcerecref: RecordRef; var TargetRecRef: RecordRef; var SourceMemo: RecordRef; source_Fields: array[10] of Integer; SourceType: Integer)
    var
        SourceRecField: FieldRef;
        SourceMemoField: FieldRef;
    begin
        ///TableId
        SourceMemoField := SourceMemo.Field(1);
        SourceMemoField.SetRange(Sourcerecref.Number);

        ///SystemId
        if SourceType = 5 then begin
            SourceMemoField := SourceMemo.Field(2);
            SourceMemoField.SetRange(Sourcerecref.Field(Sourcerecref.SystemIdNo).Value);
            SourceMemoField := SourceMemo.Field(3);
            SetSourceTypeFilter(Sourcerecref, TargetRecRef, SourceMemoField);
            exit;
        end;

        ///doctype
        if source_Fields[1] <> 0 then begin
            SourceRecField := Sourcerecref.Field(source_Fields[1]);
            SourceMemoField := SourceMemo.Field(2);
            SourceMemoField.SetRange(SourceRecField.Value);
            if Sourcerecref.Number = Database::"Service Header" then begin
                if TargetRecRef.Number = Database::"Service Shipment Header" then
                    SourceMemoField.SetRange(11);
                if TargetRecRef.Number = Database::"Service Invoice Header" then
                    SourceMemoField.SetRange(12);
            end;
            SetSourceTypeFilter(Sourcerecref, TargetRecRef, SourceMemoField);
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
        if source_Fields[4] <> 0 then begin
            SourceRecField := Sourcerecref.Field(source_Fields[4]);
            SourceMemoField := SourceMemo.Field(7);
            SourceMemoField.SetRange(SourceRecField.Value);
        end;
        if source_Fields[5] <> 0 then begin
            SourceRecField := Sourcerecref.Field(source_Fields[5]);
            SourceMemoField := SourceMemo.Field(8);
            SourceMemoField.SetRange(SourceRecField.Value);
        end;
    end;

    local procedure OpenMemo(var SourceMemo: RecordRef; SourceType: Integer)
    begin
        case SourceType of
            1:
                SourceMemo.Open(Database::"lbt PS Longtext Line");
            2:
                SourceMemo.Open(Database::"lbt Posted PS Longtext Line");
            3:
                SourceMemo.Open(Database::"lbt Archive PS Longtext Line");
            5:
                SourceMemo.Open(Database::"lbt clPSLongtextSystemId");
        end;
    end;

    local procedure InitMemoFields(var RecRef: RecordRef; var Memo: RecordRef; KeyFields: array[10] of Integer; TargetType: Integer)
    begin
        Memo.Init();
        Memo.Field(1).Value := RecRef.Number;
        if TargetType = 5 then begin
            Memo.Field(2).Value := RecRef.Field(RecRef.SystemIdNo).Value;
        end else begin

            if KeyFields[1] <> 0 then
                Memo.Field(2).Value := RecRef.Field(KeyFields[1]).Value;
            if KeyFields[2] <> 0 then
                Memo.Field(3).Value := RecRef.Field(KeyFields[2]).Value;
            if KeyFields[3] <> 0 then
                Memo.Field(5).Value := RecRef.Field(KeyFields[3]).Value
            else
                Memo.Field(5).Value := 0;
            if KeyFields[4] <> 0 then
                Memo.Field(7).Value := RecRef.Field(KeyFields[4]).Value;
            if KeyFields[5] <> 0 then
                Memo.Field(8).Value := RecRef.Field(KeyFields[5]).Value;



        end;
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
        GetKeyFields(RecRef.Number, Field_Nos);
        DocType_FieldNo := Field_Nos[1];
        DocNo_FieldNo := Field_Nos[2];
        LineNo_FieldNo := Field_Nos[3];
        docOccur_FieldNo := Field_Nos[4];
        version_FieldNo := Field_Nos[5];

        // AssignFieldNos(RecRef, DocNo_FieldNo, DocType_FieldNo, LineNo_FieldNo);

        // if RecRef.Number in [5107, 5108, 5109, 5110] then begin
        //     docOccur_FieldNo := 5048;
        //     version_FieldNo := 5047;
        // end;

        // if isserviceTable(RecRef.Number, Field_Nos) <> 0 then begin
        //     docOccur_FieldNo := Field_Nos[4];
        //     version_FieldNo := Field_Nos[5];
        // end;
    end;

    local procedure AssignFieldNos(var RecRef: RecordRef; var DocNo_FieldNo: Integer; var DocType_FieldNo: Integer; var LineNo_FieldNo: Integer)
    var
        Field_Nos: array[10] of Integer;
        handled: Boolean;
    begin
        GetKeyFields(RecRef.Number, Field_Nos);
        DocType_FieldNo := Field_Nos[1];
        DocNo_FieldNo := Field_Nos[2];
        LineNo_FieldNo := Field_Nos[3];
        // if RecRef.Number in [37, 39, 111, 113, 115, 121, 123, 125, 5108, 5110] then
        //     LineNo_FieldNo := 4;
        // if isserviceTable(RecRef.Number, Field_Nos) <> 0 then begin
        //     DocType_FieldNo := Field_Nos[1];
        //     DocNo_FieldNo := Field_Nos[2];
        //     LineNo_FieldNo := Field_Nos[3];
        // end;
        OnAfterAssignFieldNos(RecRef.Number, DocType_FieldNo, DocNo_FieldNo, LineNo_FieldNo, handled);
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
        PstdPSLongtextLn.ShowData();
        // PstdPSLongtextLn.EditData();
        // if not PstdPSLongtextLn."Editor Content".HasValue() then
        //     if PstdPSLongtextLn.Delete(true) then;
    end;

    local procedure EditArchivedLongtext(var RecRef: RecordRef; Position: Enum "lbt Position")
    var
        ArchivePSLongtextLn: Record "lbt Archive PS Longtext Line";
    begin
        SetArchPsLongtextLineFilter(ArchivePSLongtextLn, Position, RecRef, true);
        ArchivePSLongtextLn.ShowData();
        // ArchivePSLongtextLn.EditData();
        // if not ArchivePSLongtextLn."Editor Content".HasValue() then
        //     if ArchivePSLongtextLn.Delete(true) then;
    end;

    local procedure EditLongtextSysId(var RecRef: RecordRef; Position: Enum "lbt Position"; OtherDocType: Integer; editable: Boolean)
    var
        PSLongtextSysId: Record "lbt clPSLongtextSystemId";
    begin
        SetPSLongTextLineSysIdFilter(PSLongtextSysId, Position, OtherDocType, RecRef, true);
        if editable then begin
            PSLongtextSysId.EditData();
            if not PSLongtextSysId."Editor Content".HasValue() then
                if PSLongtextSysId.Delete(true) then;
        end else begin
            PSLongtextSysId.ShowData();
        end;
    end;

    local procedure GetKeyFields(TableId: Integer; var field_No: array[10] of Integer)
    var
        handled: Boolean;
    begin
        case TableId of
            Database::"Purchase Header", Database::"Sales Header":
                begin
                    field_No[1] := 1;
                    field_No[2] := 3;
                    field_No[3] := 0;
                end;
            Database::"Purchase Line", Database::"Sales Line":
                begin
                    field_No[1] := 1;
                    field_No[2] := 3;
                    field_No[3] := 4;
                end;
            110, 112, 114, 120, 122, 124:
                begin
                    field_No[1] := 0;
                    field_No[2] := 3;
                    field_No[3] := 0;
                end;
            5107, 5109:
                begin
                    field_No[1] := 1;
                    field_No[2] := 3;
                    field_No[3] := 0;
                    field_No[4] := 5048;
                    field_No[5] := 5047;
                end;
            111, 113, 115, 121, 123, 125:
                begin

                    field_No[1] := 0;
                    field_No[2] := 3;
                    field_No[3] := 4;

                end;
            5108, 5110:
                begin
                    field_No[1] := 1;
                    field_No[2] := 3;
                    field_No[3] := 4;
                    field_No[4] := 5048;
                    field_No[5] := 5047;
                end;

            Database::"Service Item Line":
                begin
                    field_No[1] := 43;
                    field_No[2] := 1;
                    field_No[3] := 2;
                end;
            Database::"Service Shipment Item Line":
                begin
                    field_No[1] := 0;
                    field_No[2] := 1;
                    field_No[3] := 2;
                end;
            Database::"Service Line":
                begin
                    field_No[1] := 1;
                    field_No[2] := 3;
                    field_No[3] := 4;
                end;
            Database::"Service Shipment Line", Database::"Service Cr.Memo Line", Database::"Service Invoice Line":
                begin
                    field_No[1] := 0;
                    field_No[2] := 3;
                    field_No[3] := 4;
                end;
            Database::"Service Header":
                begin
                    field_No[1] := 1;
                    field_No[2] := 3;
                    field_No[3] := 0;
                end;
            Database::"Service Shipment Header", Database::"Service Cr.Memo Header", Database::"Service Invoice Header":
                begin
                    field_No[1] := 0;
                    field_No[2] := 3;
                    field_No[3] := 0;
                end;
            Database::"Service Contract Header":
                begin
                    field_No[1] := 2;
                    field_No[2] := 1;
                    field_No[3] := 0;
                end;
            Database::"Service Contract Line":
                begin
                    field_No[1] := 1;
                    field_No[2] := 2;
                    field_No[3] := 3;
                end;
            Database::"Service Contract Template":
                begin
                    field_No[1] := 0;
                    field_No[2] := 1;
                    field_No[3] := 0;
                end;
        end;
        onAfterGetKeyFields(TableId, field_No, handled)
    end;

    local procedure IsOrderOrCustomer(var Sourcerecref: RecordRef): Boolean
    var
        FRef: FieldRef;
        DocType: Enum "Sales Document Type";
    begin
        if Sourcerecref.Number = Database::Customer then
            exit(true);
        if not (Sourcerecref.Number in [Database::"Sales Header", Database::"Purchase Header"]) then
            exit(false);
        FRef := Sourcerecref.Field(1);
        DocType := FRef.Value();
        if DocType = DocType::Order then
            exit(true);
    end;

    local procedure IsInvoice(var RecRef: RecordRef): Boolean
    begin
        if (RecRef.Number in [Database::"Sales Invoice Header", Database::"Purch. Inv. Header"]) then
            exit(true);
        exit(IsDocType(RecRef, Enum::"Sales Document Type"::Invoice));
    end;

    local procedure IsShipment(var RecRef: RecordRef): Boolean
    begin
        if (RecRef.Number in [Database::"Sales Shipment Header", Database::"Purch. Rcpt. Header"]) then
            exit(true);
        exit(IsDocType(RecRef, Enum::"Sales Document Type"::Invoice));
    end;

    local procedure SetSourceTypeFilter(var Sourcerecref: RecordRef; var TargetRecRef: RecordRef; var SourceMemoField: FieldRef)
    begin
        if not IsOrderOrCustomer(Sourcerecref) then
            exit;
        case true of
            IsInvoice(TargetRecRef):
                SourceMemoField.SetRange(Enum::"Sales Document Type"::Invoice);
            IsShipment(TargetRecRef):
                SourceMemoField.SetRange(Enum::"Sales Document Type"::"lbt cl Shipment/Receipt");
            IsDocType(TargetRecRef, Enum::"Sales Document Type"::Quote):
                SourceMemoField.SetRange(Enum::"Sales Document Type"::Quote);
            IsDocType(TargetRecRef, Enum::"Sales Document Type"::"Credit Memo"):
                SourceMemoField.SetRange(Enum::"Sales Document Type"::"Credit Memo");
            else
                SourceMemoField.SetRange();
        end;
    end;

    local procedure IsDocType(var RecRef: RecordRef; DocType2: Enum "Sales Document Type"): Boolean
    var
        FRef: FieldRef;
        DocType: Enum "Sales Document Type";
    begin
        if not (RecRef.Number in [Database::"Sales Header", Database::"Purchase Header"]) then
            exit(false);
        FRef := RecRef.Field(1);
        DocType := FRef.Value();
        if DocType = DocType2 then
            exit(true);
    end;


    [IntegrationEvent(false, false)]
    local procedure onAfterGetKeyFields(TableId: Integer; var field_No: array[10] of Integer; handled: Boolean)
    begin
    end;


    [IntegrationEvent(false, false)]
    local procedure OnAfterGetType(TableId: Integer; var handled: Boolean; var Result: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignFieldNos(Number: Integer; var DocType_FieldNo: Integer; var DocNo_FieldNo: Integer; var LineNo_FieldNo: Integer; var handled: Boolean)
    begin
    end;


}
