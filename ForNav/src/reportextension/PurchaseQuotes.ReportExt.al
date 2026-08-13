reportextension 5266409 "lbt Purchase Quotes" extends "ForNAV VAT Purchase Quote"
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
                HeaderText := Header.lbtGetPrintData("lbt Position"::EditorHeader, Header."Document Type".AsInteger());
                FooterText := Header.lbtGetPrintData("lbt Position"::EditorFooter, Header."Document Type".AsInteger());
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
                LineText := Line.lbtGetPrintData("lbt Position"::EditorLine, Line."Document Type".AsInteger());
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
