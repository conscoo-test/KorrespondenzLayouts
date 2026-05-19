reportextension 5266410 "lbt Reminder" extends "ForNAV Reminder"
{
    dataset
    {
        add(Header)
        {
            column(lbtCompanyAddressLine; CompanyAddressLine)
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
            LayoutFile = 'Layouts\Reminder.docx';
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
}