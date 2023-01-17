tableextension 5272755 "lbt cl ServiceContractTemplate" extends "Service Contract Template"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(Rec, 0);
    end;

    procedure lbtEditData(Position: Enum "lbt Position")
    begin
        EditorHelper.editData(Rec, Position, 0);
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
