tableextension 5272768 "lbt cl Ship-To-Address" extends "Ship-to Address"
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
    trigger OnAfterDelete()
    var
        PSLongtextSystemId: Record "lbt clPSLongtextSystemId";
    begin
        PSLongtextSystemId.SetRange("Table Id", Database::"Ship-to Address");
        PSLongtextSystemId.SetRange("Source System Id", Rec.SystemId);
        PSLongtextSystemId.DeleteAll();
    end;
}
