tableextension 5272739 "lbt Sales Header Archive" extends "Sales Header Archive"
{
    trigger OnDelete()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(Rec);
    end;
}