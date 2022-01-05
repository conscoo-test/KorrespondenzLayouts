page 5272733 "lbt cl Editor Preview"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Editor Preview';


    layout
    {
        area(Content)
        {

            group(EditData)
            {
                usercontrol(showdata; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
                {
                    ApplicationArea = all;
                    trigger ControlAddInReady(callbackUrl: Text)
                    begin
                        isReady := true;
                        FillAddin();
                    end;

                    trigger CallBack(v_data: Text)
                    begin
                        Data := v_data;
                        CurrPage.showdata2.SetContent(Data);
                    end;
                }
            }


            group(PreviewData)
            {

                usercontrol(showdata2; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
                {
                    ApplicationArea = all;
                    trigger ControlAddInReady(callbackUrl: Text)
                    begin
                        isReady := true;
                        FillAddin();
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if isReady then
            FillAddin();
    end;

    local procedure FillAddin()
    var
        TextAreaHtmlTxt: Label '<textarea Id="TextArea" maxlength="%2" style="width:100%;height:100%;resize: none; font-family:"Segoe UI", "Segoe WP", Segoe, device-segoe, Tahoma, Helvetica, Arial, sans-serif !important; font-size: 10.5pt !important;" OnChange="window.parent.WebPageViewerHelper.TriggerCallback(document.getElementById(''TextArea'').Value)">%1</textarea>', Locked = true;
    begin
        CurrPage.showdata.SetContent(StrSubstNo(TextAreaHtmlTxt, Data, MaxStrLen(Data)));
        CurrPage.showdata2.SetContent(Data);
    end;

    var
        isReady: Boolean;

    procedure SetData(v_Data: Text)
    begin
        Data := v_Data;
    end;

    procedure GetData(): Text
    begin
        exit(Data);
    end;


    var
        Data: Text;
}