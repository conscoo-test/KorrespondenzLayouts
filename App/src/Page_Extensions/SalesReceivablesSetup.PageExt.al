pageextension 5272746 "lbt Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    actions
    {
        addafter("Customer Disc. Groups")
        {
            action("lbt Source Setup")
            {
                ApplicationArea = All;
                Caption = 'Source Setup';
                ToolTip = 'Here you can define origin codes for certain reports.';
                Image = Print;
                RunObject = Page "lbt Source Setup";
                RunPageView = SORTING(Type, "Report Type")
                              WHERE(Type = FILTER(Sales));
            }
        }
    }
}

