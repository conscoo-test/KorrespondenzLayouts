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

    [IntegrationEvent(false, false)]
    procedure lbtOnAfterCreatePurchLine(var PurchaseLine: Record "Purchase Line"; var TempPurchaseLine: Record "Purchase Line" temporary)
    begin
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

    procedure lbtHasEditorValue(Position: enum "lbt Position"; docType: Integer) Result: Text
    begin
        exit(format(EditorHelper.hasEditorValue(rec, Position, doctype)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;

    procedure lbtEditData(Position: enum "lbt Position"; docType: Integer)
    begin
        EditorHelper.editData(rec, Position, docType);
    end;

    procedure lbtGetPrintData(Position: enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintData(rec, Position, docType));
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(rec, Rec."Document Type".AsInteger());
    end;

}

