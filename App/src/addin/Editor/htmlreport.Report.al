report 5272732 "lbt cl htmlreport"
{
    ApplicationArea = All;
    Caption = 'htmlreport';
    UsageCategory = Lists;
    RDLCLayout = 'src/addin/editor/htmlreport2.rdlc';
    WordLayout = 'src/addin/editor/htmlreport2.docx';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(integer; "integer")
        {
            DataItemTableView = where(number = const(1));
            column(htmltext; htmltext)
            {

            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        htmltext: text;

    procedure sethtmltext(text: text)
    begin
        htmltext := text;
    end;

    trigger OnInitReport()
    var
        i: Integer;
    begin
        i := 1;
        //CurrReport.WordLayout()
    end;
}
