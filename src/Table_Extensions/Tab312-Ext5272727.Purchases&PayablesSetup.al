tableextension 5272727 "LBT Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    // version NAVW111.00,NAVDACH11.00,LBCOR1.00

    fields
    {
        field(5272720; "LBT Logo Position on Documents"; Option)
        {
            Caption = 'Logo Position on Documents';
            Description = 'LBCOR';
            OptionCaption = 'No Logo,Left,Center,Right';
            OptionMembers = "No Logo",Left,Center,Right;
        }

        field(5272721; "Archiving Purchase Quote"; Option)
        {
            Caption = 'Archiving Purchase Quote';
            DataClassification = CustomerContent;
            OptionMembers = Never,Question,Always;
        }
        field(5272722; "Arch. Orders and Ret. Orders"; Boolean)
        {
            Caption = 'Arch. Orders and Ret. Orders';
            DataClassification = CustomerContent;
        }

    }
}

