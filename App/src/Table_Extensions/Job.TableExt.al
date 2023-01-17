tableextension 5272759 "lbt cl Job" extends Job
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongTextSysId(Rec);
    end;

    procedure lbtEditData(Position: Enum "lbt Position"; docType: Integer)
    begin
        EditorHelper.editDataSysId(Rec, Position, docType);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintDataSysId(Rec, Position, docType));
    end;

    procedure lbtHasEditorValue(Position: Enum "lbt Position"; docType: Integer) Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValueSysId(Rec, Position, docType)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;
}
