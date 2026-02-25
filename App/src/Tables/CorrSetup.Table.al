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
            Caption = 'Copy Sales Quote Texts';
        }
        field(4; "Copy Blanket Order Texts"; Boolean)
        {
            Caption = 'Copy Sales Blanket Order Texts';
        }
        field(10; "S.Quote Automatic Numbering"; Boolean)
        {
            Caption = 'S.Quote Automatic Numbering', Comment = 'de-DE=Autom.Nummerierung VK-Angebot';
        }
        field(11; "S.Order Automatic Numbering"; Boolean)
        {
            Caption = 'S.Order Automatic Numbering', Comment = 'de-DE=Autom.Nummerierung VK-Auftrag';
        }
        field(12; "S.Invoice Automatic Numbering"; Boolean)
        {
            Caption = 'S.Invoice Automatic Numbering', Comment = 'de-DE=Autom.Nummerierung VK-Rechnung';
        }
        field(13; "S.Credit Memo Automatic Numbering"; Boolean)
        {
            Caption = 'S.Credit Memo Automatic Numbering', Comment = 'de-DE=Autom.Nummerierung VK-Gutschrift';
        }
        field(14; "S.Return Order Automatic Numbering"; Boolean)
        {
            Caption = 'S.Return Order Automatic Numbering', Comment = 'de-DE=Autom.Nummerierung VK-Reklamation';
        }
        field(15; "P.Quote Automatic Numbering"; Boolean)
        {
            Caption = 'P.Quote Automatic Numbering', Comment = 'de-DE=Autom.Nummerierung EK-Anfrage';
        }
        field(16; "P.Order Automatic Numbering"; Boolean)
        {
            Caption = 'P.Order Automatic Numbering', Comment = 'de-DE=Autom.Nummerierung EK-Bestellung';
        }
        field(17; "P.Invoice Automatic Numbering"; Boolean)
        {
            Caption = 'P.Invoice Automatic Numbering', Comment = 'de-DE=Autom.Nummerierung EK-Rechnung';
        }
        field(18; "P.Credit Memo Automatic Numbering"; Boolean)
        {
            Caption = 'P.Credit Memo Automatic Numbering', Comment = 'de-DE=Autom.Nummerierung EK-Gutschrift';
        }
        field(19; "P.Return Order Automatic Numbering"; Boolean)
        {
            Caption = 'P.Return Order Automatic Numbering', Comment = 'de-DE=Autom.Nummerierung EK-Rücksendung';
        }
        field(20; "S.Print select Copy order"; Boolean)
        {
            Caption = 'S. Print selection Copy offer to order', Comment = 'de-DE=Druckauswahl Angebot in Auftrag kopieren';
        }
        field(21; "Copy General Text From Order"; Boolean)
        {
            Caption = 'Copy Non-Specific Text From Order', Comment = 'de-DE=Nicht spezifische Texte aus Auftrag kopieren';
        }
        field(22; "Copy ServiceQuote Texts"; Boolean)
        {
            Caption = 'Copy Service Quote Texts', Comment = 'de-DE=Serviceangebotstexte kopieren';
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