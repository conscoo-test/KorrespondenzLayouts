pageextension 5272746 "LBT Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    actions
    {
        addafter("Customer Disc. Groups")
        {
            action("LBT Source Setup")
            {
                ApplicationArea = All;
                Caption = 'Source Setup';
                ToolTip = 'Here you can define origin codes for certain reports.';
                Image = Print;
                RunObject = Page "LBT Source Setup";
                RunPageView = SORTING(Type, "Report Type")
                              WHERE(Type = FILTER(Sales));
            }
        }
    }
}

