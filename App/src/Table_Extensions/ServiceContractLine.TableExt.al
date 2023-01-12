tableextension 5272747 "lbt cl ServiceContractLine" extends "Service Contract Line"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(Rec, Rec."Contract Type");
    end;

    procedure lbtEditData(docType: Integer)
    var

    begin
        EditorHelper.editData(Rec, Enum::"lbt Position"::EditorLine, docType);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, 0));
    end;

    procedure lbtHasEditorValue(docType: Integer) Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(Rec, Enum::"lbt Position"::EditorLine, docType));
    end;
}
