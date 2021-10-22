tableextension 5272747 "lbt cl ServiceContractLine" extends "Service Contract Line"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue() Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(rec, enum::"lbt Position"::EditorLine, 0));
    end;

    procedure lbtEditData()
    var

    begin
        EditorHelper.editData(rec, enum::"lbt Position"::EditorLine, 0);
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(rec, 0);
    end;
}
