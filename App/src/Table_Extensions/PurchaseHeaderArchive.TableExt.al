tableextension 5272740 "lbt Purchase Header Archive" extends "Purchase Header Archive"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnDelete()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(Rec);
    end;

    procedure lbtHasEditorValue(Position: enum "lbt Position"; docType: Integer) Result: Text
    begin
        exit(format(EditorHelper.hasEditorValue(rec, Position, doctype)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;

    procedure lbtEditData(Position: enum "lbt Position"; docType: Integer)
    begin
        EditorHelper.editData(rec, Position, docType);
    end;

}