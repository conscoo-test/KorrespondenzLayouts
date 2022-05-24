tableextension 5272763 "lbt cl StandardSalesLine" extends "Standard Sales Line"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue() Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValueSysid(Rec, Enum::"lbt Position"::EditorLine, 0));
    end;

    procedure lbtEditData()
    var

    begin
        EditorHelper.editDataSysId(Rec, Enum::"lbt Position"::EditorLine, 0);
    end;

    procedure lbtGetPrintData(Position: enum "lbt Position"): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, 0));
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(Rec, 0);
    end;
}

