table 5272721 "lbt Posted PS Longtext Line"
{
    // version LBCOR1.00

    Caption = 'Posted Purch/Sales Longtext Line';
    DrillDownPageID = "lbt Posted PS Longtext Lines";
    LookupPageID = "lbt Posted PS Longtext Lines";
    PasteIsValid = false;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Table));
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            NotBlank = true;
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(4; Position; Option)
        {
            Caption = 'Position';
            OptionCaption = 'Header,Footer,Longtext';
            OptionMembers = Header,Footer,Longtext;
            DataClassification = CustomerContent;
        }
        field(5; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Text,New Page,Text + Line break';
            OptionMembers = Text,"New Page","Text + Line break";
            DataClassification = CustomerContent;
        }
        field(11; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST(Text)) "Standard Text";
            DataClassification = CustomerContent;
        }
        field(12; Description; Text[120])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(13; "Text"; BLOB)
        {
            Caption = 'Text';
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

