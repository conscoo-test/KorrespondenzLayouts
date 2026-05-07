reportextension 5266405 "lbt Sales Shipment" extends "ForNAV Sales Shipment"
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
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                LineText := Line.lbtGetPrintData("lbt Position"::EditorLine);
            end;
        }
    }
    rendering
    {
        layout("lbtconscoo")
        {
            Caption = 'conscoo', Locked = true;
            Type = Custom;
            MimeType = 'FORNAV';
            LayoutFile = 'Layouts\S. Shipment.docx';
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