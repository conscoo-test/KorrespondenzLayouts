tableextension 5272730 "lbt Purchase Header" extends "Purchase Header"
{
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnDelete()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(Rec);
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(Rec, Rec."Document Type".AsInteger());
    end;

    procedure lbtEditData(Position: Enum "lbt Position"; docType: Integer)
    begin
        EditorHelper.editData(Rec, Position, docType);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, docType));
    end;

    procedure lbtHasEditorValue(Position: Enum "lbt Position"; docType: Integer) Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValue(Rec, Position, docType)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;

    procedure lbtTransferPSLongtextLineToTemp(var LeBitPSLongtextLine: Record "lbt PS Longtext Line"; var TempLeBitPSLongtextLine: Record "lbt PS Longtext Line" temporary)
    begin
        if LeBitPSLongtextLine.FindSet() then
            repeat
                TempLeBitPSLongtextLine.Init();
                TempLeBitPSLongtextLine := LeBitPSLongtextLine;
                TempLeBitPSLongtextLine.Insert();
            until LeBitPSLongtextLine.Next() = 0;
        LeBitPSLongtextLine.DeleteAll();
    end;

    [IntegrationEvent(false, false)]
    procedure lbtOnAfterCreatePurchLine(var PurchaseLine: Record "Purchase Line"; var TempPurchaseLine: Record "Purchase Line" temporary)
    begin
    end;
}
