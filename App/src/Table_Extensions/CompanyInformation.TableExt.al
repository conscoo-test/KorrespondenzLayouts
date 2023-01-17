tableextension 5272736 "lbt Company Information" extends "Company Information"
{
    // version NAVW111.00,NAVDACH11.00,LBCOR1.00

    fields
    {
        field(5272720; "lbt CEO1"; Text[60])
        {
            Caption = 'CEO1';
            DataClassification = CustomerContent;
        }
        field(5272721; "lbt CEO2"; Text[60])
        {
            Caption = 'CEO2';
            DataClassification = CustomerContent;
        }
        field(5272722; "lbt CEO3"; Text[60])
        {
            Caption = 'CEO3';
            DataClassification = CustomerContent;
        }
        field(5272723; "lbt Commercial Register No."; Text[50])
        {
            Caption = 'Commercial Register';
            DataClassification = CustomerContent;
        }
        field(5272724; "lbt Trade Register Name"; Text[80])
        {
            Caption = 'Trade Register Name';
            DataClassification = CustomerContent;
        }
        field(5272725; "lbt Bank Name 2"; Text[50])
        {
            Caption = 'Bank Name 2';
            DataClassification = CustomerContent;
        }
        field(5272726; "lbt Bank Branch No. 2"; Text[20])
        {
            Caption = 'Bank Branch No. 2';
            DataClassification = CustomerContent;
        }
        field(5272727; "lbt Bank Account No. 2"; Text[30])
        {
            Caption = 'Bank Account No. 2';
            DataClassification = CustomerContent;
        }
        field(5272728; "lbt IBAN 2"; Code[50])
        {
            Caption = 'IBAN 2';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckIBAN(IBAN);
            end;
        }
        field(5272729; "lbt SWIFT Code 2"; Code[20])
        {
            Caption = 'SWIFT Code 2';
            DataClassification = CustomerContent;
        }
        field(5272730; "lbt Bank Name 3"; Text[50])
        {
            Caption = 'Bank Name 3';
            DataClassification = CustomerContent;
        }
        field(5272731; "lbt Bank Branch No. 3"; Text[20])
        {
            Caption = 'Bank Branch No. 3';
            DataClassification = CustomerContent;
        }
        field(5272732; "lbt Bank Account No. 3"; Text[30])
        {
            Caption = 'Bank Account No. 3';
            DataClassification = CustomerContent;
        }
        field(5272733; "lbt IBAN 3"; Code[50])
        {
            Caption = 'IBAN 3';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckIBAN(IBAN);
            end;
        }
        field(5272734; "lbt SWIFT Code 3"; Code[20])
        {
            Caption = 'SWIFT Code 3';
            DataClassification = CustomerContent;
        }
        field(5272735; "lbt District Court"; Text[50])
        {
            Caption = 'District Court';
            DataClassification = CustomerContent;
        }
        field(5272736; "lbt Setup finished"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    procedure "lbt SetReportFooter"(var Footer: Text)
    var
        FormatDocument: Codeunit "lbt Format Document";
        Handled: Boolean;
    begin
        lbtOnBeforeSetReportFooter(Footer, Handled);
        if not Handled then
            FormatDocument.SetReportFooter(Footer);
    end;

    [IntegrationEvent(false, false)]
    local procedure lbtOnBeforeSetReportFooter(var Footer: Text; var Handled: Boolean)
    begin
    end;
}
