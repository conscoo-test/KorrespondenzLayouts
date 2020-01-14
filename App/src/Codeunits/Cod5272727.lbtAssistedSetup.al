codeunit 5272727 "lbt AssistedSetup"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assisted Setup", 'OnRegister', '', true, true)]
    // [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnRegisterAssistedSetup', '', true, true)]
    local procedure AggregatedSetup_OnRegisterAssistedSetup()
    var
        AssistedSetup: Codeunit "Assisted Setup";
        AssistedSetupGroup: Enum "Assisted Setup Group";
    // CurrentGlobalLanguage: Integer;
    begin
        // CurrentGlobalLanguage := GlobalLanguage();
        AssistedSetup.Add(GetAppId(), Page::"LBT Wizard", SetupLbl, AssistedSetupGroup::Extensions);
        // GlobalLanguage(1033);
        // AssistedSetup.AddTranslation(ExtensionGuidTxt, Page::"LBT Wizard", 1033, SetupLbl);
        // GlobalLanguage(CurrentGlobalLanguage);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Role Center Notification Mgt.", 'OnBeforeShowNotifications', '', true, true)]
    local procedure MyProcedure()
    var
        AssistedSetup: Codeunit "Assisted Setup";
    begin
        if not AssistedSetup.IsComplete(GetAppId(), Page::"LBT Wizard") then
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
        AssistedSetup: Codeunit "Assisted Setup";
    begin
        if AssistedSetup.ExistsAndIsNotComplete(GetAppId(), Page::"LBT Wizard") then
            AssistedSetup.Run(GetAppId(), Page::"LBT Wizard");
    end;

    local procedure GetNotificationId(): Guid
    var
        NotificationId: Guid;
    begin
        Evaluate(NotificationId, NotificationIdTxt);
        exit(NotificationId);
    end;

    procedure GetAppId(): Text
    begin
        exit(ExtensionGuidTxt);
    end;

    var
        SetupLbl: Label 'Setup LIS365', Comment = 'DEU="LIS365-Belegset einrichten"';
        NotificationIdTxt: Label 'e6947c77-ec45-40c2-8c7e-01295de6efe4';
        NotificationMsg: Label 'The setup for LIS365 Reports is incomplete', Comment = 'DEU="Die Einrichtung für LIS365-Belege ist unvollständig."';
        ActionMsg: Label 'To Wizard...', Comment = 'DEU="Zum Wizard..."';
        ExtensionGuidTxt: Label 'ae7eef02-bb60-436c-856d-d815600787b0';
}