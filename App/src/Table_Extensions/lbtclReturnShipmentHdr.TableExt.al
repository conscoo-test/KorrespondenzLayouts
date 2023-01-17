tableextension 5272771 "lbtcl ReturnShipmentHdr" extends "Return Shipment Header"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtEditData(Position: Enum "lbt Position")
    begin
        EditorHelper.ShowData(Rec, Position);
    end;

    procedure lbtHasEditorValue(Position: Enum "lbt Position") Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValue(Rec, Position)));
    end;
}
