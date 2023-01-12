tableextension 5272753 "lbt cl ServiceCRMemoHeader" extends "Service Cr.Memo Header"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(Rec, 0);
    end;

    procedure lbtEditData(Position: Enum "lbt Position")
    begin
        EditorHelper.ShowData(Rec, Position, 0);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, 0));
    end;

    procedure lbtHasEditorValue(Position: Enum "lbt Position") Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValue(Rec, Position, 0)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;
}
