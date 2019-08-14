codeunit 5272725 "LBT Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        LBTModuleInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(LBTModuleInfo);
        if LBTModuleInfo.DataVersion() = Version.Create(0, 0, 0, 0) then begin
            //new installation
        end
        else begin
            //reinstallation
            // case LBTModuleInfo.DataVersion() of
            // //add reinstallation code for each version
            // end;
        end;
        CreateNotification();
    end;

    local procedure CreateNotification()
    var
        Note: Notification;
    begin
        Note.Message('Ready!');
        Note.Scope := NotificationScope::GlobalScope;
        Note.AddAction('click', Codeunit::"LBT AssistedSetup", 'HandleNotification');
        Note.Send();
    end;


    trigger OnInstallAppPerDatabase()
    var
        LBTModuleInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(LBTModuleInfo);
        if LBTModuleInfo.DataVersion() = Version.Create(0, 0, 0, 0) then begin
            //new installation
        end
        else begin
            //reinstallation
            // case LBTModuleInfo.DataVersion() of
            // //add reinstallation code for each version
            // end;
        end;
    end;
}