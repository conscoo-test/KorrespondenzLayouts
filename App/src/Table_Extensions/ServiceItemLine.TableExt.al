tableextension 5272743 "lbt cl ServiceItemLine" extends "Service Item Line"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue(docType: integer) Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(rec, enum::"lbt Position"::EditorLine, doctype));
    end;

    procedure lbtEditData(docType: integer)
    var

    begin
        EditorHelper.editData(rec, enum::"lbt Position"::EditorLine, doctype);
    end;

    procedure lbtGetPrintData(Position: enum "lbt Position"; docType: integer): Text
    begin
        exit(EditorHelper.getPrintData(rec, Position, docType));
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(rec, rec."Document Type".AsInteger());
    end;
}
