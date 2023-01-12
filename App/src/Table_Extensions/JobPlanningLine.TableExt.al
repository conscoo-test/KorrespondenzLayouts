tableextension 5272760 "lbt cl JobPlanningLine" extends "Job Planning Line"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongTextSysId(Rec);
    end;

    procedure lbtEditData()
    begin
        EditorHelper.editDataSysId(Rec, Enum::"lbt Position"::EditorLine, 0);
    end;

    procedure lbtGetPrintData(): Text
    begin
        exit(EditorHelper.getPrintDataSysId(Rec, Enum::"lbt Position"::EditorLine, 0));
    end;

    procedure lbtHasEditorValue() Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValueSysId(Rec, Enum::"lbt Position"::EditorLine, 0)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;
}
