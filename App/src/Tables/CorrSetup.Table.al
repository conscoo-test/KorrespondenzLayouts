table 5272724 "lbt Corr Setup"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            NotBlank = false;
        }
        field(2; "Always print VAT"; Boolean)
        {
            Caption = 'Always print VAT';
        }
        field(3; "Copy Quote Texts"; Boolean)
        {
            Caption = 'Copy Quote Texts';
        }
        field(4; "Copy Blanket Order Texts"; Boolean)
        {
            Caption = 'Copy Blanket Order Texts';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}