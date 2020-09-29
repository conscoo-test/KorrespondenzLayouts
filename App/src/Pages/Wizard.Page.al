page 5272724 "lbt Wizard"
{
    PageType = NavigatePage;
    Caption = 'LeBit365 Setup';

    SourceTable = "Company Information";
    layout
    {
        area(content)
        {
            group(StandardBanner)
            {
                Editable = false;
                Visible = TopBannerVisible and (CurrentStep < 3);
                field("Media Resources"; MediaResources."Media Reference")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Media Resources';
                }
            }

            group(FinishedBanner)
            {
                Editable = false;
                Visible = TopBannerVisible and (CurrentStep = 3);
                field("Media Resources Done"; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Media Resources Done';
                }
            }

            group(Step1)
            {
                Visible = CurrentStep = 1;
                group(Welcome)
                {
                    Caption = 'Welcome';


                    group(Introduction)
                    {
                        Caption = '';
                        InstructionalText = 'You can set the type of correspondence documents with which you want to use the comfort functions and where any existing company logo should appear on the documents.',
                            Comment = 'DEU="Sie können einstellen mit welche Art von Korrespondenzbelegen Sie die Komfortfunktionen nutzen möchten und an welcher Stelle ein evtl. vorhandenes Firmenlogo auf den Belegen erscheinen soll"';

                    }
                }

                group(LetsGo)
                {
                    Caption = 'Lets go';

                    group("Next")
                    {
                        Caption = '';
                        InstructionalText = 'Choose Next so you can set up.',
                            Comment = 'DEU="Wählen Sie \"Weiter\" damit Sie die Korrespondenzbelege auswählen können."';
                    }
                }
            }
            group(Step2)
            {
                Visible = CurrentStep = 2;

                group(Default)
                {
                    Caption = '';
                    field("Select All"; SelectAll)
                    {
                        Caption = 'Select all';
                        ApplicationArea = All;
                        ToolTip = 'Here you can select all';
                        trigger OnValidate()
                        var
                            i: Integer;
                        begin
                            for i := 1 to 12 do
                                DefaultReports[i] := SelectAll;
                        end;
                    }
                    field(report1; DefaultReports[1])
                    {
                        Caption = 'Sales Quote';
                        ApplicationArea = All;
                        ToolTip = 'Select document for configuration';
                    }
                    field(report2; DefaultReports[2])
                    {
                        Caption = 'Order Confirmation';
                        ApplicationArea = All;
                        ToolTip = 'Select document for configuration';
                    }
                    field(report3; DefaultReports[3])
                    {
                        Caption = 'Sales Invoice';
                        ApplicationArea = all;
                        ToolTip = 'Select document for configuration';
                    }
                    field(report4; DefaultReports[4])
                    {
                        Caption = 'Sales Credit Memo';
                        ApplicationArea = all;
                        ToolTip = 'Select document for configuration';
                    }
                    field(report5; DefaultReports[5])
                    {
                        Caption = 'Sales Shipment';
                        ApplicationArea = all;
                        ToolTip = 'Select document for configuration';
                    }
                    field(report6; DefaultReports[6])
                    {
                        Caption = 'Blanket Sales Order';
                        ApplicationArea = all;
                        ToolTip = 'Select document for configuration';
                    }
                    field(report7; DefaultReports[7])
                    {
                        Caption = 'Sales Proforma Invoice';
                        ApplicationArea = all;
                        ToolTip = 'Select document for configuration';
                    }
                    field(report8; DefaultReports[8])
                    {
                        Caption = 'Purchase Quote';
                        ApplicationArea = all;
                        ToolTip = 'Select document for configuration';
                    }
                    field(report9; DefaultReports[9])
                    {
                        Caption = 'Order';
                        ApplicationArea = all;
                        ToolTip = 'Select document for configuration';
                    }
                    field(report10; DefaultReports[10])
                    {
                        Caption = 'Blanket Purchase Order';
                        ApplicationArea = all;
                        ToolTip = 'Select document for configuration';
                    }
                    field(report11; DefaultReports[11])
                    {
                        Caption = 'Return Order';
                        ApplicationArea = all;
                        ToolTip = 'Select document for configuration';
                    }
                    field(report12; DefaultReports[12])
                    {
                        Caption = 'Reminder';
                        ApplicationArea = all;
                        ToolTip = 'Select document for configuration';
                    }



                }
            }

            group(Step3)
            {
                Visible = CurrentStep = 3;

                group(PictureGroup)
                {
                    Caption = '';
                    field(Picture; Picture) //TODO: MediaSet
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the logo file';
                    }
                    field("Sales Logo Position"; SalesLogoPosition)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Defines the logo position on the Sales documents';
                        Caption = 'Logoposition on Sales Documents';
                        OptionCaption = 'No Logo,Left,Center,Right';
                    }
                    field("Purchase Logo Position"; PurchaseLogoPosition)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Defines the logo position on the Purchase documents';
                        Caption = 'Logoposition on Purchase Documents';
                        OptionCaption = 'No Logo,Left,Center,Right';
                    }
                }
            }

            group(Step4)
            {
                Visible = CurrentStep = 4;
                group(Bank1)
                {
                    Caption = '';
                    field("Bank Account No."; "Bank Account No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Please enter your bank account number here';
                    }
                    field("Bank Name"; "Bank Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Please enter the Name of your bank  here';
                    }
                    field("Bank Branch No."; "Bank Branch No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Please enter the bank code here';
                    }
                    field(IBAN; IBAN)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Please enter your IBAN code here';
                    }

                }
                group(Bank2)
                {
                    Caption = '';
                    field("lbt Bank Account No. 2"; "lbt Bank Account No. 2")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Please enter your 2. bank account number here';
                    }
                    field("lbt Bank Name 2"; "lbt Bank Name 2")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Please enter the Name of your 2. bank  here';
                    }
                    field("lbt Bank Branch No. 2"; "lbt Bank Branch No. 2")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Please enter the 2. bank code here';
                    }
                    field("lbt IBAN 2"; "lbt IBAN 2")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Please enter your 2. IBAN code here';
                    }

                }
                group(Bank3)
                {
                    Caption = '';
                    field("lbt Bank Account No. 3"; "lbt Bank Account No. 3")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Please enter your 3. bank account number here';
                    }
                    field("lbt Bank Name 3"; "lbt Bank Name 3")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Please enter the Name of your 3. bank here';
                    }
                    field("lbt Bank Branch No. 3"; "lbt Bank Branch No. 3")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Please enter the 3. bank code here';
                    }
                    field("lbt IBAN 3"; "lbt IBAN 3")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Please enter your 3. IBAN code here';
                    }

                }
            }

            group(Step5)
            {
                Visible = CurrentStep = 5;
                group(other)
                {
                    Caption = '';
                    field("lbt District Court"; "lbt District Court")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter the district court here';
                    }
                    field("lbt CEO1"; "lbt CEO1")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter the Name of CEO';
                    }
                    field("lbt CEO2"; "lbt CEO2")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter the Name of the 2. CEO';
                    }
                    field("lbt CEO3"; "lbt CEO3")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter the Name of the 3. CEO';
                    }
                    field("lbt Commercial Register No."; "lbt Commercial Register No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter your commercial register number';
                    }
                    field("lbt Trade Register Name"; "lbt Trade Register Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter your trade register name.';
                    }

                }
            }

        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionBack)
            {
                ApplicationArea = All;
                ToolTip = 'One record back';
                Caption = 'Back';
                Enabled = BackEnabled;
                Visible = BackEnabled;
                Image = PreviousRecord;
                InFooterBar = true;

                trigger OnAction()
                begin
                    TakeStep(-1);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea = All;
                ToolTip = 'One record forward';
                Caption = 'Next';
                Enabled = NextEnabled;
                Image = NextRecord;
                InFooterBar = true;
                trigger OnAction()
                begin
                    TakeStep(1);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = All;
                ToolTip = 'Complete the configuration';
                Caption = 'Finish';
                Enabled = FinishEnabled;
                Image = Approve;
                InFooterBar = true;
                trigger OnAction()
                begin
                    Finish();

                end;
            }
        }
    }
    trigger OnInit()
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage()
    begin
        CurrentStep := 1;
        SetControls();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        AssistedSetup: Record "Assisted Setup";
    begin
        if CloseAction = Action::OK then
            if AssistedSetup.GetStatus(Page::"lbt Wizard") <> AssistedSetup.Status::Completed then
                if not Confirm(FinishWhenNotCompleteQst, false) then
                    Error('');
    end;

    local procedure Finish()
    var
        AssistedSetup: Record "Assisted Setup";
    begin
        "lbt Setup finished" := true;
        Modify();
        Commit();
        AssistedSetup.SetStatus(Page::"lbt Wizard", AssistedSetup.Status::Completed);
        CurrPage.Close();
    end;

    local procedure SetControls()
    begin
        BackEnabled := CurrentStep > 1;
        NextEnabled := CurrentStep < 5;
        FinishEnabled := CurrentStep = 5;
    end;

    local procedure TakeStep(Step: Integer)
    begin
        case CurrentStep of
            2:
                SetReportSelections();
            3:
                SetLogoPosition();
        end;

        CurrentStep += Step;
        SetControls();
        case CurrentStep of
            2:
                GetReportSelections();
            3:
                GetLogoPosition();

        end;
    end;

    local procedure GetLogoPosition()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        PurchPayablesSetup: Record "Purchases & Payables Setup";
    begin
        SalesReceivablesSetup.Get();
        SalesLogoPosition := SalesReceivablesSetup."Logo Position on Documents";

        PurchPayablesSetup.Get();
        PurchaseLogoPosition := PurchPayablesSetup."lbt Logo Position on Documents";
    end;

    local procedure SetLogoPosition()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        PurchPayablesSetup: Record "Purchases & Payables Setup";
    begin
        SalesReceivablesSetup.Get();
        if SalesReceivablesSetup."Logo Position on Documents" <> SalesLogoPosition then begin
            SalesReceivablesSetup."Logo Position on Documents" := SalesLogoPosition;
            SalesReceivablesSetup.Modify();
        end;

        PurchPayablesSetup.Get();
        if PurchPayablesSetup."lbt Logo Position on Documents" <> PurchaseLogoPosition then begin
            PurchPayablesSetup."lbt Logo Position on Documents" := PurchaseLogoPosition;
            PurchPayablesSetup.Modify();
        end;
    end;

    local procedure GetReportSelections()
    var
        ReportSelections: Record "Report Selections";
    begin
        DefaultReports[1] := GetReportSelection(ReportSelections.Usage::"S.Quote", Report::"lbt Sales - Quote");
        DefaultReports[2] := GetReportSelection(ReportSelections.Usage::"S.Order", Report::"lbt Order Confirmation");
        DefaultReports[3] := GetReportSelection(ReportSelections.Usage::"S.Invoice", Report::"lbt Sales - Invoice");
        DefaultReports[4] := GetReportSelection(ReportSelections.Usage::"S.Cr.Memo", Report::"lbt Sales - Credit Memo");
        DefaultReports[5] := GetReportSelection(ReportSelections.Usage::"S.Shipment", Report::"lbt Sales - Shipment");
        DefaultReports[6] := GetReportSelection(ReportSelections.Usage::"S.Blanket", Report::"lbt Blanket Sales Order");
        DefaultReports[7] := GetReportSelection(ReportSelections.Usage::"Pro Forma S. Invoice", Report::"lbt Sales pro forma Invoice");
        DefaultReports[8] := GetReportSelection(ReportSelections.Usage::"P.Quote", Report::"lbt Purchase - Quote");
        DefaultReports[9] := GetReportSelection(ReportSelections.Usage::"P.Order", Report::"lbt Order");
        DefaultReports[10] := GetReportSelection(ReportSelections.Usage::"P.Blanket", Report::"lbt Blanket Purchase Order");
        DefaultReports[11] := GetReportSelection(ReportSelections.Usage::"P.Return", Report::"lbt Return Order");
        DefaultReports[12] := GetReportSelection(ReportSelections.Usage::Reminder, Report::"lbt Reminder");
    end;

    local procedure GetReportSelection(Usage: Integer; ReportId: Integer): Boolean
    var
        ReportSelections: Record "Report Selections";
    begin
        ReportSelections.SetRange(Usage, Usage);
        ReportSelections.SetRange("Report ID", ReportId);
        exit(not ReportSelections.IsEmpty());

    end;

    local procedure SetReportSelections()
    var
        ReportSelections: Record "Report Selections";
    begin
        SetReportSelection(DefaultReports[1], ReportSelections.Usage::"S.Quote", Report::"lbt Sales - Quote");
        SetReportSelection(DefaultReports[2], ReportSelections.Usage::"S.Order", Report::"lbt Order Confirmation");
        SetReportSelection(DefaultReports[3], ReportSelections.Usage::"S.Invoice", Report::"lbt Sales - Invoice");
        SetReportSelection(DefaultReports[4], ReportSelections.Usage::"S.Cr.Memo", Report::"lbt Sales - Credit Memo");
        SetReportSelection(DefaultReports[5], ReportSelections.Usage::"S.Shipment", Report::"lbt Sales - Shipment");
        SetReportSelection(DefaultReports[6], ReportSelections.Usage::"S.Blanket", Report::"lbt Blanket Sales Order");
        SetReportSelection(DefaultReports[7], ReportSelections.Usage::"Pro Forma S. Invoice", Report::"lbt Sales pro forma Invoice");
        SetReportSelection(DefaultReports[8], ReportSelections.Usage::"P.Quote", Report::"lbt Purchase - Quote");
        SetReportSelection(DefaultReports[9], ReportSelections.Usage::"P.Order", Report::"lbt Order");
        SetReportSelection(DefaultReports[10], ReportSelections.Usage::"P.Blanket", Report::"lbt Blanket Purchase Order");
        SetReportSelection(DefaultReports[11], ReportSelections.Usage::"P.Return", Report::"lbt Return Order");
        SetReportSelection(DefaultReports[12], ReportSelections.Usage::Reminder, Report::"lbt Reminder");
    end;

    local procedure SetReportSelection(UseLeBit365Report: Boolean; Usage: Integer; ReportId: Integer)
    var
        ReportSelections: Record "Report Selections";
    begin
        if not UseLeBit365Report then
            exit;
        ReportSelections.Get(Usage, 1);
        if ReportSelections."Report ID" = ReportId then
            exit;
        ReportSelections."Report ID" := ReportId;
        ReportSelections.Modify();
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepository.GET('AssistedSetup-NoText-400px.png', Format(CurrentClientType())) then
            if MediaResources.GET(MediaRepository."Media Resources Ref") then
                TopBannerVisible := MediaResources."Media Reference".HasValue();
        if MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png', Format(CurrentClientType())) then
            if MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref") then
                TopBannerVisible := TopBannerVisible or MediaResourcesDone."Media Reference".HasValue();
    end;

    var
        MediaRepository: Record "Media Repository";
        MediaResources: Record "Media Resources";
        MediaRepositoryDone: Record "Media Repository";
        MediaResourcesDone: Record "Media Resources";

        TopBannerVisible: Boolean;
        NextEnabled: Boolean;
        BackEnabled: Boolean;
        FinishEnabled: Boolean;
        CurrentStep: Integer;
        DefaultReports: array[12] of Boolean;
        SelectAll: Boolean;
        FinishWhenNotCompleteQst: Label 'Setup has not been completed.\\Are you sure you want to exit?',
            Comment = 'DEU="Die Einrichtung wurde nicht abgeschlossen.\\Möchten Sie den Assistenten wirklich beenden?"';
        SalesLogoPosition: Option "No Logo",Left,Center,Right;
        PurchaseLogoPosition: Option "No Logo",Left,Center,Right;

}
