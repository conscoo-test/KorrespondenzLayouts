table 50726 "lbt Source Setup"
{
    // version LBCOR1.00

    // LBIS00     211218 MH   ERSTELLT   H19/0780

    Caption = 'lbt Source Setup';
    LookupPageId = "lbt Source Setup";
    DrillDownPageId = "lbt Source Setup";
    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Sales,Purchase';
            OptionMembers = Sales,Purchase;
        }
        field(2; "Report Type"; Option)
        {
            Caption = 'Report Type';
            DataClassification = CustomerContent;
            OptionCaption = 'General,Sales Quote,Sales Order,Sales Pro Forma Inv,Blanket Sales Order,Purchase Quote,Purchase Order,Blanket Purchase Order';
            OptionMembers = General,"Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order","Purchase Quote","Purchase Order","Blanket Purchase Order";
        }
        field(3; "Source Type"; Option)
        {
            Caption = 'Source Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Default,Bill-to Customer,Sell-to Customer,Pay-to Vendor,Buy-from Vendor';
            OptionMembers = Default,"Bill-to Customer","Sell-to Customer","Pay-to Vendor","Buy-from Vendor";
        }
    }

    keys
    {
        key(Key1; Type, "Report Type")
        {
        }
    }

    fieldgroups
    {
    }
}

