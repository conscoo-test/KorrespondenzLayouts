page 5272724 "LBT Wizard"
{

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
                    Caption = 'Welcome', Comment = 'DEU="Willkommen"';


                    group(Introduction)
                    {
                        Caption = '';
                        InstructionalText = 'englisch',  //TODO
                            Comment = 'DEU="Sie können einstellen mit welche Art von Korrespondenzbelegen Sie die Komfortfunktionen nutzen möchten und an welcher Stelle ein evtl. vorhandenes Firmenlogo auf den Belegen erscheinen soll"';

                    }
                }
            }
            group(Step2)
            {
                Visible = CurrentStep = 2;

                group(Default)
                {
                    field(report1; DefaultReports[1])
                    {
                        Caption = 'Order Confirmation', Comment = 'DEU="Auftragsbestätigung"';
                        ApplicationArea = All;
                    }
                    field(report2; DefaultReports[2])
                    {
                        Caption = 'Sales Invoice', Comment = 'DEU="VK Rechnung"';
                        ApplicationArea = all;
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
                Caption = 'Finish', Comment = 'DEU="Beenden"';
                Enabled = FinishEnabled;
                Image = Approve;
                InFooterBar = true;
                trigger OnAction()
                begin
                    CurrPage.Close();
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

    local procedure SetControls()
    begin
        BackEnabled := CurrentStep > 1;
        NextEnabled := CurrentStep < 3;
        FinishEnabled := CurrentStep = 3;
    end;

    local procedure TakeStep(Step: Integer)
    begin
        CurrentStep += Step;
        SetControls();
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepository.GET('AssistedSetup-NoText-400px.png', Format(CurrentClientType)) then
            if MediaResources.GET(MediaRepository."Media Resources Ref") then
                TopBannerVisible := MediaResources."Media Reference".HasValue;
        if MediaResourcesDone.Get('AssistedSetupDone-NoText-400px.png', Format(CurrentClientType)) then
            if MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref") then
                TopBannerVisible := TopBannerVisible or MediaResourcesDone."Media Reference".HasValue;
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


}
