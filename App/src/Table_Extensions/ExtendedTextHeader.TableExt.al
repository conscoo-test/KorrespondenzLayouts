tableextension 50726 "lbt Extended Text Header" extends "Extended Text Header"
{
    fields
    {
        field(5272720; "lbt Textchoice"; Option)
        {
            Caption = 'Textchoice';
            OptionCaption = 'Standard,Longtext,Blob';
            OptionMembers = standard,"long text","Blob";
            DataClassification = CustomerContent;
        }
        field(5272721; "lbt Editor Blob"; blob)
        {
            caption = 'Editor Blob';
            DataClassification = CustomerContent;
        }
    }
    trigger OnRename()
    var
        ExtTextLineLongOld: Record "lbt Extended Text Line Long";
        ExtTextLineLongNew: Record "lbt Extended Text Line Long";
    begin
        ExtTextLineLongOld.SetRange(Table_ID, Rec."Table Name");
        ExtTextLineLongOld.SetRange("No.", Rec."No.");
        ExtTextLineLongOld.SetRange("Language Code", xRec."Language Code");
        ExtTextLineLongOld.SetRange("Text No.", xRec."Text No.");
        if ExtTextLineLongOld.FindSet() then
            repeat
                ExtTextLineLongNew := ExtTextLineLongOld;
                ExtTextLineLongNew."Text No." := Rec."Text No.";
                ExtTextLineLongNew."Language Code" := Rec."Language Code";
                ExtTextLineLongNew.Insert();
            until ExtTextLineLongOld.Next() = 0;

        ExtTextLineLongOld.DeleteAll();
    end;

    procedure lbtclEditData()
    var
        data: text;
        EditorHelper: Codeunit "lbt cl EditorHelper";
    begin
        data := lbtclReadContentData(false);
        if editorhelper.TextEditor(data, true) then begin
            lbtclWriteContentData(data);
            modify();
        end;

    end;

    procedure lbtclReadContentData(show: Boolean) Result: text
    var

        EditorPreview: Page "lbt cl Editor Preview";
        is: instream;

    begin
        CalcFields("lbt Editor Blob");
        "lbt editor Blob".CreateInStream(is, TextEncoding::UTF8);
        is.Read(result);
        if show then begin
            EditorPreview.SetData(result);
            EditorPreview.run();
        end;
    end;

    procedure lbtclWriteContentData(content: text)
    var
        os: OutStream;

    begin
        "lbt Editor Blob".CreateOutStream(os, TextEncoding::UTF8);
        os.write(content);
    end;

}

