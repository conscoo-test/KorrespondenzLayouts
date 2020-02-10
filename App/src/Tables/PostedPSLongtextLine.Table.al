table 5272721 "lbt Posted PS Longtext Line"
{
    // version LBCOR1.00

    Caption = 'Posted Purch/Sales Longtext Line', Comment = 'DEU="Geb. EK/VK Langtext Zeile"';
    DrillDownPageID = "lbt Posted PS Longtext Lines";
    LookupPageID = "lbt Posted PS Longtext Lines";
    PasteIsValid = false;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID', Comment = 'DEU="Tabellen ID"';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Table));
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.', Comment = 'DEU="Belegnr."';
            NotBlank = true;
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
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
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'DEU="Zeilennr."';
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
        key(Key1; "Table ID", "Document No.", Position, "Document Line No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

