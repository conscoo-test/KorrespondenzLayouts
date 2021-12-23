tableextension 50754 "lbt cl SeviceContractHeader" extends "Service Contract Header"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue(Position: enum "lbt Position") Result: text
    begin
        exit(format(EditorHelper.hasEditorValue(rec, Position, 0)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;

    procedure lbtEditData(Position: enum "lbt Position")
    begin
        EditorHelper.editData(rec, Position, 0);
    end;

    procedure lbtGetPrintData(Position: enum "lbt Position"): Text
    begin
        exit(EditorHelper.getPrintData(rec, Position, 0));
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(rec, 0);
    end;
}
