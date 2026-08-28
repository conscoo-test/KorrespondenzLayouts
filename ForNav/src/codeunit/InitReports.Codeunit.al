codeunit 5266401 "lbt Init Reports"
{
    internal procedure InitReports()
    var
        Company: Record "Company";
        TempCompany: Record "Company" temporary;
        ReportLayoutList: Record "Report Layout List";
        CompanySelector: Page "Company Selector";
        CurrentLbl: Label '%1 (Current)', Comment = '%1 = company name';
        FinishedMsg: Label 'Report initialization finished. Please check the report layout selection and language setup for the selected companies.',
            Comment = 'de-DE=Die Initialisierung der Berichte ist abgeschlossen. Bitte überprüfen Sie die Auswahl der Berichtslayouts und die Spracheinstellungen für die ausgewählten Unternehmen.';
        ModulInfo_: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(ModulInfo_);
        ReportLayoutList.SetRange("Application ID", ModulInfo_.Id());

        if Company.FindSet() then
            repeat
                TempCompany := Company;
                if Company.Name = CompanyName() then
                    TempCompany."Display Name" := CopyStr(StrSubstNo(CurrentLbl, Company."Display Name"), 1, MaxStrLen(TempCompany."Display Name"));

                TempCompany.Insert(false);
            until Company.Next() = 0;

        if TempCompany.Count() > 1 then begin
            CompanySelector.lbtSetCompanies(TempCompany);
            CompanySelector.LookupMode := true;
            if CompanySelector.RunModal() <> Action::LookupOK then
                exit;

            CompanySelector.lbtGetSelectedCompany(TempCompany);
        end;


        if TempCompany.FindSet() then
            repeat
                SelectedCompany := TempCompany.Name;
                if ReportLayoutList.FindSet() then
                    repeat
                        AddLayoutSelection(ReportLayoutList);
                        InitForNAVLanguageSetup();

                    until ReportLayoutList.Next() = 0;
            until TempCompany.Next() = 0;

        Message(FinishedMsg);
    end;

    internal procedure InitForNAVLanguageSetup()
    var
        SalesLine: Record "Sales Line";
        CompanyInformation: Record "Company Information";
    begin
        InsertLanguageLine(Database::"Sales Line", SalesLine.FieldNo("Unit Price"), 'VK-Preis');
        InsertLanguageLine(Database::"Sales Invoice Line", SalesLine.FieldNo("Unit Price"), 'VK-Preis');
        InsertLanguageLine(Database::"Sales Line", SalesLine.FieldNo("Line Discount %"), 'Rabatt %');
        InsertLanguageLine(Database::"Sales Invoice Line", SalesLine.FieldNo("Line Discount %"), 'Rabatt %');
        InsertLanguageLine(Database::"Sales Line", SalesLine.FieldNo("lbt Pos. No."), 'Pos.');
        InsertLanguageLine(Database::"Sales Invoice Line", SalesLine.FieldNo("lbt Pos. No."), 'Pos.');
        InsertLanguageLine(Database::"Company Information", CompanyInformation.FieldNo("lbt Trade Register Name"), 'Handelsregister');
    end;

    internal procedure InsertLanguageLine(TableNo: Integer; FieldNo: Integer; TranslateTo: Text[1024])
    var
        ForNAVLanguageSetup: Record "ForNAV Language Setup";
    begin
        if SelectedCompany <> CompanyName() then
            ForNAVLanguageSetup.ChangeCompany(SelectedCompany);
        ForNAVLanguageSetup.SetRange("Language Code", 'DEU');
        ForNAVLanguageSetup.SetRange("Table No.", TableNo);
        ForNAVLanguageSetup.SetRange("Field No.", FieldNo);
        if not ForNAVLanguageSetup.IsEmpty() then
            exit;
        ForNAVLanguageSetup.Init();
        ForNAVLanguageSetup.Validate("Language Code", 'DEU');
        ForNAVLanguageSetup."Report ID" := 0;
        ForNAVLanguageSetup.Validate("Table No.", TableNo);
        ForNAVLanguageSetup.Validate("Field No.", FieldNo);
        ForNAVLanguageSetup.Validate("Translate To", TranslateTo);
        if ForNAVLanguageSetup.Insert(false) then;
    end;

    local procedure AddLayoutSelection(SelectedReportLayoutList: Record "Report Layout List"): Boolean
    var
        TenantReportLayoutSelection: Record "Tenant Report Layout Selection";
        ReportLayoutSelection: Record "Report Layout Selection";
        NullGuid: Guid;
    begin
        if not TenantReportLayoutSelection.Get(SelectedReportLayoutList."Report ID", SelectedCompany, NullGuid) then begin
            TenantReportLayoutSelection.Init();
            TenantReportLayoutSelection."Report ID" := SelectedReportLayoutList."Report ID";
            TenantReportLayoutSelection."Company Name" := SelectedCompany;
            TenantReportLayoutSelection."User ID" := NullGuid;
            TenantReportLayoutSelection.Insert(true);
        end;

        TenantReportLayoutSelection."App ID" := SelectedReportLayoutList."Application ID";
        TenantReportLayoutSelection."Layout Name" := SelectedReportLayoutList."Name";
        TenantReportLayoutSelection.Modify(true);

        // Add to the report layout selection table
        if ReportLayoutSelection.Get(SelectedReportLayoutList."Report ID", SelectedCompany) then begin
            ReportLayoutSelection.Type := GetReportLayoutSelectionCorrespondingEnum(SelectedReportLayoutList);
            ReportLayoutSelection.Modify(true);
        end else begin
            ReportLayoutSelection."Report ID" := SelectedReportLayoutList."Report ID";
            ReportLayoutSelection."Company Name" := SelectedCompany;
            ReportLayoutSelection."Custom Report Layout Code" := '';
            ReportLayoutSelection.Type := GetReportLayoutSelectionCorrespondingEnum(SelectedReportLayoutList);
            ReportLayoutSelection.Insert(true);
        end;
    end;

    local procedure GetReportLayoutSelectionCorrespondingEnum(SelectedReportLayoutList: Record "Report Layout List"): Integer
    begin
        case SelectedReportLayoutList."Layout Format" of

            SelectedReportLayoutList."Layout Format"::RDLC:
                exit(0);
            SelectedReportLayoutList."Layout Format"::Word:
                exit(1);
            SelectedReportLayoutList."Layout Format"::Excel:
                exit(3);
            SelectedReportLayoutList."Layout Format"::Custom:
                exit(4);
        end;
    end;

    var
        SelectedCompany: Text[30];
}