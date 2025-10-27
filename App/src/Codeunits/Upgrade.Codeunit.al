codeunit 5272726 "lbt Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    begin
        ServiceOrderDocType();
    end;

    local procedure ServiceOrderDocType()
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
        PSLongtextLine2: Record "lbt PS Longtext Line";
        UpgradeTag: Codeunit "Upgrade Tag";

    begin
        if UpgradeTag.HasUpgradeTag(ServiceOrderDocTypeLbl) then
            exit;

        PSLongtextLine.SetRange("Table ID", Database::"Service Header");
        PSLongtextLine.SetRange("Document Type", 11);
        if PSLongtextLine.FindSet() then
            repeat
                PSLongtextLine2.GetBySystemId(PSLongtextLine.SystemId);
                PSLongtextLine2.Rename(
                    PSLongtextLine."Table ID",
                    PSLongtextLine."Document Type"::"lbt cl Shipment/Receipt",
                    PSLongtextLine."Document No.",
                    PSLongtextLine.Position,
                    PSLongtextLine."Document Line No.",
                    PSLongtextLine."Line No.");
            until PSLongtextLine.Next() = 0;

        PSLongtextLine.SetRange("Document Type", 12);
        if PSLongtextLine.FindSet() then
            repeat
                PSLongtextLine2.GetBySystemId(PSLongtextLine.SystemId);
                PSLongtextLine2.Rename(
                    PSLongtextLine."Table ID",
                    PSLongtextLine."Document Type"::Invoice,
                    PSLongtextLine."Document No.",
                    PSLongtextLine.Position,
                    PSLongtextLine."Document Line No.",
                    PSLongtextLine."Line No.");
            until PSLongtextLine.Next() = 0;

        UpgradeTag.SetUpgradeTag(ServiceOrderDocTypeLbl);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
    local procedure OnGetPerCompanyUpgradeTags(var PerCompanyUpgradeTags: List of [Code[250]])
    begin
        PerCompanyUpgradeTags.Add(ServiceOrderDocTypeLbl);
    end;


    var
        ServiceOrderDocTypeLbl: Label 'lbt-ServiceOrderDocType-20251014', Locked = true;
}