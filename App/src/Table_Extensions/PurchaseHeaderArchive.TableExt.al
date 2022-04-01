tableextension 50740 "lbt Purchase Header Archive" extends "Purchase Header Archive"
{
    trigger OnDelete()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(Rec);
    end;
}