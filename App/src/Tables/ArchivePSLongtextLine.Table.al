table 5272722 "lbt Archive PS Longtext Line"
{
    // version LBCOR1.00

    DrillDownPageID = "lbt Arch. PS Longtext Lines";
    LookupPageID = "lbt Arch. PS Longtext Lines";
    PasteIsValid = false;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID', Comment = 'DEU="Tabellen ID"';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Table));
            DataClassification = CustomerContent;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type', Comment = 'DEU="Belegart"';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Shipment/Receipt', Comment = 'DEU="Angebot,Auftrag/Bestellung,Rechnung,Gutschrift,Rahmenauftrag/Rahmenbestellung,Reklamation,Lieferschein"';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Shipment/Receipt";
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.', Comment = 'DEU="Belegnr."';
            NotBlank = true;
            TableRelation = IF ("Table ID" = CONST(5107)) "Sales Header Archive"."No." WHERE("Document Type" = FIELD("Document Type"))
            ELSE
            IF ("Table ID" = CONST(5109)) "Purchase Header Archive"."No." WHERE("Document Type" = FIELD("Document Type"));
            DataClassification = CustomerContent;
        }
        field(4; Position; Option)
        {
            Caption = 'Position', Comment = 'DEU="Position"';
            OptionCaption = 'Header,Footer,Longtext', Comment = 'DEU="Kopf,Fuß,Langtext"';
            OptionMembers = Header,Footer,Longtext;
            DataClassification = CustomerContent;
        }
        field(5; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.', Comment = 'DEU="Beleg Zeilennr."';
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'DEU="Zeilennr."';
            DataClassification = CustomerContent;
        }
        field(7; "Version No."; Integer)
        {
            Caption = 'Version No.', Comment = 'DEU="Versionsnr."';
            DataClassification = CustomerContent;
        }
        field(8; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence', Comment = 'DEU="Belegnr.-Häufigkeit"';
            DataClassification = CustomerContent;
        }
        field(10; Type; Option)
        {
            Caption = 'Type', Comment = 'DEU="Art"';
            OptionCaption = 'Text,New Page,Text + Line break', Comment = 'DEU="Text,Neue Seite, Text + Zeilenumbruch"';
            OptionMembers = Text,"New Page","Text + Line break";
            DataClassification = CustomerContent;
        }
        field(11; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'DEU="Nr."';
            TableRelation = IF (Type = CONST(Text)) "Standard Text";
            DataClassification = CustomerContent;
        }
        field(12; Description; Text[120])
        {
            Caption = 'Description', Comment = 'DEU="Beschreibung"';
            DataClassification = CustomerContent;
        }
        field(13; "Text"; BLOB)
        {
            Caption = 'Text', Comment = 'DEU="Text"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Table ID", "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", Position, "Document Line No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

