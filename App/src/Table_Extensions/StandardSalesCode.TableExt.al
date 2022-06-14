tableextension 5272762 "lbt cl StandardSalesCode" extends "Standard Sales Code"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue(Position: Enum "lbt Position") Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValueSysId(Rec, Position, 0)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;

    procedure lbtEditData(Position: Enum "lbt Position")
    begin
        EditorHelper.editDataSysId(Rec, Position, 0);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, 0));
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(Rec, 0);
    end;
}
