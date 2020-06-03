tableextension 5272730 "LBT Purchase Header" extends "Purchase Header"
{
    fields
    {
    }

    trigger OnDelete()
    var
        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
        SourceRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(Rec);
        LeBitLongtextMgt.DelLongtext(SourceRecRef);
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCreatePurchLine(var PurchaseLine: Record "Purchase Line"; var TempPurchaseLine: Record "Purchase Line" temporary)
    begin
    end;

    procedure LeBitTransferPSLongtextLineToTemp(var LeBitPSLongtextLine: Record "LBT PS Longtext Line"; var TempLeBitPSLongtextLine: Record "LBT PS Longtext Line" temporary)
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

