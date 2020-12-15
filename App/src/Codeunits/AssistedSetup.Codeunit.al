codeunit 5272727 "lbt AssistedSetup"
{
    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnRegisterAssistedSetup', '', true, true)]
    local procedure AggregatedSetup_OnRegisterAssistedSetup()
    begin
        RegisterAssistedSetup();
    end;

    procedure RegisterAssistedSetup()
    var
        AssistedSetup: Record "Assisted Setup";
        NewOrderNumber: Integer;
    begin
        if AssistedSetup.Get(Page::"lbt Wizard") then
            exit;
        AssistedSetup.LockTable();
        AssistedSetup.SetCurrentKey(Order, Visible);
        if AssistedSetup.FindLast() then
            NewOrderNumber := AssistedSetup.Order + 1
        else
            NewOrderNumber := 1;

        Clear(AssistedSetup);
        AssistedSetup.Init();
        AssistedSetup.Validate("Page ID", Page::"lbt Wizard");
        AssistedSetup.Validate(Name, SetupLbl);
        AssistedSetup.Validate(Order, NewOrderNumber);
        AssistedSetup.Validate(Status, AssistedSetup.Status::"Not Completed");
        AssistedSetup.Validate(Visible, true);
        AssistedSetup.Validate("Assisted Setup Page ID", Page::"lbt Wizard");
        AssistedSetup.Insert(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Role Center Notification Mgt.", 'OnBeforeShowNotifications', '', true, true)]
    local procedure MyProcedure()
    var
        AssistedSetup: Record "Assisted Setup";
    begin
        if not (AssistedSetup.GetStatus(Page::"lbt Wizard") = AssistedSetup.Status::Completed) then
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
        AssistedSetup: Record "Assisted Setup";
    begin
        RegisterAssistedSetup();
        AssistedSetup.Get(Page::"lbt Wizard");
        AssistedSetup.Run();
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
        NotificationIdTxt: Label 'e6947c77-ec45-40c2-8c7e-01295de6efe4';
        NotificationMsg: Label 'The setup for LeBit365 Reports is incomplete';
        ActionMsg: Label 'To Wizard...';
        ExtensionGuidTxt: Label 'ae7eef02-bb60-436c-856d-d815600787b0';
}