reportextension 5272720 "lbt cl Sales Shipment" extends "Sales - Shipment"
{
    dataset
    {
    }
    trigger OnPreReport()
    var
        Cust: Record Customer;
    begin
        if Cust.get("Sales Shipment Header"."Sell-to Customer No.") then
            if cust."lbt cl No. Shipm. Note Copies" <> 0 then
                InitializeRequest(cust."lbt cl No. Shipm. Note Copies", false, false, false, false, false);
    end;
}
