tableextension 5272758 "lbt cl Pstd Whse. Ship. Header" extends "Posted Whse. Shipment Header"
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

    procedure lbtEditData(Position: Enum "lbt Position")
    begin
        EditorHelper.ShowData(Rec, Position);
    end;

    procedure lbtHasEditorValue(Position: Enum "lbt Position") Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValue(Rec, Position)));
    end;
}