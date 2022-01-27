tableextension 5272750 "lbt cl ServiceHeader" extends "Service Header"
{

    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue(Position: enum "lbt Position"; docType: Integer) Result: Text
    begin
        exit(format(EditorHelper.hasEditorValue(rec, Position, doctype)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;

    procedure lbtEditData(Position: enum "lbt Position"; docType: Integer)
    begin
        EditorHelper.editData(rec, Position, docType);
    end;

    procedure lbtGetPrintData(Position: enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintData(rec, Position, docType));
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(rec, Rec."Document Type".AsInteger());
    end;
}
