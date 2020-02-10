pageextension 5272748 "lbt Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Appln. between Currencies")
        {
            field("lbt Logo Position on Documents"; "lbt Logo Position on Documents")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the position of your company logo on business letters and documents.', Comment = 'DEU=" Legt die Position des Firmenlogos für Firmenbriefpapier und Dokumente fest"';
            }
        }
    }
    actions
    {
        addafter("Incoming Documents Setup")
        {
            action("lbt Source Setup")
            {
                ApplicationArea = All;
                Caption = 'Source Setup', Comment = 'DEU="Herkunft Einrichtung"';
                ToolTip = 'Here you can define origin codes for certain reports.', Comment = 'DEU="Hier können Sie Herkunftscodes für bestimmte Berichte hinterlegen."';
                Image = Print;
                RunObject = Page "lbt Source Setup";
                RunPageView = SORTING (Type, "Report Type")
                              WHERE (Type = FILTER (Purchase));
            }
        }
    }
}

