tableextension 5272769 "lbt cl Customer" extends Customer
{
    fields
    {
        field(5272720; "lbt cl Delivery Date Type"; Enum "lbt cl DeliveryDateTime")
        {
            Caption = 'Delivery Date Type';
            DataClassification = CustomerContent;
        }
        field(5272721; "lbt cl No. Shipm. Note Copies"; Integer)
        {
            Caption = 'No. of Shipment note Copies';
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(5272722; "lbt cl Destination"; Code[10])
        {
            Caption = 'Destination';
            DataClassification = CustomerContent;
            TableRelation = "Entry/Exit Point";
        }
    }
}
