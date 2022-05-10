tableextension 5272754 "lbt cl ServiceContractHeader" extends "Service Contract Header"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue(Position: enum "lbt Position"; docType: integer) Result: text
    begin
        exit(format(EditorHelper.hasEditorValue(rec, Position, docType)));
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
        EditorHelper.deleteLongText(rec, rec."Contract Type".AsInteger());
    end;
}
