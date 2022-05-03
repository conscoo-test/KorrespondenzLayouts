tableextension 50747 "lbt cl ServiceContractLine" extends "Service Contract Line"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue(docType: integer) Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(rec, enum::"lbt Position"::EditorLine, docType));
    end;

    procedure lbtEditData(docType: integer)
    var

    begin
        EditorHelper.editData(rec, enum::"lbt Position"::EditorLine, docType);
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(rec, rec."Contract Type");
    end;
}
