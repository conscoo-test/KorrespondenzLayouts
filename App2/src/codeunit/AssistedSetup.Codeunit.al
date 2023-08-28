codeunit 5272727 "lbt AssistedSetup"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Guided Experience", 'OnRegisterAssistedSetup', '', true, true)]
    local procedure AggregatedSetup_OnRegisterAssistedSetup()
    begin
        RegisterAssistedSetup();
    end;

    local procedure RegisterAssistedSetup()
    var
        GuidedExperience: Codeunit "Guided Experience";
    begin
        GuidedExperience.InsertAssistedSetup(
            SetupLbl, SetupLbl, SetupLbl, 0, ObjectType::Page, Page::"lbt Wizard", "Assisted Setup Group"::Extensions, '', "Video Category"::Uncategorized, '', true
        );
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Role Center Notification Mgt.", 'OnBeforeShowNotifications', '', true, true)]
    local procedure MyProcedure()
    var
        GuidedExperience: Codeunit "Guided Experience";
    begin
        if not GuidedExperience.IsAssistedSetupComplete(ObjectType::Page, Page::"lbt Wizard") then
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
        GuidedExperience: Codeunit "Guided Experience";
    begin
        RegisterAssistedSetup();
        Commit();

        if GuidedExperience.SetupForExtensionExists(ExtensionGuidTxt) then
            GuidedExperience.RunExtensionSetup(ExtensionGuidTxt);
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
        ExtensionGuidTxt: Label '438ef260-fa91-4861-9fc5-2bc28bf85771', Locked = true;
}