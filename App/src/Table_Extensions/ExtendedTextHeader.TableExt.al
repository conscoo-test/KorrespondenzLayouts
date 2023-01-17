tableextension 5272726 "lbt Extended Text Header" extends "Extended Text Header"
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
        field(5272721; "lbt Editor Blob"; Blob)
        {
            Caption = 'Editor Blob';
            DataClassification = CustomerContent;
        }
    }
    trigger OnRename()
    var
        ExtTextLineLongNew: Record "lbt Extended Text Line Long";
        ExtTextLineLongOld: Record "lbt Extended Text Line Long";
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
        EditorHelper: Codeunit "lbt cl EditorHelper";
        data: Text;
    begin
        data := lbtclReadContentData(false);
        if EditorHelper.TextEditor(data, true) then begin
            lbtclWriteContentData(data);
            Modify();
        end;
    end;

    procedure lbtclReadContentData(show: Boolean) Result: Text
    var

        EditorPreview: Page "lbt cl Editor Preview";
        is: InStream;

    begin
        CalcFields("lbt Editor Blob");
        "lbt Editor Blob".CreateInStream(is, TextEncoding::UTF8);
        is.Read(Result);
        if show then begin
            EditorPreview.SetData(Result);
            EditorPreview.Run();
        end;
    end;

    procedure lbtclWriteContentData(content: Text)
    var
        os: OutStream;

    begin
        "lbt Editor Blob".CreateOutStream(os, TextEncoding::UTF8);
        os.Write(content);
    end;
}
