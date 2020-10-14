tableextension 5272728 "lbt Sales Header" extends "Sales Header"
{
    trigger OnDelete()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(Rec);
    end;

    procedure lbtTransferPSLongtextLineToTemp(var PSLongtextLine: Record "lbt PS Longtext Line"; var TempPSLongtextLine: Record "lbt PS Longtext Line" temporary)
    begin
        if PSLongtextLine.FindSet() then
            repeat
                TempPSLongtextLine.Init();
                TempPSLongtextLine := PSLongtextLine;
                TempPSLongtextLine.Insert();
            until PSLongtextLine.Next() = 0;
        PSLongtextLine.DeleteAll();
    end;
}

