report 5272731 "lbt Reminder"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Reminder.Report.rdlc';
    Caption = 'Reminder';

    dataset
    {
        dataitem("Issued Reminder Header"; "Issued Reminder Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Reminder';
            column(No_IssuedReminderHeader; "No.")
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            column(DocType_IssuedReminderLineCaption; "Issued Reminder Line".FIELDCAPTION("Document Type"))
            {
            }
            column(DocNo_IssuedReminderLineCaption; "Issued Reminder Line".FIELDCAPTION("Document No."))
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(OriginalAmt_IssuedReminderLineCaption; "Issued Reminder Line".FIELDCAPTION("Original Amount"))
            {
            }
            column(RemainingAmt_IssuedReminderLineCaption; "Issued Reminder Line".FIELDCAPTION("Remaining Amount"))
            {
            }
            column(HideCompanyInfo; HideCompanyInfo)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(CompanyInfo1Picture; CompanyInfo1.Picture)
                {
                }
                column(CompanyInfo2Picture; CompanyInfo2.Picture)
                {
                }
                column(CompanyInfo3Picture; CompanyInfo3.Picture)
                {
                }
                column(CompanyAddressLine; CompanyAddressLine)
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CustAddr3; CustAddr[3])
                {
                }
                column(CustAddr4; CustAddr[4])
                {
                }
                column(CustAddr5; CustAddr[5])
                {
                }
                column(CustAddr6; CustAddr[6])
                {
                }
                column(CustAddr7; CustAddr[7])
                {
                }
                column(CustAddr8; CustAddr[8])
                {
                }
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
                {
                }
                column(CompanyInfo_Address; CompanyInfo.Address)
                {
                }
                column(CompanyInfo__Post_Code; CompanyInfo."Post Code")
                {
                }
                column(CompanyInfo_City; CompanyInfo.City)
                {
                }
                column(CompanyInfo__Phone_No; CompanyInfo."Phone No.")
                {
                }
                column(CompanyInfo__Fax_No; CompanyInfo."Fax No.")
                {
                }
                column(CompanyInfo_E_Mail; CompanyInfo."E-Mail")
                {
                }
                column(CompanyInfo__Home_Page; CompanyInfo."Home Page")
                {
                }
                column(CompanyInfo__LeBit_CEO1; CompanyInfo."lbt CEO1")
                {
                }
                column(CompanyInfo__LeBit_CEO2; CompanyInfo."lbt CEO2")
                {
                }
                column(CompanyInfo__LeBit_CEO3; CompanyInfo."lbt CEO3")
                {
                }
                column(CompanyInfo__LeBit_Commercial_Register_No; CompanyInfo."lbt Commercial Register No.")
                {
                }
                column(CompanyInfo__LeBit_Trade_Register_Name; CompanyInfo."lbt Trade Register Name")
                {
                }
                column(CompanyInfo__Bank_Name; CompanyInfo."Bank Name")
                {
                }
                column(CompanyInfo_IBAN; CompanyInfo.IBAN)
                {
                }
                column(CompanyInfo__SWIFT_Code; CompanyInfo."SWIFT Code")
                {
                }
                column(CompanyInfo__LeBit_Bank_Name_2; CompanyInfo."lbt Bank Name 2")
                {
                }
                column(CompanyInfo__LeBit_IBAN_2; CompanyInfo."lbt IBAN 2")
                {
                }
                column(CompanyInfo__LeBit_SWIFT_Code_2; CompanyInfo."lbt SWIFT Code 2")
                {
                }
                column(CompanyInfo__LeBit_Bank_Name_3; CompanyInfo."lbt Bank Name 3")
                {
                }
                column(CompanyInfo__LeBit_IBAN_3; CompanyInfo."lbt IBAN 3")
                {
                }
                column(CompanyInfo__LeBit_SWIFT_Code_3; CompanyInfo."lbt SWIFT Code 3")
                {
                }
                column(DueDate_IssuedReminderHdr; FORMAT("Issued Reminder Header"."Due Date"))
                {
                }
                column(PostingDate_IssuedReminderHdr; FORMAT("Issued Reminder Header"."Posting Date"))
                {
                }
                column(DocDate_IssuedReminderHdr; FORMAT("Issued Reminder Header"."Document Date"))
                {
                }
                column(YourReference_IssuedReminderHdr; "Issued Reminder Header"."Your Reference")
                {
                }
                column(VATRegNo_IssuedReminderHdr; "Issued Reminder Header"."VAT Registration No.")
                {
                }
                column(CustNo_IssuedReminderHdr; "Issued Reminder Header"."Customer No.")
                {
                }
                column(ReferenceText; ReferenceText)
                {
                }
                column(VATNoText; VATNoText)
                {
                }
                column(TextPage; TextPageLbl)
                {
                }
                column(CompanyInfo__VAT_Registration_No__Caption; CompanyInfo__VAT_Registration_No__CaptionLbl)
                {
                }
                column(CompanyInfo__Phone_No__Caption; PhoneNoCaptionLbl)
                {
                }
                column(CompanyInfo__Fax_No__Caption; FaxNoCaptionLbl)
                {
                }
                column(CompanyInfo__LeBit_Trade_Register_Name_Caption; CompanyInfo__LeBit_Trade_Register_Name_Caption_Lbl)
                {
                }
                column(CompanyInfo__LeBit_CEO_Caption; CompanyInfo__LeBit_CEO_Caption_Lbl)
                {
                }
                column(CompanyInfo__Bank_Name_Caption; BankNameCaptionLbl)
                {
                }
                column(CompanyInfo_IBAN_Caption; CompanyInfo_IBAN_Caption_Lbl)
                {
                }
                column(CompanyInfo__SWIFT_Code_Caption; CompanyInfo__SWIFT_Code_Caption_Lbl)
                {
                }
                column(CompanyInfo_E_Mail_Caption; CompanyInfo_E_Mail_Caption_Lbl)
                {
                }
                column(CompanyInfo__Home_Page_Caption; CompanyInfo__Home_Page_Caption_Lbl)
                {
                }
                column(DatumCaption; DatumCaptionLbl)
                {
                }
                column(ReminderHeaderNoCaption; ReminderHeaderNoCaptionLbl)
                {
                }
                column(PostingDateCaption; PostingDateCaptionLbl)
                {
                }
                column(BankAccountNoCaption; BankAccountNoCaptionLbl)
                {
                }
                column(BankNameCaption; BankNameCaptionLbl)
                {
                }
                column(GiroNoCaption; GiroNoCaptionLbl)
                {
                }
                column(VATRegNoCaption; VATRegNoCaptionLbl)
                {
                }
                column(PhoneNoCaption; PhoneNoCaptionLbl)
                {
                }
                column(ReminderCaption; DocumentCaption())
                {
                }
                column(CustNo_IssuedReminderHdrCaption; "Issued Reminder Header".FIELDCAPTION("Customer No."))
                {
                }
                column(CarryForwardText; STRSUBSTNO(CarryForwardCaptionLbl, GLSetup."LCY Code"))
                {
                }
                column(SubtotalCaption; SubtotalCaptionLbl)
                {
                }
                column(PagefromPageCaption; PagefromPageCaptionLbl)
                {
                }
                column(NoCaption; NoCaptionLbl)
                {
                }
                column(FromCaption; FromCaptionLbl)
                {
                }
                column(VAT_Registration_No__Caption; VAT_Registration_No__CaptionLbl)
                {
                }
                dataitem(DimensionLoop; "Integer")
                {
                    DataItemLinkReference = "Issued Reminder Header";
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    column(DimText; DimText)
                    {
                    }
                    column(Number_Integer; DimensionLoop.Number)
                    {
                    }
                    column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if Number = 1 then begin
                            if not DimSetEntry.FindSet() then
                                CurrReport.Break();
                        end else
                            if not Continue then
                                CurrReport.Break();

                        CLEAR(DimText);
                        Continue := false;
                        repeat
                            OldDimText := DimText;
                            if DimText = '' then
                                DimText := STRSUBSTNO('%1 - %2', DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
                            else
                                DimText :=
                                  STRSUBSTNO(
                                    '%1; %2 - %3', DimText,
                                    DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                            if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                DimText := OldDimText;
                                Continue := true;
                                exit;
                            end;
                        until DimSetEntry.Next() = 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if not ShowInternalInfo then
                            CurrReport.Break();
                    end;
                }
                dataitem("Issued Reminder Line"; "Issued Reminder Line")
                {
                    DataItemLink = "Reminder No." = FIELD("No.");
                    DataItemLinkReference = "Issued Reminder Header";
                    DataItemTableView = SORTING("Reminder No.", "Line No.");
                    column(RemainingAmt_IssuedReminderLine; "Remaining Amount")
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader();
                        AutoFormatType = 1;
                    }
                    column(StartLineNo; StartLineNo)
                    {
                    }
                    column(LineNo_IssuedReminderLine; "Line No.")
                    {
                    }
                    column(Description_IssuedReminderLine; Description)
                    {
                    }
                    column(Type; FORMAT("Issued Reminder Line".Type, 0, 2))
                    {
                    }
                    column(DocDate_IssuedReminderLine; FORMAT("Document Date"))
                    {
                    }
                    column(DocNo_IssuedReminderLine; "Document No.")
                    {
                    }
                    column(DueDate_IssuedReminderLine; FORMAT("Due Date"))
                    {
                    }
                    column(OriginalAmt_IssuedReminderLine; "Original Amount")
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader();
                        AutoFormatType = 1;
                    }
                    column(DocType_IssuedReminderLine; "Document Type")
                    {
                    }
                    column(No_IssuedReminderLine; "No.")
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(NNCInterestAmount; NNC_InterestAmount)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(NNCTotal; NNC_Total)
                    {
                    }
                    column(TotalInclVATText; TotalInclVATText)
                    {
                    }
                    column(NNCVATAmount; NNC_VATAmount)
                    {
                    }
                    column(NNCTotalInclVAT; NNC_TotalInclVAT)
                    {
                    }
                    column(TotalVATAmt; TotalVATAmount)
                    {
                    }
                    column(ReminderNo_IssuedReminderLine; "Reminder No.")
                    {
                    }
                    column(InterestAmountCaption; InterestAmountCaptionLbl)
                    {
                    }
                    column(Interest; Interest)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VATAmountLine.Init();
                        VATAmountLine."VAT Identifier" := "VAT Identifier";
                        VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                        VATAmountLine."Tax Group Code" := "Tax Group Code";
                        VATAmountLine."VAT %" := "VAT %";
                        VATAmountLine."VAT Base" := Amount;
                        VATAmountLine."VAT Amount" := "VAT Amount";
                        VATAmountLine."Amount Including VAT" := Amount + "VAT Amount";
                        VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                        VATAmountLine.InsertLine();

                        case Type of
                            Type::"G/L Account":
                                "Remaining Amount" := Amount;
                            Type::"Line Fee":
                                "Remaining Amount" := Amount;
                            Type::"Customer Ledger Entry":
                                ReminderInterestAmount := Amount;
                        end;

                        NNC_InterestAmountTotal += ReminderInterestAmount;
                        NNC_RemainingAmountTotal += "Remaining Amount";
                        NNC_VATAmountTotal += "VAT Amount";

                        NNC_InterestAmount := (NNC_InterestAmountTotal + NNC_VATAmountTotal + "Issued Reminder Header"."Additional Fee" -
                                               AddFeeInclVAT + "Issued Reminder Header"."Add. Fee per Line" - AddFeePerLineInclVAT) /
                          (VATInterest / 100 + 1);
                        NNC_Total := NNC_RemainingAmountTotal + NNC_InterestAmountTotal;
                        NNC_VATAmount := NNC_VATAmountTotal;
                        NNC_TotalInclVAT := NNC_RemainingAmountTotal + NNC_InterestAmountTotal + NNC_VATAmountTotal;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if FIND('-') then begin
                            StartLineNo := 0;
                            repeat
                                Continue := Type = Type::" ";
                                StartLineNo := "Line No.";
                            until (Next() = 0) or not Continue;
                        end;

                        if FindLast() then begin
                            EndLineNo := "Line No." + 1;
                            repeat
                                Continue :=
                                  not ShowNotDueAmounts and
                                  ("No. of Reminders" = 0) and ((Type = Type::"Customer Ledger Entry") or (Type = Type::"Line Fee")) or (Type = Type::" ");
                                if Continue then
                                    EndLineNo := "Line No.";
                            until (Next(-1) = 0) or not Continue;
                        end;

                        VATAmountLine.DeleteAll();
                        SETFILTER("Line No.", '<%1', EndLineNo);
                    end;
                }
                dataitem(IssuedReminderLine2; "Issued Reminder Line")
                {
                    DataItemLink = "Reminder No." = FIELD("No.");
                    DataItemLinkReference = "Issued Reminder Header";
                    DataItemTableView = SORTING("Reminder No.", "Line No.");
                    column(Description_IssuedReminderLine2; Description)
                    {
                    }
                    column(LineNo_IssuedReminderLine2; "Line No.")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SETFILTER("Line No.", '>=%1', EndLineNo);
                        if not ShowNotDueAmounts then begin
                            SETFILTER(Type, '<>%1', Type::" ");
                            if FindFirst() then
                                if "Line No." > EndLineNo then begin
                                    SETRANGE(Type);
                                    SETRANGE("Line No.", EndLineNo, "Line No." - 1); // find "Open Entries Not Due" line
                                    if FindLast() then
                                        SETRANGE("Line No.", EndLineNo, "Line No." - 1);
                                end;
                            SETRANGE(Type);
                        end;
                    end;
                }
                dataitem(VATCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(VATAmtLineAmtInclVAT; VATAmountLine."Amount Including VAT")
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader();
                        AutoFormatType = 1;
                    }
                    column(VALVATAmount; VALVATAmount)
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader();
                        AutoFormatType = 1;
                    }
                    column(VALVATBase; VALVATBase)
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader();
                        AutoFormatType = 1;
                    }
                    column(VALVATBaseVALVATAmount; VALVATBase + VALVATAmount)
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader();
                        AutoFormatType = 1;
                    }
                    column(VATAmountLineVAT; VATAmountLine."VAT %")
                    {
                    }
                    column(AmountIncludingVATCaption; AmountIncludingVATCaptionLbl)
                    {
                    }
                    column(VATAmtSpecificationCaption; VATAmtSpecificationCaptionLbl)
                    {
                    }
                    column(VALVATBaseCaption; VALVATBaseCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VATAmountLine.GetLine(Number);
                        VALVATBase := VATAmountLine."Amount Including VAT" / (1 + VATAmountLine."VAT %" / 100);
                        VALVATAmount := VATAmountLine."Amount Including VAT" - VALVATBase;
                    end;

                    trigger OnPreDataItem()
                    begin
                        if VATAmountLine.GetTotalVATAmount() = 0 then
                            CurrReport.Break();

                        SETRANGE(Number, 1, VATAmountLine.Count());

                        VALVATBase := 0;
                        VALVATAmount := 0;
                    end;
                }
                dataitem(VATClauseEntryCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(VATClauseVATIdentifier; VATAmountLine."VAT Identifier")
                    {
                    }
                    column(VATClauseCode; VATAmountLine."VAT Clause Code")
                    {
                    }
                    column(VATClauseDescription; VATClause.Description)
                    {
                    }
                    column(VATClauseDescription2; VATClause."Description 2")
                    {
                    }
                    column(VATClauseAmount; VATAmountLine."VAT Amount")
                    {
                        AutoFormatExpression = "Issued Reminder Header"."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATClausesCaption; VATClausesCapLbl)
                    {
                    }
                    column(VATClauseVATIdentifierCaption; VATIdentifierCaptionLbl)
                    {
                    }
                    column(VATClauseVATAmtCaption; VATAmountCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VATAmountLine.GetLine(Number);
                        if not VATClause.Get(VATAmountLine."VAT Clause Code") then
                            CurrReport.Skip();
                        VATClause.TranslateDescription("Issued Reminder Header"."Language Code");
                    end;

                    trigger OnPreDataItem()
                    begin
                        CLEAR(VATClause);
                        SETRANGE(Number, 1, VATAmountLine.Count());
                    end;
                }
                dataitem(VATCounterLCY; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(VALExchRate; VALExchRate)
                    {
                    }
                    column(VALSpecLCYHeader; VALSpecLCYHeader)
                    {
                    }
                    column(VALVATAmountLCY; VALVATAmountLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VALVATBaseLCY; VALVATBaseLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VATAmountLine.GetLine(Number);

                        VALVATBaseLCY := ROUND(VATAmountLine."Amount Including VAT" / (1 + VATAmountLine."VAT %" / 100) / CurrFactor);
                        VALVATAmountLCY := ROUND(VATAmountLine."Amount Including VAT" / CurrFactor - VALVATBaseLCY);
                    end;

                    trigger OnPreDataItem()
                    begin
                        if (not GLSetup."Print VAT specification in LCY") or
                           ("Issued Reminder Header"."Currency Code" = '') or
                           (VATAmountLine.GetTotalVATAmount() = 0) then
                            CurrReport.Break();

                        SETRANGE(Number, 1, VATAmountLine.Count());

                        VALVATBaseLCY := 0;
                        VALVATAmountLCY := 0;

                        if GLSetup."LCY Code" = '' then
                            VALSpecLCYHeader := VatAmountLbl + LCYLbl
                        else
                            VALSpecLCYHeader := VatAmountLbl + FORMAT(GLSetup."LCY Code");

                        CurrExchRate.FindCurrency("Issued Reminder Header"."Posting Date", "Issued Reminder Header"."Currency Code", 1);
                        CustEntry.SETRANGE("Customer No.", "Issued Reminder Header"."Customer No.");
                        CustEntry.SETRANGE("Document Type", CustEntry."Document Type"::Reminder);
                        CustEntry.SETRANGE("Document No.", "Issued Reminder Header"."No.");
                        if CustEntry.FindFirst() then begin
                            CustEntry.CALCFIELDS("Amount (LCY)", Amount);
                            CurrFactor := 1 / (CustEntry."Amount (LCY)" / CustEntry.Amount);
                            VALExchRate := STRSUBSTNO(ExchangeRateLbl, ROUND(1 / CurrFactor * 100, 0.000001), CurrExchRate."Exchange Rate Amount");
                        end else begin
                            CurrFactor := CurrExchRate.ExchangeRate("Issued Reminder Header"."Posting Date", "Issued Reminder Header"."Currency Code");
                            VALExchRate := STRSUBSTNO(ExchangeRateLbl, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            var
                GLAcc: Record "G/L Account";
                CustPostingGroup: Record "Customer Posting Group";
                VATPostingSetup: Record "VAT Posting Setup";
            begin
                CurrReport.Language := Language.GetLanguageId("Language Code");
                DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");

                FormatAddr.IssuedReminder(CustAddr, "Issued Reminder Header");
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FIELDCAPTION("Your Reference");
                if "VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(TotalLbl, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(TotalInclVatLbl, GLSetup."LCY Code");
                end else begin
                    TotalText := STRSUBSTNO(TotalLbl, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(TotalInclVatLbl, "Currency Code");
                end;
                if not CurrReport.PREVIEW() then begin
                    if LogInteraction then
                        SegManagement.LogDocument(
                          8, "No.", 0, 0, DATABASE::Customer, "Customer No.", '', '', "Posting Description", '');
                    IncrNoPrinted();
                end;
                CALCFIELDS("Additional Fee");
                CustPostingGroup.Get("Customer Posting Group");
                if GLAcc.Get(CustPostingGroup."Additional Fee Account") then begin
                    VATPostingSetup.Get("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                    AddFeeInclVAT := "Additional Fee" * (1 + VATPostingSetup."VAT %" / 100);
                end else
                    AddFeeInclVAT := "Additional Fee";

                CALCFIELDS("Add. Fee per Line");
                AddFeePerLineInclVAT := "Add. Fee per Line" + CalculateLineFeeVATAmount();

                CALCFIELDS("Interest Amount", "VAT Amount");
                if ("Interest Amount" <> 0) and ("VAT Amount" <> 0) then begin
                    GLAcc.Get(CustPostingGroup."Interest Account");
                    VATPostingSetup.Get("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                    VATInterest := VATPostingSetup."VAT %";
                    Interest :=
                      ("Interest Amount" +
                       "VAT Amount" + "Additional Fee" - AddFeeInclVAT + "Add. Fee per Line" - AddFeePerLineInclVAT) / (VATInterest / 100 + 1);
                end else begin
                    Interest := "Interest Amount";
                    VATInterest := 0;
                end;

                TotalVATAmount := "VAT Amount";
                NNC_InterestAmountTotal := 0;
                NNC_RemainingAmountTotal := 0;
                NNC_VATAmountTotal := 0;
                NNC_InterestAmount := 0;
                NNC_Total := 0;
                NNC_VATAmount := 0;
                NNC_TotalInclVAT := 0;
            end;

            trigger OnPreDataItem()
            var
                i: Integer;
            begin
                CompanyInfo.Get();
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                CLEAR(CompanyAddressLine);

                for i := 1 to 6 do
                    if CompanyAddr[i] <> '' then begin
                        if CompanyAddressLine <> '' then
                            CompanyAddressLine := CompanyAddressLine + ', ';
                        CompanyAddressLine := CompanyAddressLine + CompanyAddr[i];
                    end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Show Internal Info"; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if the document shows internal information.';
                    }
                    field("Log Interaction"; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                        Enabled = LogInteractionEnable;
                    }
                    field("Show Not Due Amounts"; ShowNotDueAmounts)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Not Due Amounts';
                        ToolTip = 'Specifies that display Amounts not due';
                    }
                    field("Hide CompanyInfo"; HideCompanyInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Hide Company Info';
                        ToolTip = 'Specifies that the company data is to be "hidden" for printing';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            LogInteraction := SegManagement.FindInteractTmplCode(8) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        SalesSetup.Get();

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo3.Get();
                    CompanyInfo3.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.Get();
                    CompanyInfo1.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.Get();
                    CompanyInfo2.CALCFIELDS(Picture);
                end;
        end;
    end;

    var
        CustEntry: Record "Cust. Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        VATClause: Record "VAT Clause";
        DimSetEntry: Record "Dimension Set Entry";
        CurrExchRate: Record "Currency Exchange Rate";
        Language: Record Language;
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        CustAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        VATNoText: Text;
        ReferenceText: Text;
        TotalText: Text;
        TotalInclVATText: Text;
        ReminderInterestAmount: Decimal;
        EndLineNo: Integer;
        Continue: Boolean;
        DimText: Text;
        OldDimText: Text;
        ShowInternalInfo: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text;
        VALExchRate: Text;
        CurrFactor: Decimal;
        VatAmountLbl: Label 'VAT Amount Specification in ';
        LCYLbl: Label 'Local Currency';
        ExchangeRateLbl: Label 'Exchange rate: %1/%2', Comment = '%1 - Rel. Amount, %2 - Amount';
        TotalLbl: Label 'Total %1', Comment = '%1 - Amount';
        TotalInclVatLbl: Label 'Total %1 Incl. VAT', Comment = '%1 - Amount';
        AddFeeInclVAT: Decimal;
        AddFeePerLineInclVAT: Decimal;
        TotalVATAmount: Decimal;
        VATInterest: Decimal;
        VALVATBase: Decimal;
        VALVATAmount: Decimal;
        Interest: Decimal;
        NNC_InterestAmount: Decimal;
        NNC_Total: Decimal;
        NNC_VATAmount: Decimal;
        NNC_TotalInclVAT: Decimal;
        NNC_InterestAmountTotal: Decimal;
        NNC_RemainingAmountTotal: Decimal;
        NNC_VATAmountTotal: Decimal;
        StartLineNo: Integer;
        [InDataSet]
        LogInteractionEnable: Boolean;
        ShowNotDueAmounts: Boolean;
        TextPageLbl: Label 'Page';
        PostingDateCaptionLbl: Label 'Posting Date';
        ReminderHeaderNoCaptionLbl: Label 'Reminder No.';
        BankAccountNoCaptionLbl: Label 'Account No.';
        BankNameCaptionLbl: Label 'Bank';
        GiroNoCaptionLbl: Label 'Giro No.';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        PhoneNoCaptionLbl: Label 'Phone No.';
        ReminderCaptionLbl: Label 'Reminder';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        InterestAmountCaptionLbl: Label 'Interest Amount';
        AmountIncludingVATCaptionLbl: Label 'Amount Including VAT';
        VATAmtSpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATClausesCapLbl: Label 'VAT Clause';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        VALVATBaseCaptionLbl: Label 'Continued';
        VALVATBaseLCYCaptionLbl: Label 'Continued';
        DueDateCaptionLbl: Label 'Due Date';
        DocDateCaptionLbl: Label 'Document Date';
        VATAmountCaptionLbl: Label 'VAT Amount';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATCaptionLbl: Label 'VAT %';
        TotalCaptionLbl: Label 'Total';
        HomePageCaptionLbl: Label 'Home Page';
        EMailCaptionLbl: Label 'Email';
        CompanyAddressLine: Text;
        PageFromPageCaptionLbl: Label 'Page %1 of %2', Comment = '%1 - Current Page, %2 - Total Pages';
        PageCaptionLbl: Label 'Page %1', Comment = '%1 - Current Page';
        NoCaptionLbl: Label 'No.';
        FromCaptionLbl: Label 'from';
        DatumCaptionLbl: Label 'Date';
        CompanyInfo__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        CompanyInfo__LeBit_Trade_Register_Name_Caption_Lbl: Label 'Registered in:';
        CompanyInfo__LeBit_CEO_Caption_Lbl: Label 'Chief Executive Officer';
        CompanyInfo_IBAN_Caption_Lbl: Label 'IBAN';
        CompanyInfo__SWIFT_Code_Caption_Lbl: Label 'SWIFT-BIC';
        CompanyInfo_E_Mail_Caption_Lbl: Label 'Mail:';
        CompanyInfo__Home_Page_Caption_Lbl: Label 'Homepage:';
        FaxNoCaptionLbl: Label 'Telefax no.';
        CarryForwardCaptionLbl: Label 'Carry-forward %1', Comment = '%1 - Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        HideCompanyInfo: Boolean;
        VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';

    local procedure DocumentCaption(): Text[250]
    var
        DocCaption: text;
    begin
        OnBeforeGetDocumentCaption("Issued Reminder Header", DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);
        exit(ReminderCaptionLbl);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(IssuedReminderHeader: Record "Issued Reminder Header"; var DocCaption: text);
    begin
    end;
}

