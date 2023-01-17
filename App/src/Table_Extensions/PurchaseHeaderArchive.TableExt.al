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

    procedure lbtEditData(Position: Enum "lbt Position"; docType: Integer)
    begin
        EditorHelper.ShowData(Rec, Position, docType);
    end;

    procedure lbtHasEditorValue(Position: Enum "lbt Position"; docType: Integer) Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValue(Rec, Position, docType)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;
}