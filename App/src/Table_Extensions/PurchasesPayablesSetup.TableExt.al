tableextension 50727 "lbt Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    // version NAVW111.00,NAVDACH11.00,LBCOR1.00

    fields
    {
        field(50720; "lbt Logo Position on Documents"; Option)
        {
            Caption = 'Logo Position on Documents';
            Description = 'LBCOR';
            OptionCaption = 'No Logo,Left,Center,Right';
            OptionMembers = "No Logo",Left,Center,Right;
            DataClassification = CustomerContent;
        }

        // field(50721; "lbt Archiving Purchase Quote"; Option)
        // {
        //     Caption = 'Archiving Purchase Quote';
        //     DataClassification = CustomerContent;
        //     OptionMembers = Never,Question,Always;
        // }
        // field(50722; "lbt Arch. Orders and Ret. Orders"; Boolean)
        // {
        //     Caption = 'Arch. Orders and Ret. Orders';
        //     DataClassification = CustomerContent;
        // }

    }
}

