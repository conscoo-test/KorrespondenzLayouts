tableextension 5272748 "lbt cl ServiceShipmentLine" extends "Service Shipment Line"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(Rec, 0);
    end;

    procedure lbtEditData()
    var

    begin
        EditorHelper.ShowData(Rec, Enum::"lbt Position"::EditorLine, 0);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, 0));
    end;

    procedure lbtHasEditorValue() Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(Rec, Enum::"lbt Position"::EditorLine, 0));
    end;
}
