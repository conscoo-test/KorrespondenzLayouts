permissionset 5272720 "lbt ExtendedLayouts"
{
    Caption = 'ExtendedLayouts', Locked = true;
    Assignable = true;
    Permissions = report "lbt Blanket Purchase Order" = X,
        report "lbt Blanket Sales Order" = X,
        report "lbt cl Service Quote" = X,
        report "lbt Order" = X,
        report "lbt Order Confirmation" = X,
        report "lbt Purchase - Quote" = X,
        report "lbt Reminder" = X,
        report "lbt Return Order" = X,
        report "lbt Sales - Credit Memo" = X,
        report "lbt Sales - Invoice" = X,
        report "lbt Sales - Quote" = X,
        report "lbt Sales - Shipment" = X,
        report "lbt Sales pro forma Invoice" = X,
        codeunit "lbt AssistedSetup" = X,
        page "lbt Wizard" = X;
}