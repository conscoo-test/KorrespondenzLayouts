table 50721 "lbt Posted PS Longtext Line"
{
    // version LBCOR1.00

    Caption = 'Posted Purch/Sales Longtext Line';
    DrillDownPageID = "lbt Posted PS Longtext Lines";
    LookupPageID = "lbt Posted PS Longtext Lines";
    PasteIsValid = false;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            NotBlank = true;
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
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
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
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
        }
        field(11; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = const(Text)) "Standard Text";
            DataClassification = CustomerContent;
        }
        field(12; Description; Text[120])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(13; "Text"; BLOB)
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
        key(Key1; "Table ID", "Document No.", Position, "Document Line No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
    procedure EditData()
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";
        data: Text;
    begin
        data := ReadContentData(false);
        if not editorhelper.TextEditor(data, true) then
            exit;
        if (data = '<p><br></p>') or (data = '<p></p>') then
            delete(true)
        else begin
            WriteContentData(data);
            modify();
        end;

    end;

    procedure ReadContentData(show: Boolean) Result: Text
    var
        EditorPreview: Page "lbt cl Editor Preview";
        Buffer: Text;
        is: instream;
    begin
        CalcFields("Editor Content");
        "editor content".CreateInStream(is, TextEncoding::UTF8);
        while not is.EOS do begin
            is.Read(Buffer);
            Result += Buffer;
        end;
        if show then begin
            EditorPreview.SetData(result);
            EditorPreview.Run();
        end;
    end;

    procedure WriteContentData(content: Text)
    var
        os: OutStream;
    begin
        Clear(Rec."Editor Content");
        "Editor Content".CreateOutStream(os, TextEncoding::UTF8);
        os.write(content);
    end;
}

