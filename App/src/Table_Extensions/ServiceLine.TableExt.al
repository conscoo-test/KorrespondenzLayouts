tableextension 50744 "lbt cl ServiceLine" extends "Service Line"
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
        EditorHelper.deleteLongText(rec, rec."Document Type".AsInteger());
    end;

    procedure lbtGetPrintData(Position: enum "lbt Position"; docType: integer): Text
    begin
        exit(EditorHelper.getPrintData(rec, Position, docType));
    end;


}
