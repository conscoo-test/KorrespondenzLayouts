permissionset 5266400 "lbt Extended Reports"
{
    Caption = 'Extended Reports', Locked = true;
    Assignable = true;
    Permissions = report "lbt Purchase Template" = X,
        report "lbt Sales Template" = X,
        report "lbt Draft Credit Memo" = X,
        codeunit "lbt Init Reports" = X;
}