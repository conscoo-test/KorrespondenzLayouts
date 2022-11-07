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


    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnDelete()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(Rec);
        EditorHelper.deleteLongText(Rec);
    end;

    procedure lbtHasEditorValue(Position: Enum "lbt Position") Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValue(Rec, Position)));
    end;

    procedure lbtEditData(Position: Enum "lbt Position")
    begin
        EditorHelper.ShowData(Rec, Position);
    end;
}