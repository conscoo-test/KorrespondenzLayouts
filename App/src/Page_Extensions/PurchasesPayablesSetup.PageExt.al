pageextension 5272748 "LBT Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Appln. between Currencies")
        {
            field("LBT Logo Position on Documents"; "LBT Logo Position on Documents")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the position of your company logo on business letters and documents.';
            }
        }
    }
    actions
    {
        addafter("Incoming Documents Setup")
        {
            action("LBT Source Setup")
            {
                ApplicationArea = All;
                Caption = 'Source Setup';
                ToolTip = 'Here you can define origin codes for certain reports.';
                Image = Print;
                RunObject = Page "LBT Source Setup";
                RunPageView = SORTING(Type, "Report Type")
                              WHERE(Type = FILTER(Purchase));
            }
        }
    }
}

