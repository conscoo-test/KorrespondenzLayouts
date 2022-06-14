table 5272720 "lbt PS Longtext Line"
{
    // version LBCOR1.00

    Caption = 'Purch/Sales Longtext Line';
    DrillDownPageID = "lbt PS Longtext Lines";
    LookupPageID = "lbt PS Longtext Lines";
    PasteIsValid = false;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            DataClassification = CustomerContent;
        }
        field(2; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            NotBlank = true;
            TableRelation = if ("Table ID" = const(36)) "Sales Header"."No." where("Document Type" = field("Document Type"))
            else
            if ("Table ID" = const(37)) "Sales Line"."Document No." where("Document Type" = field("Document Type"))
            else
            if ("Table ID" = const(38)) "Purchase Header"."No." where("Document Type" = field("Document Type"))
            else
            if ("Table ID" = const(39)) "Purchase Line"."Document No." where("Document Type" = field("Document Type"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(4; Position; Enum "lbt Position")
        {
            Caption = 'Position';
            DataClassification = CustomerContent;
        }
        // field(4; Position; Option)
        // {
        //     Caption = 'Position';
        //     OptionCaption = 'Header,Footer,Longtext,EditorHeader,EditorFooter,EditorLine';
        //     OptionMembers = Header,Footer,Longtext,EditorHeader,EditorFooter,EditorLine;
        //     DataClassification = CustomerContent;
        // }
        field(5; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            TableRelation = if ("Table ID" = const(37)) "Sales Line"."Line No." where("Document Type" = field("Document Type"),
                                                                                     "Document No." = field("Document No."))
            else
            if ("Table ID" = const(39)) "Purchase Line"."Line No." where("Document Type" = field("Document Type"),
                                                                                                                                                      "Document No." = field("Document No."));
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Text,New Page,Text + Line break';
            OptionMembers = Text,"New Page","Text + Line break";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                case Type of
                    Type::Text,
                  Type::"Text + Line break":
                        if xRec.Type = xRec.Type::"New Page" then begin
                            "No." := '';
                            Description := '';
                        end;
                    Type::"New Page":
                        begin
                            "No." := '';
                            Description := NewPageLbl;
                        end;
                end;
            end;
        }
        field(11; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Text)) "Standard Text";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                case Type of
                    Type::Text,
                    Type::"Text + Line break":
                        begin
                            StandardText.Get("No.");
                            Description := StandardText.Description;
                        end;
                end;
            end;
        }
        field(12; Description; Text[120])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Type = Type::"New Page" then
                    Error(CantChangeTxt);
                if Description = '' then
                    Type := Type::Text;
            end;
        }
        field(13; "Text"; Blob)
        {
            Caption = 'Text';
            DataClassification = CustomerContent;
        }

        field(21; "Editor Content"; Blob)
        {
            caption = 'Editor Content';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        if Description = '' then
            Type := Type::Text;
    end;

    var
        StandardText: Record "Standard Text";
        NewPageLbl: Label '--- New Page ---';
        CantChangeTxt: Label 'You can not change this text.'; //TODO: ??

    procedure DBOpenMemo()
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
        TempPSLongtextLine: Record "lbt PS Longtext Line" temporary;
        DBTextEdit: Page "lbt DBTextEdit";
        Txt: Text;
        delimiter: Text;
        LineNo: Integer;
        filled: Boolean;
    begin
        if "Document No." = '' then begin
            PSLongtextLine.SetFilter("Table ID", Rec.GetFilter("Table ID"));
            PSLongtextLine.SetFilter("Document Type", Rec.GetFilter("Document Type"));
            PSLongtextLine.SetFilter("Document No.", Rec.GetFilter("Document No."));
            PSLongtextLine.SetFilter(Position, Rec.GetFilter(Position));
            PSLongtextLine.SetFilter("Document Line No.", Rec.GetFilter("Document Line No."));
        end else begin
            PSLongtextLine.SetRange("Table ID", "Table ID");
            PSLongtextLine.SetRange("Document Type", "Document Type");
            PSLongtextLine.SetRange("Document No.", "Document No.");
            PSLongtextLine.SetRange(Position, Position);
            PSLongtextLine.SetRange("Document Line No.", "Document Line No.");
        end;

        delimiter[1] := 13;
        delimiter[2] := 10;

        if PSLongtextLine.FindSet() then
            repeat
                case PSLongtextLine.Type of
                    PSLongtextLine.Type::"Text + Line break":
                        Txt += (PSLongtextLine.Description + delimiter);
                    else
                        Txt += PSLongtextLine.Description;
                end;
            until PSLongtextLine.Next() = 0;

        DBTextEdit.SetText(Txt);

        if DBTextEdit.RunModal() = Action::OK then begin
            PSLongtextLine.DeleteAll();
            Txt := DBTextEdit.GetText();
            Clear(delimiter);
            SplitText(Txt, delimiter, TempPSLongtextLine, 120);
            if TempPSLongtextLine.FindSet() then
                repeat
                    if TempPSLongtextLine.Description <> '' then
                        filled := true;

                until TempPSLongtextLine.Next() = 0;
            if filled then begin
                if TempPSLongtextLine.FindSet() then
                    repeat
                        LineNo += 10000;
                        PSLongtextLine.Init();
                        Evaluate(PSLongtextLine."Table ID", Rec.GetFilter("Table ID"));
                        Evaluate(PSLongtextLine."Document Type", Rec.GetFilter("Document Type"));
                        PSLongtextLine."Document No." := CopyStr(Rec.GetFilter("Document No."), 1, 20);
                        Evaluate(PSLongtextLine.Position, GetFilter(Position));
                        Evaluate(PSLongtextLine."Document Line No.", Rec.GetFilter("Document Line No."));

                        PSLongtextLine.Description := TempPSLongtextLine.Description;
                        PSLongtextLine."Line No." := LineNo;
                        PSLongtextLine.Type := TempPSLongtextLine.Type;
                        PSLongtextLine.Insert();
                    until TempPSLongtextLine.Next() = 0;
                if PSLongtextLine.Type <> PSLongtextLine.Type::"New Page" then begin
                    PSLongtextLine.Type := PSLongtextLine.Type::Text;
                    PSLongtextLine.Modify();
                end;
            end;
        end;

    end;

    local procedure SplitText(Text: Text; Delimiter: Text; var PSLongtextLine: Record "lbt PS Longtext Line"; maxlen: Integer)
    var
        NewString: Text;
        SplitArray: List of [Text];
        ende: Boolean;
        newstring1: Text;
        LineNo: Integer;
        NewLen: Integer;
        TestString: Text;
    begin
        SplitArray := Text.Split(Delimiter);
        foreach NewString in Text.Split(Delimiter) do begin
            NewString := NewString.Trim();
            ende := false;
            repeat
                LineNo += 1;
                PSLongtextLine.Init();
                PSLongtextLine."Line No." := LineNo;
                if StrLen(NewString) > maxlen then begin
                    NewLen := maxlen;
                    TestString := NewString;
                    while (not (TestString[NewLen] in [' ', '.', '!', '?', ';', ',', ':', '"'])) and (NewLen <> 1) do
                        NewLen -= 1;
                    if NewLen = 1 then
                        NewLen := maxlen;
                    newstring1 := CopyStr(NewString, 1, NewLen);
                    PSLongtextLine.Description := CopyStr(newstring1, 1, 120);
                    NewString := CopyStr(NewString, NewLen + 1);
                end else begin
                    PSLongtextLine.Description := CopyStr(NewString, 1, 120);
                    PSLongtextLine.Type := PSLongtextLine.Type::"Text + Line break";
                    ende := true;
                end;
                PSLongtextLine.Insert();
            until ende;
        end;
    end;

    procedure EditData()
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";
        data: Text;
    begin
        data := ReadContentData(false);
        if not EditorHelper.TextEditor(data, true) then
            exit;
        if (data = '<p><br></p>') or (data = '<p></p>') then
            Delete(true)
        else begin
            WriteContentData(data);
            Modify();
        end;

    end;

    procedure ShowData()
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";
        data: Text;
    begin
        data := ReadContentData(false);
        editorhelper.ShowTextEditor(data, true);

    end;


    procedure ReadContentData(show: Boolean) Result: Text
    var
        EditorPreview: Page "lbt cl Editor Preview";
        Buffer: Text;
        is: InStream;
    begin
        CalcFields("Editor Content");
        "Editor Content".CreateInStream(is, TextEncoding::UTF8);
        while not is.EOS do begin
            is.Read(Buffer);
            Result += Buffer;
        end;
        if show then begin
            EditorPreview.SetData(Result);
            EditorPreview.Run();
        end;
    end;

    procedure WriteContentData(content: Text)
    var
        os: OutStream;
    begin
        Clear(Rec."Editor Content");
        "Editor Content".CreateOutStream(os, TextEncoding::UTF8);
        os.Write(content);
    end;

}

