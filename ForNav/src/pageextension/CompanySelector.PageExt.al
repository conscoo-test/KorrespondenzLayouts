pageextension 5266401 "lbt Company Selector" extends "Company Selector"
{
    internal procedure lbtGetSelectedCompany(var SelectedCompany: Record Company temporary)
    begin
        CurrPage.SetSelectionFilter(SelectedCompany);
    end;

    internal procedure lbtSetCompanies(var Company: Record Company temporary)
    begin
        if not Company.FindSet() then
            exit;
        repeat
            Rec.TransferFields(Company);
            Rec.Insert();
        until Company.Next() = 0;
    end;
}