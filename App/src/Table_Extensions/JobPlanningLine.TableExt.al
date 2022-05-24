tableextension 5272760 "lbt cl JobPlanningLine" extends "Job Planning Line"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue() Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValueSysId(Rec, enum::"lbt Position"::EditorLine, 0)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;

    procedure lbtEditData()
    begin
        EditorHelper.editDataSysId(Rec, enum::"lbt Position"::EditorLine, 0);
    end;

    procedure lbtGetPrintData(): Text
    begin
        exit(EditorHelper.getPrintDataSysid(Rec, enum::"lbt Position"::EditorLine, 0));
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongTextSysId(Rec);
    end;

}
