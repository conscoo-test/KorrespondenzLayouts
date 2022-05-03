tableextension 50757 "lbt cl Sales Cr.Memo Header" extends "Sales Cr.Memo Header"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnDelete()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(Rec);
        EditorHelper.deleteLongText(Rec);
    end;

    procedure lbtHasEditorValue(Position: Enum "lbt Position") Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValue(Rec, Position)));
    end;

    procedure lbtEditData(Position: Enum "lbt Position")
    begin
        EditorHelper.editData(Rec, Position);
    end;
}
