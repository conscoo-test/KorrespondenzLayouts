table 5272723 "LBT Extended Text Line Long"
{
    // version LBCOR1.00

    Caption = 'Extended Text Line Long';
    DrillDownPageID = "LBT Ext. Text Lines Long";
    LookupPageID = "LBT Ext. Text Lines Long";

    fields
    {
        field(1; "Table_ID"; Option)
        {
            Caption = 'Table ID';
            OptionCaption = 'Standard Text,G/L Account,Item,Resource';
            OptionMembers = "Standard Text","G/L Account",Item,Resource;
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
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
            Caption = 'Language Code';
            TableRelation = Language;
            DataClassification = CustomerContent;
        }
        field(4; "Text No."; Integer)
        {
            Caption = 'Text No.';
            DataClassification = CustomerContent;
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[120])
        {
            Caption = 'Description';
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

