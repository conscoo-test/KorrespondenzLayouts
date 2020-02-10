tableextension 5272728 "lbt Sales Header" extends "Sales Header"
{
    fields
    {
    }

    trigger OnDelete()
    var
        LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
        SourceRecRef: RecordRef;
    begin
        SourceRecRef.GETTABLE(Rec);
        LeBitLongtextMgt.DelLongtext(SourceRecRef);
    end;

    procedure LeBitTransferPSLongtextLineToTemp(var LeBitPSLongtextLine: Record "lbt PS Longtext Line"; var TempLeBitPSLongtextLine: Record "lbt PS Longtext Line" temporary)
    begin
        if LeBitPSLongtextLine.FindSet() then
            repeat
                TempLeBitPSLongtextLine.Init();
                ;
                TempLeBitPSLongtextLine := LeBitPSLongtextLine;
                TempLeBitPSLongtextLine.Insert();
            until LeBitPSLongtextLine.Next() = 0;
        LeBitPSLongtextLine.DeleteAll();
    end;
}

