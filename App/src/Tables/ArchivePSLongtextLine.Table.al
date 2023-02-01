table 5272722 "lbt Archive PS Longtext Line"
{
    // version LBCOR1.00
    ObsoleteState = Pending;
    ObsoleteReason = 'Aggregate PS Longtexts in one table';

    DrillDownPageId = "lbt Arch. PS Longtext Lines";
    LookupPageId = "lbt Arch. PS Longtext Lines";
    PasteIsValid = false;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            DataClassification = CustomerContent;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Shipment/Receipt';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Shipment/Receipt";
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            NotBlank = true;
            TableRelation = if ("Table ID" = const(5107)) "Sales Header Archive"."No." where("Document Type" = field("Document Type"))
            else
            if ("Table ID" = const(5109)) "Purchase Header Archive"."No." where("Document Type" = field("Document Type"));
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
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(7; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
        }
        field(8; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
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
        field(13; "Text"; Blob)
        {
            Caption = 'Text';
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
        key(Key1; "Table ID", "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", Position, "Document Line No.", "Line No.")
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
        is: InStream;
        Buffer: Text;
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

    procedure ShowData()
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";
        data: Text;
    begin
        data := ReadContentData(false);
        EditorHelper.ShowTextEditor(data, true);
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
