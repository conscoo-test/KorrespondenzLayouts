tableextension 5272727 "LBT Purchases & Payables Setup" extends "Purchases & Payables Setup" 
{
    // version NAVW111.00,NAVDACH11.00,LBCOR1.00

    fields
    {
        field(5272720;"LBT Logo Position on Documents";Option)
        {
            Caption = 'Logo Position on Documents';
            Description = 'LBCOR';
            OptionCaption = 'No Logo,Left,Center,Right';
            OptionMembers = "No Logo",Left,Center,Right;
        }
    }
}

