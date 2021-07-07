tableextension 5272730 "lbt Purchase Header" extends "Purchase Header"
{
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
}

