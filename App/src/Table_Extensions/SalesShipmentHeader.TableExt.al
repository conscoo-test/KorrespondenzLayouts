tableextension 5272737 "lbt Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        field(5272720; "lbt cl Delivery Date Type"; Enum "lbt cl DeliveryDateType")
        {
            Caption = 'Delivery Date Type';
            DataClassification = CustomerContent;
        }
        field(5272722; "lbt cl Destination"; Code[10])
        {
            Caption = 'Destination';
            DataClassification = CustomerContent;
            TableRelation = "Entry/Exit Point";
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