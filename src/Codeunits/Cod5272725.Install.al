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
            case LBTModuleInfo.DataVersion() of
            //add reinstallation code for each version
            end;
        end;
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
            case LBTModuleInfo.DataVersion() of
            //add reinstallation code for each version
            end;
        end;
    end;
}