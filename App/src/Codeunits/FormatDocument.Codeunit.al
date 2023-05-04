codeunit 5272728 "lbt Format Document"
{
    var
        CompanyInformation: Record "Company Information";
        CompanyInformationRef: RecordRef;
        BankCaptionLbl: Label 'Bank';
        BoldLbl: Label '<b>%1</b>', Locked = true;
        CEOCaptionLbl: Label 'Chief Executive Officer';
        FaxCaptionLbl: Label 'Fax';
        FieldLbl: Label '<b>%1</b> %2', Locked = true;

        //         ="<b>" & Fields!CompanyInfo__LeBit_Trade_Register_Name_Caption.Value & "</b>" & " " & Fields!CompanyInfo__LeBit_Trade_Register_Name.Value & " " & Fields!NoCaption.Value &
        //  " " & Fields!CompanyInfo__LeBit_Commercial_Register_No.Value & " | " & "<b>" & Fields!CompanyInfo__LeBit_CEO_Caption.Value & "</b>" & " " & Fields!CompanyInfo__LeBit_CEO1.Value &
        //  IIF(Fields!CompanyInfo__LeBit_CEO2.Value = "","",", " & Fields!CompanyInfo__LeBit_CEO2.Value) & IIF(Fields!CompanyInfo__LeBit_CEO3.Value = "","",", " & Fields!CompanyInfo__LeBit_CEO3.Value) &
        //  " | " & "<b>" & Fields!CompanyInfo__VAT_Registration_No__Caption.Value & "</b>" & " " & Fields!CompanyInfo__VAT_Registration_No__.Value
        PhoneCaptionLbl: Label 'Phone';
        RegNoCaptionLbl: Label 'Registered in';
        StandardTotalLbl: Label 'Total', Locked = true;
        TranslatedTotalLbl: Label 'Total';
        VatRegNoCaptionLbl: Label 'VAT Reg. No.';

    procedure SetReportFooter(var Footer: Text)
    var
        Lines: List of [Text];
    begin
        CompanyInformation.Get();
        CompanyInformationRef.GetTable(CompanyInformation);

        AddToList(Lines, StrSubstNo(BoldLbl, CompanyInformation.Name));
        AddToList(Lines, GetSecondLine());
        AddToList(Lines, GetThirdLine());
        AddToList(Lines, GetBankLine(CompanyInformation."Bank Name", CompanyInformation.IBAN, CompanyInformation."SWIFT Code"));
        AddToList(Lines, GetBankLine(CompanyInformation."lbt Bank Name 2", CompanyInformation."lbt IBAN 2", CompanyInformation."lbt SWIFT Code 2"));
        AddToList(Lines, GetBankLine(CompanyInformation."lbt Bank Name 3", CompanyInformation."lbt IBAN 3", CompanyInformation."lbt SWIFT Code 3"));
        Footer := GetListText(Lines, '<br/>');
    end;

    procedure SetTotalLabels(CurrencyCode: Code[10]; var TotalText: Text[50]; var TotalInclVATText: Text[50]; var TotalExclVATText: Text[50])
    var
        FormatDocument: Codeunit "Format Document";
    begin
        FormatDocument.SetTotalLabels(CurrencyCode, TotalText, TotalInclVATText, TotalExclVATText);
        TotalText := CopyStr(TotalText.Replace(StandardTotalLbl, TranslatedTotalLbl), 1, MaxStrLen(TotalText));
    end;

    procedure CompanyAddressLine() CompanyAddressLine: Text
    var
        FormatAddress: Codeunit "Format Address";
        CompanyAddr: array[8] of Text[100];
        i: Integer;
    begin
        CompanyInformation.Get();
        FormatAddress.Company(CompanyAddr, CompanyInformation);
        for i := 1 to 6 do
            if CompanyAddr[i] <> '' then begin
                if CompanyAddressLine <> '' then
                    CompanyAddressLine := CompanyAddressLine + ', ';
                CompanyAddressLine := CompanyAddressLine + CompanyAddr[i];
            end;
    end;

    local procedure AddToList(var list: List of [Text]; Element: Text)
    begin
        if Element = '' then
            exit;
        list.Add(Element);
    end;

    local procedure GetBankLine(BankName: Text[100]; IBAN: Code[50]; SWIFTCode: Code[20]): Text
    var
        Fields: List of [Text];
    begin
        if BankName = '' then
            exit;
        AddToList(Fields, StrSubstNo(FieldLbl, BankCaptionLbl, BankName));
        AddToList(Fields, StrSubstNo(FieldLbl, CompanyInformation.FieldCaption(IBAN), IBAN));
        AddToList(Fields, StrSubstNo(FieldLbl, CompanyInformation.FieldCaption("SWIFT Code"), SWIFTCode));
        exit(GetListText(Fields, ' | '));
    end;

    local procedure GetFieldCaptionAndValue(FieldNo: Integer): Text
    var
        FRef: FieldRef;
    begin
        FRef := CompanyInformationRef.Field(FieldNo);
        exit(StrSubstNo(FieldLbl, FRef.Caption, Format(FRef.Value)))
    end;

    local procedure GetListText(list: List of [Text]; Seperator: Text): Text
    var
        Element: Text;
        Result: TextBuilder;
    begin
        foreach Element in list do
            Result.Append(Element + Seperator);
        if Result.Length > 0 then
            Result.Remove(Result.Length - StrLen(Seperator) + 1, StrLen(Seperator));
        exit(Result.ToText())
    end;

    local procedure GetSecondLine(): Text
    var
        Fields: List of [Text];
    begin
        AddToList(Fields, StrSubstNo(BoldLbl, CompanyInformation.Address));
        AddToList(Fields, StrSubstNo(BoldLbl, CompanyInformation."Post Code" + ' ' + CompanyInformation.City));
        AddToList(Fields, StrSubstNo(FieldLbl, PhoneCaptionLbl, CompanyInformation."Phone No."));
        AddToList(Fields, StrSubstNo(FieldLbl, FaxCaptionLbl, CompanyInformation."Fax No."));
        AddToList(Fields, GetFieldCaptionAndValue(CompanyInformation.FieldNo("E-Mail")));
        AddToList(Fields, GetFieldCaptionAndValue(CompanyInformation.FieldNo("Home Page")));
        exit(GetListText(Fields, ' | '));
    end;

    local procedure GetThirdLine(): Text
    var
        CEOs: List of [Text];
        Fields: List of [Text];
        TradeRegister: Text;
    begin
        TradeRegister := CompanyInformation."lbt Trade Register Name" + ' ' + CompanyInformation."lbt Commercial Register No.";
        AddToList(Fields, StrSubstNo(FieldLbl, RegNoCaptionLbl, TradeRegister));
        AddToList(CEOs, CompanyInformation."lbt CEO1");
        AddToList(CEOs, CompanyInformation."lbt CEO2");
        AddToList(CEOs, CompanyInformation."lbt CEO3");
        AddToList(Fields, StrSubstNo(FieldLbl, CEOCaptionLbl, GetListText(CEOs, ', ')));
        AddToList(Fields, StrSubstNo(FieldLbl, VatRegNoCaptionLbl, CompanyInformation."VAT Registration No."));
        exit(GetListText(Fields, ' | '));
    end;
}