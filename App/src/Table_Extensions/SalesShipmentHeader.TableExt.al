tableextension 50737 "lbt Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
    }

    trigger OnInsert()
    var
        SalesShipmentLine: Record "Sales Shipment Line";
        LeBitCorrespDocSingleInst: Codeunit "lbt Corresp. Doc. SingleInst";
    begin
        LeBitCorrespDocSingleInst.CopyLongTextForPostCombineSalesOrderShipment(Rec, SalesShipmentLine, 1, 0);
    end;
}