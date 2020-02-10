table 5272723 "lbt Extended Text Line Long"
{
    // version LBCOR1.00

    Caption = 'Extended Text Line Long', Comment = 'DEU="Textbausteinzeile Lang"';
    DrillDownPageID = "lbt Ext. Text Lines Long";
    LookupPageID = "lbt Ext. Text Lines Long";

    fields
    {
        field(1; "Table_ID"; Option)
        {
            Caption = 'Table ID', Comment = 'DEU="Tabellen ID<"';
            OptionCaption = 'Standard Text,G/L Account,Item,Resource', Comment = 'DEU="Standard Text,Sachkonto,Artikel,Ressource"';
            OptionMembers = "Standard Text","G/L Account",Item,Resource;
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'DEU="Nr."';
            NotBlank = true;
            TableRelation = IF (Table_ID = CONST("Standard Text")) "Standard Text"
            ELSE
            IF (Table_ID = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Table_ID = CONST(Item)) Item
            ELSE
            IF (Table_ID = CONST(Resource)) Resource;
            DataClassification = CustomerContent;
        }
        field(3; "Language Code"; Code[10])
        {
            Caption = 'Language Code', Comment = 'DEU="Sprachcode"';
            TableRelation = Language;
            DataClassification = CustomerContent;
        }
        field(4; "Text No."; Integer)
        {
            Caption = 'Text No.', Comment = 'DEU="Text Nr."';
            DataClassification = CustomerContent;
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'DEU="Zeilennr."';
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[120])
        {
            Caption = 'Description', Comment = 'DEU="Beschreibung"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Table_ID, "No.", "Language Code", "Text No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

