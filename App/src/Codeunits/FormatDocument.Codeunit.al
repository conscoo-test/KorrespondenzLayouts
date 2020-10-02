codeunit 5272728 "lbt Format Document"
{
    procedure SetTotalLabels(CurrencyCode: Code[10]; var TotalText: Text[50]; var TotalInclVATText: Text[50]; var TotalExclVATText: Text[50])
    var
        FormatDocument: Codeunit "Format Document";
    begin
        FormatDocument.SetTotalLabels(CurrencyCode, TotalText, TotalInclVATText, TotalExclVATText);
        TotalText := CopyStr(TotalText.Replace(StandardTotalLbl, TranslatedTotalLbl), 1, MaxStrLen(TotalText));
    end;

    var
        StandardTotalLbl: Label 'Total', Locked = true;
        TranslatedTotalLbl: Label 'Total';
}