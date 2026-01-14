page 5272729 "lbt cl WebViewer"
{
    Caption = 'Viewer';
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            group(Editor)
            {
                Caption = 'Editor';
                usercontrol(Viewer; "WebPageViewer")
                {
                    ApplicationArea = All;
                    trigger ControlAddInReady(callbackUrl: Text)
                    var
                    begin
                        CurrPage.Viewer.SetContent(HTMLContent);
                    end;
                }
            }
        }
    }

    var
        HTMLContent: Text;

    procedure SetContent(p_content: Text)
    begin
        HTMLContent := p_content;
    end;
}