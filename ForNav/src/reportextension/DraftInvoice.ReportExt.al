reportextension 5266407 "lbt Draft Invoice" extends "ForNAV VAT Draft Invoice"
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
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                LineText := Line.lbtGetPrintData("lbt Position"::EditorLine, Line."Document Type".AsInteger());
            end;
        }
        add(VATClause)
        {
            column(lbtVATClauseDescriptionText; VATClause.GetDescriptionText(Header))
            {
                IncludeCaption = false;
            }
        }
    }

    rendering
    {
        layout(lbtconscoo)
        {
            Caption = 'conscoo', Locked = true;
            Type = Custom;
            MimeType = 'FORNAV';
            LayoutFile = 'Layouts\S. Draft Invoice.docx';
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