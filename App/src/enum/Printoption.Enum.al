enum 5272723 "lbt cl Printoption"
{
    Extensible = false;

    value(0; Standard)
    {
        Caption = 'Standard', Comment = 'de-DE=Normal';
    }
    value(1; Title)
    {
        Caption = 'Title', Comment = 'de-DE=Überschrift';
    }
    value(2; Total)
    {
        ObsoleteState = Pending;
        ObsoleteReason = 'Old value';
        ObsoleteTag = '2024-12-06';
        Caption = 'Total', Comment = 'de-DE=Summe';
    }
    value(3; "Price Invisible")
    {
        Caption = 'Price Invisible', Comment = 'de-DE=Preis unsichtbar';
    }
    value(4; "Line Invisible")
    {
        Caption = 'Line Invisible', Comment = 'de-DE=Zeile unsichtbar';
    }
    value(5; Alternative)
    {
        Caption = 'Alternative', Comment = 'de-DE=Alternativposition';
    }
    value(6; Optional)
    {
        Caption = 'Optional', Comment = 'de-DE=Bedarfsposition';
    }
    value(7; "New Page")
    {
        Caption = 'New Page', Comment = 'de-DE=Seitenwechsel';
    }
    value(8; "Begin Total")
    {
        Caption = 'Begin Total', Comment = 'de-DE=Von Summe';
    }
    value(9; "End Total")
    {
        Caption = 'End Total', Comment = 'de-DE=Bis Summe';
    }
    value(10; Bold)
    {
        Caption = 'Bold', Comment = 'de-DE=Fett';
    }
}