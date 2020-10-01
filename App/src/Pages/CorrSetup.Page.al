page 5272728 "lbt Corr Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "lbt Corr Setup";
    Caption = 'Correspondence Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Always print VAT"; Rec."Always print VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'If selected VAT will be printed in reports even if it is 0.';
                }
            }
        }
    }

}