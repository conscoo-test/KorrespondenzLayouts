tableextension 5272761 "lbt cl AssemblyLine" extends "Assembly Line"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtEditData(doctype: Integer)
    var

    begin
        EditorHelper.editDataSysId(Rec, Enum::"lbt Position"::EditorLine, doctype);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, docType));
    end;

    procedure lbtHasEditorValue(docType: Integer) Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValueSysId(Rec, Enum::"lbt Position"::EditorLine, docType));
    end;
}
