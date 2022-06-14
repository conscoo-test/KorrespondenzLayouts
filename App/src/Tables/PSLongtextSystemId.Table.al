table 5272727 "lbt clPSLongtextSystemId"
{
    Caption = 'PSLongtextSystemId';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Table Id"; Integer)
        {
            Caption = 'Table Id';
            DataClassification = CustomerContent;
        }
        field(2; "Source System Id"; Guid)
        {
            Caption = 'Source System Id';
            DataClassification = CustomerContent;
        }
        field(3; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(4; Position; Enum "lbt Position")
        {
            Caption = 'Position';
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
            TableRelation = if (Type = const(Text)) "Standard Text";
            DataClassification = CustomerContent;
        }
        field(12; Description; Text[120])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(21; "Editor Content"; Blob)
        {
            Caption = 'Editor Content';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Table Id", "Source System Id", "Document Type", Position)
        {
            Clustered = true;
        }
    }
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
