tableextension 5272736 "LBT Company Information" extends "Company Information" 
{
    // version NAVW111.00,NAVDACH11.00,LBCOR1.00

    fields
    {
        field(5272720;"LBT CEO1";Text[60])
        {
            Caption = 'CEO1', Comment = 'DEU="Geschäftsführer1"';
        }
        field(5272721;"LBT CEO2";Text[60])
        {
            Caption = 'CEO2', Comment = 'DEU="Geschäftsführer2"';
        }
        field(5272722;"LBT CEO3";Text[60])
        {
            Caption = 'CEO3', Comment = 'DEU="Geschäftsführer3"';
        }
        field(5272723;"LBT Commercial Register No.";Text[50])
        {
            Caption = 'Commercial Register', Comment = 'DEU="Handelsregister-Nr."';
        }
        field(5272724;"LBT Trade Register Name";Text[80])
        {
            Caption = 'Trade Register Name', Comment = 'DEU="Handelsregister Name"';
        }
        field(5272725;"LBT Bank Name 2";Text[50])
        {
            Caption = 'Bank Name 2', Comment = 'DEU="Bankname 2"';
        }
        field(5272726;"LBT Bank Branch No. 2";Text[20])
        {
            Caption = 'Bank Branch No. 2', Comment = 'DEU="BLZ 2"';
        }
        field(5272727;"LBT Bank Account No. 2";Text[30])
        {
            Caption = 'Bank Account No. 2', Comment = 'DEU="Bankkontonummer 2"';
        }
        field(5272728;"LBT IBAN 2";Code[50])
        {
            Caption = 'IBAN 2', Comment = 'DEU="IBAN 2"';

            trigger OnValidate()
            begin
                CheckIBAN(IBAN);
            end;
        }
        field(5272729;"LBT SWIFT Code 2";Code[20])
        {
            Caption = 'SWIFT Code 2', Comment = 'DEU="SWIFT-Code 2"';
        }
        field(5272730;"LBT Bank Name 3";Text[50])
        {
            Caption = 'Bank Name 3', Comment = 'DEU="Bankname 2"';
        }
        field(5272731;"LBT Bank Branch No. 3";Text[20])
        {
            Caption = 'Bank Branch No. 3', Comment = 'DEU="BLZ 3"';
        }
        field(5272732;"LBT Bank Account No. 3";Text[30])
        {
            Caption = 'Bank Account No. 3', Comment = 'DEU="Bankkontonr. 3"';
        }
        field(5272733;"LBT IBAN 3";Code[50])
        {
            Caption = 'IBAN 3', Comment = 'DEU="IBAN 3"';

            trigger OnValidate()
            begin
                CheckIBAN(IBAN);
            end;
        }
        field(5272734;"LBT SWIFT Code 3";Code[20])
        {
            Caption = 'SWIFT Code 3', Comment = 'DEU="SWIFT-Code 3"';
        }
        field(5272735;"LBT District Court";Text[50])
        {
            Caption = 'District Court', Comment = 'DEU="Amtsgericht"';
        }
    }
}

