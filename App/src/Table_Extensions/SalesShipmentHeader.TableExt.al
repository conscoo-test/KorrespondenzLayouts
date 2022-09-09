tableextension 5272737 "lbt Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        field(5272720; "lbt cl Delivery Date Type"; Enum "lbt cl DeliveryDateTime")
        {
            Caption = 'Delivery Date Type';
            DataClassification = CustomerContent;
        }
    }

    trigger OnInsert()
    var
        SalesShipmentLine: Record "Sales Shipment Line";
        LeBitCorrespDocSingleInst: Codeunit "lbt Corresp. Doc. SingleInst";
    begin
        LeBitCorrespDocSingleInst.CopyLongTextForPostCombineSalesOrderShipment(Rec, SalesShipmentLine, 1, 0);
    end;
}