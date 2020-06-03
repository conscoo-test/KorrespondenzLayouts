tableextension 5272739 "LBT Sales Header Archive" extends "Sales Header Archive"
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