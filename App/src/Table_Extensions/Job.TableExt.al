tableextension 5272759 "lbt cl Job" extends Job
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue(Position: Enum "lbt Position"; docType: Integer) Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValueSysId(Rec, Position, docType)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;

    procedure lbtEditData(Position: Enum "lbt Position"; docType: Integer)
    begin
        EditorHelper.editDataSysId(Rec, Position, docType);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintDataSysid(Rec, Position, docType));
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongTextSysId(Rec);
    end;

}
