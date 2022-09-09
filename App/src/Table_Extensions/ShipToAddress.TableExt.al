tableextension 5272768 "lbt cl Ship-To-Address" extends "Ship-to Address"
{
    fields
    {
        field(5272720; "lbt cl Destination"; Code[10])
        {
            Caption = 'Destination';
            DataClassification = CustomerContent;
            TableRelation = "Entry/Exit Point";
        }
    }
}
