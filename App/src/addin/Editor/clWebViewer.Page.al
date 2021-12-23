page 50729 "lbt cl WebViewer"
{
    caption = 'Viewer';
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {

            usercontrol(Viewer; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
            {
                ApplicationArea = all;
                trigger ControlAddInReady(callbackUrl: Text)
                var
                begin
                    CurrPage.Viewer.SetContent(HTMLContent);
                end;
            }
        }
    }

    var
        HTMLContent: text;

    procedure SetContent(p_content: text)
    begin
        HTMLContent := p_content;
    end;
}