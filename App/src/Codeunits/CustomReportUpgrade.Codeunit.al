codeunit 5272733 "lbt cl CustomReport Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
    begin
        if UpgradeTag.HasUpgradeTag(CustomReportLbl) then exit;

        PerformUpgrade();

        UpgradeTag.SetUpgradeTag(CustomReportLbl);
    end;

    local procedure PerformUpgrade()
    var
        LongtextSystemId: Record "lbt clPSLongtextSystemId";
        CustomReportSelection: Record "Custom Report Selection";
        Customer: Record Customer;
        Vendor: Record Vendor;
        ShiptoAddress: Record "Ship-to Address";
    begin
        LongtextSystemId.SetRange("Table Id", Database::"Custom Report Selection");
        if LongtextSystemId.FindSet() then
            repeat
                CustomReportSelection.GetBySystemId(LongtextSystemId."Source System Id");
                case CustomReportSelection."Source Type" of
                    database::Customer:
                        if Customer.Get(CustomReportSelection."Source No.") then
                            LongtextSystemId.Rename(Database::Customer, Customer.SystemId, LongtextSystemId."Document Type", LongtextSystemId.Position);
                    database::Vendor:
                        if Vendor.Get(CustomReportSelection."Source No.") then
                            LongtextSystemId.Rename(Database::Vendor, Vendor.SystemId, LongtextSystemId."Document Type", LongtextSystemId.Position);
                    database::"Ship-to Address":
                        if ShiptoAddress.Get(CustomReportSelection."Source No.") then
                            LongtextSystemId.Rename(Database::"Ship-to Address", ShiptoAddress.SystemId, LongtextSystemId."Document Type", LongtextSystemId.Position);
                end;
            until LongtextSystemId.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
    local procedure OnGetPerCompanyUpgradeTags(var PerCompanyUpgradeTags: List of [Code[250]]);
    begin
        PerCompanyUpgradeTags.Add(CustomReportLbl);
    end;

    var
        CustomReportLbl: Label 'LbtCl-CustomReport-20230117', Locked = true;
}