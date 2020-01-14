codeunit 5272726 "LBT Upgrade"
{
    Subtype = Upgrade;

    trigger OnCheckPreconditionsPerCompany()
    var
        LBTModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetCurrentModuleInfo(LBTModuleInfo) then
            Clear(LBTModuleInfo);
        // case LBTModuleInfo.DataVersion() of
        // end;
    end;

    trigger OnCheckPreconditionsPerDatabase()
    var
        LBTModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetCurrentModuleInfo(LBTModuleInfo) then
            Clear(LBTModuleInfo);
        // case LBTModuleInfo.DataVersion() of
        // end;
    end;

    trigger OnUpgradePerCompany()
    var
        LBTModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetCurrentModuleInfo(LBTModuleInfo) then
            Clear(LBTModuleInfo);
        // case LBTModuleInfo.DataVersion() of
        // end;
    end;

    trigger OnUpgradePerDatabase()
    var
        LBTModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetCurrentModuleInfo(LBTModuleInfo) then
            Clear(LBTModuleInfo);
        // case LBTModuleInfo.DataVersion() of
        // end;
    end;

    trigger OnValidateUpgradePerCompany()
    var
        LBTModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetCurrentModuleInfo(LBTModuleInfo) then
            Clear(LBTModuleInfo);
        // case LBTModuleInfo.DataVersion() of
        // end;
    end;

    trigger OnValidateUpgradePerDatabase()
    var
        LBTModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetCurrentModuleInfo(LBTModuleInfo) then
            Clear(LBTModuleInfo);
        // case LBTModuleInfo.DataVersion() of
        // end;
    end;

}