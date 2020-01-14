table 5272726 "LBT Source Setup"
{
    // version LBCOR1.00

    // LBIS00     211218 MH   ERSTELLT   H19/0780

    Caption = 'LBT Source Setup', Comment = 'DEU="Herkunft Einrichtung"';

    fields
    {
        field(1;Type;Option)
        {
            Caption = 'Type', Comment = 'DEU="Art"';
            DataClassification = ToBeClassified;
            OptionCaption = 'Sales,Purchase', Comment = 'DEU="Verkauf,Einkauf"';
            OptionMembers = Sales,Purchase;
        }
        field(2;"Report Type";Option)
        {
            Caption = 'Report Type', Comment = 'DEU="Bericht Art"';
            DataClassification = ToBeClassified;
            OptionCaption = 'General,Sales Quote,Sales Order,Sales Pro Forma Inv,Blanket Sales Order,Purchase Quote,Purchase Order,Blanket Purchase Order', Comment = 'DEU="Allgemein,Verkauf - Angebot,Verkauf - Auftrag,Verkauf - Proformarechnung,Verkauf Rahmenauftrag,Einkauf - Anfrage,Einkauf - Bestellung,Einkauf Rahmenbestellung"';
            OptionMembers = General,"Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order","Purchase Quote","Purchase Order","Blanket Purchase Order";
        }
        field(3;"Source Type";Option)
        {
            Caption = 'Source Type', Comment = 'DEU="Herkunft Art"';
            DataClassification = ToBeClassified;
            OptionCaption = 'Default,Bill-to Customer,Sell-to Customer,Pay-to Vendor,Buy-from Vendor', Comment = 'DEU="Standard,Rech. an Debitor,Verk. an Debitor,Zahlung an Kreditor,Eink. von Kreditor"';
            OptionMembers = Default,"Bill-to Customer","Sell-to Customer","Pay-to Vendor","Buy-from Vendor";
        }
    }

    keys
    {
        key(Key1;Type,"Report Type")
        {
        }
    }

    fieldgroups
    {
    }
}

