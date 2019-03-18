tableextension 5272728 "LBT Sales Header" extends "Sales Header"
{
    fields
    {
    }

    trigger OnDelete()
    var
        SourceRecRef: RecordRef;
        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
    begin
        SourceRecRef.GETTABLE(Rec);
        LeBitLongtextMgt.DelLongtext(SourceRecRef);
    end;

    procedure LeBitTransferPSLongtextLineToTemp(var LeBitPSLongtextLine: Record "LBT PS Longtext Line"; var TempLeBitPSLongtextLine: Record "LBT PS Longtext Line" temporary)
    begin
        if LeBitPSLongtextLine.FINDSET then
            repeat
                TempLeBitPSLongtextLine.INIT;
                TempLeBitPSLongtextLine := LeBitPSLongtextLine;
                TempLeBitPSLongtextLine.INSERT;
            until LeBitPSLongtextLine.NEXT = 0;
        LeBitPSLongtextLine.DELETEALL;
    end;
}

