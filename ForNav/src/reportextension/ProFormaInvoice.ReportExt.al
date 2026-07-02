reportextension 5266401 "lbt Pro Forma Invoice" extends "ForNAV VAT Pro Forma Invoice"
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
                HeaderText := Header.lbtGetPrintData("lbt Position"::EditorHeader, Header."Document Type"::Invoice.AsInteger());
                FooterText := Header.lbtGetPrintData("lbt Position"::EditorFooter, Header."Document Type"::Invoice.AsInteger());
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
        layout("lbtconscoo")
        {
            Caption = 'conscoo', Locked = true;
            Type = Custom;
            MimeType = 'FORNAV';
            LayoutFile = 'Layouts\S. Pro Forma Invoice.docx';
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