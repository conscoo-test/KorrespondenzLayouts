reportextension 5266404 "lbt Sales Invoice" extends "ForNAV VAT Sales Invoice"
{
    dataset
    {
        add(Header)
        {
            column(lbtCompanyAddressLine; CompanyAddressLine)
            {
                IncludeCaption = false;
            }
            column(lbtHeaderText; HeaderText)
            {
                IncludeCaption = false;
            }
            column(lbtFooterText; FooterText)
            {
                IncludeCaption = false;
            }
        }
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            begin
                HeaderText := Header.lbtGetPrintData("lbt Position"::EditorHeader);
                FooterText := Header.lbtGetPrintData("lbt Position"::EditorFooter);
            end;
        }
        add(Line)
        {
            column(lbtLineText; LineText)
            {
                IncludeCaption = false;
            }
            column(lbtBalance; Line."lbt Balance")
            {
                IncludeCaption = false;
            }
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                LineText := Line.lbtGetPrintData("lbt Position"::EditorLine);
                Line.CalcFields("lbt Balance");
            end;
        }
    }

    trigger OnPreReport()
    var
        lbtFormatDocument: Codeunit "lbt Format Document";
    begin
        CompanyAddressLine := lbtFormatDocument.CompanyAddressLine();
    end;

    var
        CompanyAddressLine: Text;
        HeaderText: Text;
        FooterText: Text;
        LineText: Text;
}