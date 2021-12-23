page 50733 "lbt cl Editor Preview"
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
                        isready := true;
                        FillAddIn();
                    end;

                    trigger CallBack(v_data: text)
                    begin
                        data := v_data;
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
                        isready := true;
                        FillAddIn();
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

    local Procedure FillAddin()
    begin
        CurrPage.showdata.SetContent(StrSubstNo('<textarea Id="TextArea" maxlength="%2" style="width:100%;height:100%;resize: none; font-family:"Segoe UI", "Segoe WP", Segoe, device-segoe, Tahoma, Helvetica, Arial, sans-serif !important; font-size: 10.5pt !important;" OnChange="window.parent.WebPageViewerHelper.TriggerCallback(document.getElementById(''TextArea'').value)">%1</textarea>', data, MaxStrLen(data)));
        CurrPage.showdata2.SetContent(data);
    end;

    var
        isReady: Boolean;

    procedure SetData(v_Data: text)
    begin
        data := v_Data;
    end;

    procedure GetData() Result: Text
    begin
        exit(data);
    end;


    var
        Data: text;
}