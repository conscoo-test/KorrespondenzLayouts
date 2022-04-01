table 50723 "lbt Extended Text Line Long"
{
    // version LBCOR1.00

    Caption = 'Extended Text Line Long';
    DrillDownPageID = "lbt Ext. Text Lines Long";
    LookupPageID = "lbt Ext. Text Lines Long";

    fields
    {
        field(1; "Table_ID"; Enum "Extended Text Table Name")
        {
            Caption = 'Table ID';
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            TableRelation = if (Table_ID = const("Standard Text")) "Standard Text"
            else
            if (Table_ID = const("G/L Account")) "G/L Account"
            else
            if (Table_ID = const(Item)) Item
            else
            if (Table_ID = const(Resource)) Resource;
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

