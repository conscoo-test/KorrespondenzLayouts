codeunit 5272727 "LBT AssistedSetup"
{

    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnRegisterAssistedSetup', '', true, true)]
    local procedure AggregatedSetup_OnRegisterAssistedSetup(var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup" temporary)
    var
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get();
        TempAggregatedAssistedSetup.AddExtensionAssistedSetup(
            Page::"LBT Wizard",
            SetupLbl,
            true,
            CompanyInformation.RecordId(),
            GetSetupStatus(),
            '');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnUpdateAssistedSetupStatus', '', true, true)]
    local procedure AggregatedSetup_OnUpdateAssistedSetupStatus(var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup")
    begin
        if TempAggregatedAssistedSetup."Page ID" <> Page::"LBT Wizard" then
            exit;
        TempAggregatedAssistedSetup.Status := GetSetupStatus();
        TempAggregatedAssistedSetup.Modify();
    end;

    procedure HandleNotification(Note: Notification)
    var
        AggregatedAssistedSetup: Record "Aggregated Assisted Setup";
    begin
        if GetSetupStatus() <> AggregatedAssistedSetup.Status::Completed then
            Page.Run(Page::"LBT Wizard");
    end;

    procedure IsComplete(): Boolean
    var
        AggregatedAssistedSetup: Record "Aggregated Assisted Setup";
    begin
        exit(GetSetupStatus() = AggregatedAssistedSetup.Status::Completed);
    end;

    local procedure GetSetupStatus(): Integer
    var
        CompanyInformation: Record "Company Information";
        AggregatedAssistedSetup: Record "Aggregated Assisted Setup";
    begin
        with AggregatedAssistedSetup do begin
            if CompanyInformation.Get() then
                if CompanyInformation."LBT Setup finished" then
                    exit(Status::"Completed");
            exit(Status::"Not Completed");
        end;
    end;

    var
        SetupLbl: Label 'Setup LIS365', Comment = 'DEU="LIS365-Belegset einrichten"';
}