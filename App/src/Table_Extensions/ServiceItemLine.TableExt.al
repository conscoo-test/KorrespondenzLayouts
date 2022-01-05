tableextension 5272743 "lbt cl ServiceItemLine" extends "Service Item Line"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue(docType: Integer) Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(rec, Enum::"lbt Position"::EditorLine, doctype));
    end;

    procedure lbtEditData(docType: Integer)
    var

    begin
        EditorHelper.editData(rec, Enum::"lbt Position"::EditorLine, doctype);
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
