codeunit 5272726 "lbt Upgrade"
{
    Subtype = Upgrade;

    trigger OnCheckPreconditionsPerCompany()
    var
        lbtModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetCurrentModuleInfo(lbtModuleInfo) then
            Clear(lbtModuleInfo);
        // case lbtModuleInfo.DataVersion() of
        // end;
    end;

    trigger OnCheckPreconditionsPerDatabase()
    var
        lbtModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetCurrentModuleInfo(lbtModuleInfo) then
            Clear(lbtModuleInfo);
        // case lbtModuleInfo.DataVersion() of
        // end;
    end;

    trigger OnUpgradePerCompany()
    var
        lbtModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetCurrentModuleInfo(lbtModuleInfo) then
            Clear(lbtModuleInfo);
        // case lbtModuleInfo.DataVersion() of
        // end;
    end;

    trigger OnUpgradePerDatabase()
    var
        lbtModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetCurrentModuleInfo(lbtModuleInfo) then
            Clear(lbtModuleInfo);
        // case lbtModuleInfo.DataVersion() of
        // end;
    end;

    trigger OnValidateUpgradePerCompany()
    var
        lbtModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetCurrentModuleInfo(lbtModuleInfo) then
            Clear(lbtModuleInfo);
        // case lbtModuleInfo.DataVersion() of
        // end;
    end;

    trigger OnValidateUpgradePerDatabase()
    var
        lbtModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetCurrentModuleInfo(lbtModuleInfo) then
            Clear(lbtModuleInfo);
        // case lbtModuleInfo.DataVersion() of
        // end;
    end;

}