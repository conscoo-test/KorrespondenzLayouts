codeunit 5272727 "LBT AssistedSetup"
{
    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnRegisterAssistedSetup', '', true, true)]
    local procedure AggregatedSetup_OnRegisterAssistedSetup(var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup" temporary)
    var
        CompanyInformation: Record "Company Information";
    begin
        TempAggregatedAssistedSetup.AddExtensionAssistedSetup(
            Page::"LBT Wizard",
            SetupLbl,
            true,
            CompanyInformation.RecordId,
            GetSetupStatus(TempAggregatedAssistedSetup),
            '');
    end;

    local procedure GetSetupStatus(AggregatedAssistedSetup: Record "Aggregated Assisted Setup"): Integer
    var
        CompanyInformation: Record "Company Information";
    begin
        with AggregatedAssistedSetup do begin
            if CompanyInformation.Get then
                if CompanyInformation."LBT Trade Register Name" <> '' then
                    exit(Status::"Completed");
            exit(Status::"Not Completed");
        end;
    end;

    var
        SetupLbl: Label 'Setup', Comment = 'DEU="Einrichtung"';
}