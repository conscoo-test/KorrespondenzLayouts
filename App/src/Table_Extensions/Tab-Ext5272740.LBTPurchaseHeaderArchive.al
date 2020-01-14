tableextension 5272740 "LBT Purchase Header Archive" extends "Purchase Header Archive"
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
}