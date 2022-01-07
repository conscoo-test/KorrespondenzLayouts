tableextension 5272754 "lbt cl SeviceContractHeader" extends "Service Contract Header"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue(Position: enum "lbt Position"; docType: integer) Result: text
    begin
        exit(format(EditorHelper.hasEditorValue(rec, Position, docType)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;

    procedure lbtEditData(Position: enum "lbt Position"; docType: integer)
    begin
        EditorHelper.editData(rec, Position, doctype);
    end;

    procedure lbtGetPrintData(Position: enum "lbt Position"; docType: integer): Text
    begin
        exit(EditorHelper.getPrintData(rec, Position, docType));
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(rec, rec."Contract Type");
    end;
}
