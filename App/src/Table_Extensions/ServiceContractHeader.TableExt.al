tableextension 5272754 "lbt cl ServiceContractHeader" extends "Service Contract Header"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue(Position: Enum "lbt Position"; docType: Integer) Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValue(Rec, Position, docType)));
    end;

    procedure lbtEditData(Position: Enum "lbt Position"; docType: Integer)
    begin
        EditorHelper.editData(Rec, Position, docType);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, docType));
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(Rec, Rec."Contract Type");
    end;
}
