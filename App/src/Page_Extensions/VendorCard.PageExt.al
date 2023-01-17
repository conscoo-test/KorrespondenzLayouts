pageextension 5272849 "lbt cl VendorCard" extends "Vendor Card"
{

    actions
    {
        addafter(VendorReportSelections)
        {
            action("lbt cl LongTexts")
            {
                Caption = 'Header and footer';
                ApplicationArea = All;
                Image = BeginningText;
                RunObject = page "lbt cl Longtext SysId";
                RunPageLink = "Source System Id" = field(SystemId), "Table Id" = const(23);
            }
        }
    }
}
