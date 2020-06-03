tableextension 5272740 "LBT Purchase Header Archive" extends "Purchase Header Archive"
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
}