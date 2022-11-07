tableextension 5272746 "lbt cl ServiceCRmemoLine" extends "Service Cr.Memo Line"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue() Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(rec, Enum::"lbt Position"::EditorLine, 0));
    end;

    procedure lbtEditData()
    var

    begin
        EditorHelper.ShowData(rec, Enum::"lbt Position"::EditorLine, 0);
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(rec, 0);
    end;
}
