tableextension 5272738 "lbt Purch. Rcpt. Header" extends "Purch. Rcpt. Header"
{
    fields
    {
    }
    trigger OnInsert()
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        LeBitCorrespDocSingleInst: Codeunit "lbt Corresp. Doc. SingleInst";
    begin
        LeBitCorrespDocSingleInst.CopyLongTextForPostDropOrderShipment(Rec, PurchRcptLine, 1, 0);
    end;
}