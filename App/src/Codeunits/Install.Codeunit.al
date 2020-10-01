codeunit 5272725 "lbt Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        CorrSetup: Record "lbt Corr Setup";
        lbtModuleInfo: ModuleInfo;
    begin
        with CorrSetup do
            if IsEmpty() then begin
                Init();
                Insert();
            end;
        NavApp.GetCurrentModuleInfo(lbtModuleInfo);
        if lbtModuleInfo.DataVersion() = Version.Create(0, 0, 0, 0) then begin
            //new installation
        end
        else begin
            //reinstallation
            // case lbtModuleInfo.DataVersion() of
            // //add reinstallation code for each version
            // end;
        end;
    end;

    trigger OnInstallAppPerDatabase()
    var
        lbtModuleInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(lbtModuleInfo);
        if lbtModuleInfo.DataVersion() = Version.Create(0, 0, 0, 0) then begin
            //new installation
        end
        else begin
            //reinstallation
            // case lbtModuleInfo.DataVersion() of
            // //add reinstallation code for each version
            // end;
        end;
    end;
}