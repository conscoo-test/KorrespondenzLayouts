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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Role Center Notification Mgt.", 'OnBeforeShowNotifications', '', true, true)]
    local procedure MyProcedure()

    begin
        if not IsComplete() then
            CreateNotification();
    end;

    local procedure CreateNotification()
    var
        Note: Notification;
    begin
        Note.Id := GetNotificationId();
        Note.Message(NotificationMsg);
        Note.Scope := NotificationScope::LocalScope;
        Note.AddAction(ActionMsg, Codeunit::"LBT AssistedSetup", 'HandleNotification');
        Note.Send();
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

    local procedure GetNotificationId(): Guid
    var
        NotificationId: Guid;
    begin
        Evaluate(NotificationId, NotificationIdTxt);
        exit(NotificationId);
    end;

    var
        SetupLbl: Label 'Setup LIS365', Comment = 'DEU="LIS365-Belegset einrichten"';
        NotificationIdTxt: Label 'e6947c77-ec45-40c2-8c7e-01295de6efe4';
        NotificationMsg: Label 'The setup for LIS365 Reports is incomplete', Comment = 'DEU="Die Einrichtung für LIS365-Belege ist unvollständig."';
        ActionMsg: Label 'To Wizard...', Comment = 'DEU="Zum Wizard..."';
}