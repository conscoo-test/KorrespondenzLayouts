codeunit 5272727 "lbt AssistedSetup"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assisted Setup", 'OnRegister', '', true, true)]
    local procedure AggregatedSetup_OnRegisterAssistedSetup()
    begin
        RegisterAssistedSetup();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assisted Setup", 'OnRegister', '', true, true)]
    local procedure AssistedSetup_OnRegister()
    begin
        RegisterAssistedSetup();
    end;

    local procedure RegisterAssistedSetup()
    var
        AssistedSetup: Codeunit "Assisted Setup";
        AssistedSetupGroup: Enum "Assisted Setup Group";
    begin
        AssistedSetup.Add(GetAppId(), Page::"lbt Wizard", SetupLbl, AssistedSetupGroup::Extensions);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Role Center Notification Mgt.", 'OnBeforeShowNotifications', '', true, true)]
    local procedure MyProcedure()
    var
        AssistedSetup: Codeunit "Assisted Setup";
    begin
        if not AssistedSetup.IsComplete(Page::"lbt Wizard") then
            CreateNotification();
    end;

    local procedure CreateNotification()
    var
        Note: Notification;
    begin
        Note.Id := GetNotificationId();
        Note.Message(NotificationMsg);
        Note.Scope := NotificationScope::LocalScope;
        Note.AddAction(ActionMsg, Codeunit::"lbt AssistedSetup", 'HandleNotification');
        Note.Send();
    end;

    procedure HandleNotification(Note: Notification)
    var
        AssistedSetup: Codeunit "Assisted Setup";
    begin
        RegisterAssistedSetup();
        Commit();
        AssistedSetup.Run(Page::"lbt Wizard");
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
        SetupLbl: Label 'Setup LeBit365';
        NotificationIdTxt: Label 'e6947c77-ec45-40c2-8c7e-01295de6efe4', Locked = true;
        NotificationMsg: Label 'The setup for LeBit365 Reports is incomplete';
        ActionMsg: Label 'To Wizard...';
        ExtensionGuidTxt: Label 'ae7eef02-bb60-436c-856d-d815600787b0', Locked = true;
}