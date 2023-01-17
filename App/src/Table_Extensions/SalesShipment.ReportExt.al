reportextension 5272720 "lbt cl Sales Shipment" extends "Sales - Shipment"
{
    dataset
    {
    }
    trigger OnPreReport()
    var
        Cust: Record Customer;
    begin
        if Cust.Get("Sales Shipment Header"."Sell-to Customer No.") then
            if Cust."lbt cl No. Shipm. Note Copies" <> 0 then
                InitializeRequest(Cust."lbt cl No. Shipm. Note Copies", false, false, false, false, false);
    end;
}
