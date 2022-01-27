page 5272734 "lbt cl Editor Preview Sub"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Editor Preview';
    editable = false;


    layout
    {
        area(Content)
        {

            group(EditData)
            {
                ShowCaption = false;
                usercontrol(editor; "lbt cl QuillEditor")
                {
                    ApplicationArea = all;
                    trigger ControlReady()
                    begin
                        CurrPage.editor.Init(true, true);
                        CurrPage.editor.SetHTMLText(Data);
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
    begin
        //CurrPage.showdata.SetContent(StrSubstNo('<textarea Id="TextArea" maxlength="%2" style="width:100%;height:100%;resize: none; font-family:"Segoe UI", "Segoe WP", Segoe, device-segoe, Tahoma, Helvetica, Arial, sans-serif !important; font-size: 10.5pt !important;" OnChange="window.parent.WebPageViewerHelper.TriggerCallback(document.getElementById(''TextArea'').Value)">%1</textarea>', data, MaxStrLen(data)));
        //CurrPage.showdata2.SetContent(data);
    end;

    var
        isReady: Boolean;

    procedure SetData(v_Data: Text)
    begin
        Data := v_Data;
    end;

    procedure GetData() Result: Text
    begin
        exit(Data);
    end;


    var
        Data: Text;
}