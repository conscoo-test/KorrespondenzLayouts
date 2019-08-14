page 5272724 "LBT Wizard"
{
    SourceTableTemporary = true;
    PageType = NavigatePage;
    Caption = 'Wizard';
    SourceTable = "Company Information";
    layout
    {
        area(content)
        {
            group(StandardBanner)
            {
                Editable = false;
                Visible = TopBannerVisible and (CurrentStep < 3);
                field(MediaResources; MediaResources."Media Reference")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
            }

            group(FinishedBanner)
            {
                Editable = false;
                Visible = TopBannerVisible and (CurrentStep = 3);
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
            }

            group(Step1)
            {
                Visible = CurrentStep = 1;
                group(Welcome)
                {
                    Caption = 'Welcome', Comment = 'DEU="Willkommen bei der Einrichtung der LIS365-Korrespondenzbelege"';


                    group(Introduction)
                    {
                        Caption = '';
                        InstructionalText = 'englisch',  //TODO: Englischen Text
                            Comment = 'DEU="Sie können einstellen mit welche Art von Korrespondenzbelegen Sie die Komfortfunktionen nutzen möchten und an welcher Stelle ein evtl. vorhandenes Firmenlogo auf den Belegen erscheinen soll"';

                    }
                }

                group(LetsGo)
                {
                    Caption = 'Lets go', Comment = 'DEU="Los gehts"';

                    group(Next)
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
                    field(report1; DefaultReports[1])
                    {
                        Caption = 'Sales Quote', Comment = 'DEU="Angebot"';
                        ApplicationArea = All;
                    }
                    field(report2; DefaultReports[2])
                    {
                        Caption = 'Order Confirmation', Comment = 'DEU="Auftragsbestätigung"';
                        ApplicationArea = All;
                    }
                    field(report3; DefaultReports[3])
                    {
                        Caption = 'Sales Invoice', Comment = 'DEU="VK Rechnung"';
                        ApplicationArea = all;
                    }
                    field(report4; DefaultReports[4])
                    {
                        Caption = 'Sales Credit Memo', Comment = 'DEU="VK Gutschrift"';
                        ApplicationArea = all;
                    }
                    field(report5; DefaultReports[5])
                    {
                        Caption = 'Sales Shipment', Comment = 'DEU="VK Lieferung"';
                        ApplicationArea = all;
                    }
                    field(report6; DefaultReports[6])
                    {
                        Caption = 'Blanket Sales Order', Comment = 'DEU="Rahmenauftrag"';
                        ApplicationArea = all;
                    }
                    field(report7; DefaultReports[7])
                    {
                        Caption = 'Sales Proforma Invoice', Comment = 'DEU="VK Proforma Rechnung"';
                        ApplicationArea = all;
                    }
                    field(report8; DefaultReports[8])
                    {
                        Caption = 'Purchase Quote', Comment = 'DEU="Einkaufsanfrage"';
                        ApplicationArea = all;
                    }
                    field(report9; DefaultReports[9])
                    {
                        Caption = 'Order', Comment = 'DEU="Bestellung"';
                        ApplicationArea = all;
                    }
                    field(report10; DefaultReports[10])
                    {
                        Caption = 'Blanket Purchase Order', Comment = 'DEU="Rahmenbestellung"';
                        ApplicationArea = all;
                    }
                    field(report11; DefaultReports[11])
                    {
                        Caption = 'Return Order', Comment = 'DEU="Return Order"';
                        ApplicationArea = all;
                    }
                    field(report12; DefaultReports[12])
                    {
                        Caption = 'Reminder', Comment = 'DEU="Mahnung"';
                        ApplicationArea = all;
                    }



                }
            }

            group(Step3)
            {
                Visible = CurrentStep = 3;

                group(PictureGroup)
                {
                    Caption = '';
                    field(Picture; Picture)
                    {
                        ApplicationArea = All;
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
                    }
                    field("Bank Name"; "Bank Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Bank Branch No."; "Bank Branch No.")
                    {
                        ApplicationArea = All;
                    }
                    field(IBAN; IBAN)
                    {
                        ApplicationArea = All;
                    }

                }
                group(Bank2)
                {
                    Caption = '';
                    field("LBT Bank Account No. 2"; "LBT Bank Account No. 2")
                    {
                        ApplicationArea = All;
                    }
                    field("LBT Bank Name 2"; "LBT Bank Name 2")
                    {
                        ApplicationArea = All;
                    }
                    field("LBT Bank Branch No. 2"; "LBT Bank Branch No. 2")
                    {
                        ApplicationArea = All;
                    }
                    field("LBT IBAN 2"; "LBT IBAN 2")
                    {
                        ApplicationArea = All;
                    }

                }
                group(Bank3)
                {
                    Caption = '';
                    field("LBT Bank Account No. 3"; "LBT Bank Account No. 3")
                    {
                        ApplicationArea = All;
                    }
                    field("LBT Bank Name 3"; "LBT Bank Name 3")
                    {
                        ApplicationArea = All;
                    }
                    field("LBT Bank Branch No. 3"; "LBT Bank Branch No. 3")
                    {
                        ApplicationArea = All;
                    }
                    field("LBT IBAN 3"; "LBT IBAN 3")
                    {
                        ApplicationArea = All;
                    }

                }
            }

            group(Step5)
            {
                Visible = CurrentStep = 5;
                group(other)
                {
                    Caption = '';
                    field("LBT District Court"; "LBT District Court")
                    {
                        ApplicationArea = All;
                    }
                    field("LBT CEO1"; "LBT CEO1")
                    {
                        ApplicationArea = All;
                    }
                    field("LBT CEO2"; "LBT CEO2")
                    {
                        ApplicationArea = All;
                    }
                    field("LBT CEO3"; "LBT CEO3")
                    {
                        ApplicationArea = All;
                    }
                    field("LBT Commercial Register No."; "LBT Commercial Register No.")
                    {
                        ApplicationArea = All;
                    }
                    field("LBT Trade Register Name"; "LBT Trade Register Name")
                    {
                        ApplicationArea = All;
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
                Caption = 'Back', Comment = 'DEU="Zurück"';
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
                Caption = 'Next', Comment = 'DEU="Weiter"';
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
                Caption = 'Finish', Comment = 'DEU="Fertig stellen"';
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
    var
        CompanyInformation: Record "Company Information";
    begin
        Init();
        if CompanyInformation.Get() then begin
            TransferFields(CompanyInformation);
            CompanyInformation."LBT Setup finished" := false; //TODO: dieses wieder rausnehmen
            CompanyInformation.Modify();
        end;
        Insert();
        CurrentStep := 1;
        SetControls();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        AssistedSetup: Codeunit "LBT AssistedSetup";
    begin
        if CloseAction = Action::OK then
            if not AssistedSetup.IsComplete() then
                if not Confirm(FinishWhenNotCompleteQst, false) then
                    Error('');
    end;

    local procedure Finish()
    var
        CompanyInformation: Record "Company Information";
    begin
        if not CompanyInformation.Get() then begin
            CompanyInformation.Init();
            CompanyInformation.Insert();
        end;

        CompanyInformation.TransferFields(Rec);
        CompanyInformation."LBT Setup finished" := true;
        CompanyInformation.Modify();
        Commit();
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
        CurrentStep += Step;
        SetControls();
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
        FinishWhenNotCompleteQst: Label 'Setup has not been completed.\\Are you sure you want to exit?',
            Comment = 'DEU="Die Einrichtung wurde nicht abgeschlossen.\\Möchten Sie den Assistenten wirklich beenden?"';


}
