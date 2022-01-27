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
        dataitem(Integer; Integer)
        {
            DataItemTableView = where(number = const(1));
            column(htmltext; htmltext) { }
        }
    }
    var
        htmltext: Text;

    procedure sethtmltext(text: Text)
    begin
        htmltext := text;
    end;

}
