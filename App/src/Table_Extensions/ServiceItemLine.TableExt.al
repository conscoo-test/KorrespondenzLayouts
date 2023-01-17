tableextension 5272743 "lbt cl ServiceItemLine" extends "Service Item Line"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(Rec, Rec."Document Type".AsInteger());
    end;

    procedure lbtEditData(docType: Integer)
    var

    begin
        EditorHelper.editData(Rec, Enum::"lbt Position"::EditorLine, docType);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, docType));
    end;

    procedure lbtHasEditorValue(docType: Integer) Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(Rec, Enum::"lbt Position"::EditorLine, docType));
    end;
}
