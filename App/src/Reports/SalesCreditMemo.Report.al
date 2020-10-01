report 5272723 "lbt Sales - Credit Memo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/SalesCreditMemo.Report.rdlc';

    Caption = 'Sales - Credit Memo';
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Credit Memo';
            column(AlwaysPrintVat_CorrSetup; CorrSetup."Always print VAT") { }
            column(No_SalesCrMemoHeader; "No.")
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(PaymentMethod_DescriptionCaption; PaymentMethod_DescriptionCaptionLbl)
            {
            }
            column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(DocumentConfirmCopyCaption; GetDocumentCaption())
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
                    column(PostingDate_SalesCrMemoHeader; FORMAT("Sales Cr.Memo Header"."Posting Date", 0, 4))
                    {
                    }
                    column(Date_SalesCrMemoHeader; FORMAT("Sales Cr.Memo Header"."Document Date", 0, 4))
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(VATRegNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."VAT Registration No.")
                    {
                    }
                    column(No1_SalesCrMemoHeader; "Sales Cr.Memo Header"."No.")
                    {
                    }
                    column(YourRef_SalesCrMemoHeader; "Sales Cr.Memo Header"."Your Reference")
                    {
                    }
                    column(PricesIncVAT_SalesCrMemoHeader; "Sales Cr.Memo Header"."Prices Including VAT")
                    {
                    }
                    column(ReturnOrderNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Return Order No.")
                    {
                    }
                    column(PricesInclVATYesNo; FORMAT("Sales Cr.Memo Header"."Prices Including VAT"))
                    {
                    }
                    column(VATBaseDiscPercentage; "Sales Cr.Memo Header"."VAT Base Discount %")
                    {
                    }
                    column(Applies_to_Doc_No_SalesCrMemoHeader; "Sales Cr.Memo Header"."Applies-to Doc. No.")
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(AppliedToText; AppliedToText)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(ReturnOrderNoText; ReturnOrderNoText)
                    {
                    }
                    column(PageCaption; PageCaptionCapLbl)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(SalesCrMemoHeaderNoCaption; GetDocumentNoLbl())
                    {
                    }
                    column(PostingDateCaption; PostingDateCaptionLbl)
                    {
                    }
                    column(CompanyInfoRegNoCaption; CompanyInfo.GetRegistrationNumberLbl())
                    {
                    }
                    column(PricesIncVAT_SalesCrMemoHeaderCaption; "Sales Cr.Memo Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeaderCaption; Bill_to_Customer_No__CaptionLbl)
                    {
                    }
                    column(Description_PaymentTerms; PaymentTerms.Description)
                    {
                    }
                    column(Description_PaymentMethod; PaymentMethod.Description)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__Caption; CompanyInfoVATRegNoCaptionLbl)
                    {
                    }
                    column(CompanyInfo__Phone_No__Caption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No__Caption; CompanyInfoFaxNoCaptionLbl)
                    {
                    }
                    column(CompanyInfo__LeBit_Trade_Register_Name_Caption; CompanyInfo__LeBit_Trade_Register_Name_Caption_Lbl)
                    {
                    }
                    column(CompanyInfo__LeBit_CEO_Caption; CompanyInfo__LeBit_CEO_Caption_Lbl)
                    {
                    }
                    column(CompanyInfo__Bank_Name_Caption; CompanyInfo__Bank_Name_Caption_Lbl)
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
                    column(SalesHeaderNoCaption; SalesHeaderNoLbl)
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
                    column(DatumCaption; DatumCaptionLbl)
                    {
                    }
                    column(PosNo_Caption; PosNo_CaptionLbl)
                    {
                    }
                    column(Desc_SalesCrMemoLineCaption; "Sales Cr.Memo Line".FIELDCAPTION(Description))
                    {
                    }
                    column(Qty_SalesCrMemoLineCaption; "Sales Cr.Memo Line".FIELDCAPTION(Quantity))
                    {
                    }
                    column(UOM_Caption; UOM_CaptionLbl)
                    {
                    }
                    column(Unit_PriceCaption; UnitPriceCaptionLbl)
                    {
                    }
                    column(CarryForwardText; STRSUBSTNO(CarryForwardCaptionLbl, GLSetup."LCY Code"))
                    {
                    }
                    column(SubtotalCaption; SubtotalCaptionLbl)
                    {
                    }
                    column(CompanyAddressLine; CompanyAddressLine)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(HideCompanyInfo; HideCompanyInfo)
                    {
                    }
                    column(VAT_Registration_No__Caption; VAT_Registration_No__CaptionLbl)
                    {
                    }
                    dataitem(LBKopf; "lbt Posted PS Longtext Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Table ID", "Document No.", Position, "Document Line No.", "Line No.") WHERE("Table ID" = CONST(114), Position = FILTER(Header));

                        trigger OnAfterGetRecord()
                        begin
                            Createlbtext(LBKopf);
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempLeBitPostedPSLongtextLine.DeleteAll();
                        end;
                    }
                    dataitem(TempLBKopf; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(LBKopf_LineNo; FORMAT(TempLeBitPostedPSLongtextLine."Line No."))
                        {
                        }
                        column(LBKopf_Description; LBKopf_Description)
                        {
                        }
                        column(NewPageLBKopf; NewPageLBKopf)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            Streamin: InStream;
                        begin
                            if TempLBKopf.Number = 1 then
                                TempLeBitPostedPSLongtextLine.FindSet()
                            else
                                TempLeBitPostedPSLongtextLine.Next();

                            LBKopf_Description := '';

                            case TempLeBitPostedPSLongtextLine.Type of
                                TempLeBitPostedPSLongtextLine.Type::Text,
                                TempLeBitPostedPSLongtextLine.Type::"Text + Line break":
                                    begin
                                        TempLeBitPostedPSLongtextLine.CALCFIELDS(Text);
                                        if TempLeBitPostedPSLongtextLine.Text.HasValue() then begin
                                            TempLeBitPostedPSLongtextLine.Text.CREATEINSTREAM(Streamin);
                                            Streamin.READ(LBKopf_Description);
                                        end;
                                    end;
                                TempLeBitPostedPSLongtextLine.Type::"New Page":
                                    begin
                                        NewPageLBKopf += 1;
                                        LBKopf_Description := '';
                                    end;
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if TempLeBitPostedPSLongtextLine.IsEmpty() then
                                CurrReport.Break();

                            TempLBKopf.SETRANGE(Number, 1, TempLeBitPostedPSLongtextLine.Count());
                        end;
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimLoop1No; DimensionLoop1.Number)
                        {
                        }
                        column(HeaderDimCaption; HeaderDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FindSet() then
                                    CurrReport.Break();
                            end else
                                if not Continue then
                                    CurrReport.Break();

                            CLEAR(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.Next() = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(LineAmt_SalesCrMemoLine; "Line Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesCrMemoLine; Description)
                        {
                        }
                        column(No_SalesCrMemoLine; "No.")
                        {
                        }
                        column(Qty_SalesCrMemoLine; Quantity)
                        {
                        }
                        column(umo_SalesCrMemoLine; "Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesCrMemoLine; "Unit Price")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 2;
                        }
                        column(LineDis_SalesCrMemoLine; "Line Discount %")
                        {
                        }
                        column(VATId_SalesCrMemoLine; "VAT Identifier")
                        {
                        }
                        column(PostedReceiptDate; FORMAT(PostedReceiptDate))
                        {
                        }
                        column(SalesLineType; FORMAT(Type, 0, 2))
                        {
                        }
                        column(NNCTotalLineAmt; NNC_TotalLineAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(NNCTotalAmtInclVat; NNC_TotalAmountInclVat)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(NNCTotalInvDiscAmt; NNC_TotalInvDiscAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(NNCTotalAmt; NNC_TotalAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalesCrMemoLineAmt; Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(AmtInclVAT_SalesCrMemoLine; "Amount Including VAT")
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(AmtInclVATAmt; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText())
                        {
                        }
                        column(DocNo_SalesCrMemoLine; "Document No.")
                        {
                        }
                        column(SalesCrMemoLineLineNo; "Line No.")
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscountCaption; DiscountCaptionLbl)
                        {
                        }
                        column(PostedReceiptDateCaption; PostedReceiptDateCaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
                        {
                        }
                        column(PaymentDiscountVATCaption; PaymentDiscountVATCaptionLbl)
                        {
                        }
                        column(No_SalesCrMemoLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(umo_SalesCrMemoLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATId_SalesCrMemoLineCaption; FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(SalesLineLeBitPrintoption; FORMAT("lbt Printoption", 0, 2))
                        {
                        }
                        column(LeBitBalance_SalesCrMemoLine; "lbt Balance")
                        {
                        }
                        column(LeBitPosNo_SalesCrMemoLine; "lbt Pos. No.")
                        {
                        }
                        column(Description2_SalesCrMemoLine; "Description 2")
                        {
                        }
                        column(ItemUnitQty; ItemUnitQty)
                        {
                        }
                        column(ItemUnitDescription; ItemUnitDescription)
                        {
                        }
                        column(NewPageGroup; NewPageGroup)
                        {
                        }
                        column(Item_Picture; Item.Picture)
                        {
                        }
                        column(ItemPictureExist; ItemPictureExist)
                        {
                        }
                        dataitem(ParameterAndUnits; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(RowNumber; Number)
                            {
                            }
                            column(InfoCaptionArry; InfoCaptionArry[Number])
                            {
                            }
                            column(InfoValueArry; InfoValueArry[Number])
                            {
                            }
                            column(ItemUnitDescriptionArry; ItemUnitDescriptionArry[Number])
                            {
                            }
                            column(ItemUnitQtyArry; ItemUnitQtyArry[Number])
                            {
                            }

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(Number, 1, InfoRowNo);
                            end;
                        }
                        dataitem(LBLang; "lbt Posted PS Longtext Line")
                        {
                            DataItemLink = "Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                            DataItemLinkReference = "Sales Cr.Memo Line";
                            DataItemTableView = SORTING("Table ID", "Document No.", Position, "Document Line No.", "Line No.") WHERE("Table ID" = CONST(115), Position = FILTER(Longtext));

                            trigger OnAfterGetRecord()
                            begin
                                Createlbtext(LBLang);
                            end;

                            trigger OnPreDataItem()
                            begin
                                TempLeBitPostedPSLongtextLine.DeleteAll();
                            end;
                        }
                        dataitem(TempLBLang; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(LBLang_LineNo; FORMAT(TempLeBitPostedPSLongtextLine."Line No."))
                            {
                            }
                            column(LBLang_Description; LBLang_Description)
                            {
                            }
                            column(NewPageLBLang; NewPageLBLang)
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                Streamin: InStream;
                            begin
                                if TempLBLang.Number = 1 then
                                    TempLeBitPostedPSLongtextLine.FindSet()
                                else
                                    TempLeBitPostedPSLongtextLine.Next();

                                LBLang_Description := '';

                                case TempLeBitPostedPSLongtextLine.Type of
                                    TempLeBitPostedPSLongtextLine.Type::Text,
                                    TempLeBitPostedPSLongtextLine.Type::"Text + Line break":
                                        begin
                                            TempLeBitPostedPSLongtextLine.CALCFIELDS(Text);
                                            if TempLeBitPostedPSLongtextLine.Text.HasValue() then begin
                                                TempLeBitPostedPSLongtextLine.Text.CREATEINSTREAM(Streamin);
                                                Streamin.READ(LBLang_Description);
                                            end;
                                        end;
                                    TempLeBitPostedPSLongtextLine.Type::"New Page":
                                        begin
                                            NewPageLBLang += 1;
                                            LBLang_Description := '';
                                        end;
                                end;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if TempLeBitPostedPSLongtextLine.IsEmpty() then
                                    CurrReport.Break();

                                TempLBLang.SETRANGE(Number, 1, TempLeBitPostedPSLongtextLine.Count());
                            end;
                        }
                        dataitem("Sales Shipment Buffer"; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(SalesShipmentBufferQuantity; SalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then
                                    SalesShipmentBuffer.FIND('-')
                                else
                                    SalesShipmentBuffer.Next();
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(Number, 1, SalesShipmentBuffer.Count());
                            end;
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FIND('-') then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                CLEAR(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.Next() = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.Break();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Cr.Memo Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            IntVar: Integer;
                            TxtVar: Text;
                            Counter: Integer;
                        begin
                            NNC_TotalLineAmount += "Line Amount";
                            NNC_TotalAmountInclVat += "Amount Including VAT";
                            NNC_TotalInvDiscAmount += "Inv. Discount Amount";
                            NNC_TotalAmount += Amount;

                            SalesShipmentBuffer.DeleteAll();
                            PostedReceiptDate := 0D;
                            if Quantity <> 0 then
                                PostedReceiptDate := FindPostedShipmentDate();

                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then
                                "No." := '';

                            VATAmountLine.Init();
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            if "Allow Invoice Disc." then
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                            VATAmountLine.InsertLine();

                            if "lbt Printoption" = "lbt Printoption"::"New Page" then
                                NewPageGroup += 1;

                            ItemUnitCode := '';
                            ItemUnitDescription := '';
                            ItemUnitQty := '';
                            CLEAR(InfoRowNo);
                            CLEAR(InfoCaptionArry);
                            CLEAR(InfoValueArry);
                            CLEAR(ItemUnitCodeArry);
                            CLEAR(ItemUnitDescriptionArry);
                            CLEAR(ItemUnitQtyArry);
                            CLEAR(Item);
                            ItemPictureExist := false;

                            CALCFIELDS("lbt Balance");
                            if Type = Type::Item then begin
                                Item.Get("No.");
                                ItemPictureExist := Item.Picture.Count() > 0;
                                if not ItemPicturePrint then
                                    ItemPictureExist := false;
                                TxtVar := CurrReport.OBJECTID(false);
                                TxtVar := COPYSTR(TxtVar, STRPOS(TxtVar, ' '));
                                EVALUATE(IntVar, TxtVar);
                                LeBitReportFunctions.GetParameterArry(ReportType::Sales, IntVar, 1, "Sales Cr.Memo Header"."Language Code", "Sales Cr.Memo Line".RowID1(), '', "Sales Cr.Memo Line"."No.", InfoCaptionArry, InfoValueArry);
                                LeBitReportFunctions.GetItemUnitArry(1, "Sales Cr.Memo Line".RowID1(), '', "Sales Cr.Memo Header"."Language Code", ItemUnitCodeArry, ItemUnitDescriptionArry, ItemUnitQtyArry);
                                Counter := 0;
                                repeat
                                    Counter += 1;
                                until (ItemUnitCodeArry[Counter] = "Unit of Measure Code") or
                                  (ItemUnitCodeArry[Counter] = '');
                                if ItemUnitCodeArry[Counter] <> '' then begin
                                    ItemUnitCodeArry[Counter] := '';
                                    ItemUnitDescriptionArry[Counter] := '';
                                    ItemUnitQtyArry[Counter] := '';
                                    COMPRESSARRAY(ItemUnitCodeArry);
                                    COMPRESSARRAY(ItemUnitDescriptionArry);
                                    COMPRESSARRAY(ItemUnitQtyArry);
                                end;
                                if "Description 2" <> '' then begin
                                    ItemUnitCode := ItemUnitCodeArry[1];
                                    ItemUnitDescription := ItemUnitDescriptionArry[1];
                                    ItemUnitQty := ItemUnitQtyArry[1];
                                    ItemUnitCodeArry[1] := '';
                                    ItemUnitDescriptionArry[1] := '';
                                    ItemUnitQtyArry[1] := '';
                                    COMPRESSARRAY(ItemUnitCodeArry);
                                    COMPRESSARRAY(ItemUnitDescriptionArry);
                                    COMPRESSARRAY(ItemUnitQtyArry);
                                end;
                                //zusätzliche Infos
                                if PostedReceiptDate <> 0D then begin
                                    Counter := 0;
                                    repeat
                                        Counter += 1;
                                    until InfoCaptionArry[Counter] = '';
                                    InfoCaptionArry[Counter] := PostedReceiptDateCaptionLbl;
                                    InfoValueArry[Counter] := FORMAT(PostedReceiptDate);
                                end else begin
                                    SalesShipmentBuffer.Reset();
                                    SalesShipmentBuffer.SETRANGE("Document No.", "Document No.");
                                    SalesShipmentBuffer.SETRANGE("Line No.", "Line No.");
                                    if SalesShipmentBuffer.FindSet() then begin
                                        Counter := 0;
                                        repeat
                                            Counter += 1;
                                        until (InfoCaptionArry[Counter] = '') and
                                          (ItemUnitDescriptionArry[Counter] = '');
                                        Counter -= 1;
                                        repeat
                                            Counter += 1;
                                            InfoCaptionArry[Counter] := ShipmentLbl;
                                            InfoValueArry[Counter] := FORMAT(SalesShipmentBuffer."Posting Date");
                                            ItemUnitQtyArry[Counter] := FORMAT(SalesShipmentBuffer.Quantity);
                                            ItemUnitDescriptionArry[Counter] := "Sales Cr.Memo Line"."Unit of Measure";
                                        until SalesShipmentBuffer.Next() = 0;
                                    end;
                                end;

                                ///Prüfung auf MaxRowNo
                                Counter := 0;
                                repeat
                                    Counter += 1;
                                until (InfoCaptionArry[Counter] = '') and
                                  (ItemUnitDescriptionArry[Counter] = '');
                                if Counter > 1 then
                                    InfoRowNo := Counter - 1
                                else
                                    InfoRowNo := 0;
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DeleteAll();
                            SalesShipmentBuffer.Reset();
                            SalesShipmentBuffer.DeleteAll();
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                                MoreLines := Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            SETRANGE("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvoiceDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtLineVATCaption; VATAmtLineVATCaptionLbl)
                        {
                        }
                        column(VATBaseCaption; VATBaseCaptionLbl)
                        {
                        }
                        column(VATAmountCaption; VATAmountCaptionLbl)
                        {
                        }
                        column(VATAmtSpecificationCaption; VATAmtSpecificationCaptionLbl)
                        {
                        }
                        column(VATIdentifierCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(InvoiceDiscoutAmountCaption; InvoiceDiscoutAmountCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmountLine.Count() < 2 then
                                CurrReport.Break();
                            SETRANGE(Number, 1, VATAmountLine.Count());
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
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
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
                            VATClause.TranslateDescription("Sales Cr.Memo Header"."Language Code");
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
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATAmtLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdr; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code",
                                "Sales Cr.Memo Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code",
                                "Sales Cr.Memo Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmountLine.Count() < 2 then
                                CurrReport.Break();
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Cr.Memo Header"."Currency Code" = '')
                            then
                                CurrReport.Break();

                            SETRANGE(Number, 1, VATAmountLine.Count());

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := VatAmountLbl + LCYLbl
                            else
                                VALSpecLCYHeader := VatAmountLbl + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Sales Cr.Memo Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(ExchangeRateLbl, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(SelltoCustNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesCrMemoHeaderCaption; "Sales Cr.Memo Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(LBFuss; "lbt Posted PS Longtext Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Table ID", "Document No.", Position, "Document Line No.", "Line No.") WHERE("Table ID" = CONST(114), Position = FILTER(Footer));

                        trigger OnAfterGetRecord()
                        begin
                            Createlbtext(LBFuss);
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempLeBitPostedPSLongtextLine.DeleteAll();
                        end;
                    }
                    dataitem(TempLBFuss; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(LBFuss_LineNo; FORMAT(TempLeBitPostedPSLongtextLine."Line No."))
                        {
                        }
                        column(LBFuss_Description; LBFuss_Description)
                        {
                        }
                        column(NewPageLBFuss; NewPageLBFuss)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            Streamin: InStream;
                        begin
                            if TempLBFuss.Number = 1 then
                                TempLeBitPostedPSLongtextLine.FindSet()
                            else
                                TempLeBitPostedPSLongtextLine.Next();

                            LBFuss_Description := '';

                            case TempLeBitPostedPSLongtextLine.Type of
                                TempLeBitPostedPSLongtextLine.Type::Text,
                                TempLeBitPostedPSLongtextLine.Type::"Text + Line break":
                                    begin
                                        TempLeBitPostedPSLongtextLine.CALCFIELDS(Text);
                                        if TempLeBitPostedPSLongtextLine.Text.HasValue() then begin
                                            TempLeBitPostedPSLongtextLine.Text.CREATEINSTREAM(Streamin);
                                            Streamin.READ(LBFuss_Description);
                                        end;
                                    end;
                                TempLeBitPostedPSLongtextLine.Type::"New Page":
                                    begin
                                        NewPageLBFuss += 1;
                                        LBFuss_Description := '';
                                    end;
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if TempLeBitPostedPSLongtextLine.IsEmpty() then
                                CurrReport.Break();

                            TempLBFuss.SETRANGE(Number, 1, TempLeBitPostedPSLongtextLine.Count());
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    end;

                    NNC_TotalLineAmount := 0;
                    NNC_TotalAmountInclVat := 0;
                    NNC_TotalInvDiscAmount := 0;
                    NNC_TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.PREVIEW() then
                        CODEUNIT.RUN(CODEUNIT::"Sales Cr. Memo-Printed", "Sales Cr.Memo Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                FormatAddressFields("Sales Cr.Memo Header");
                FormatDocumentFields("Sales Cr.Memo Header");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if LogInteraction then
                    if not CurrReport.PREVIEW() then
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(
                              6, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        else
                            SegManagement.LogDocument(
                              6, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');
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
                    field("No Of Copies"; NoOfCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field("Show Internal Info"; ShowInternalInfo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if the document shows internal information.';
                    }
                    field("Log Interaction"; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                    field("Hide CompanyInfo"; HideCompanyInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Hide Company Info';
                        ToolTip = 'Specifies that the company data is to be "hidden" for printing';
                    }
                    field("Item Picture Print"; ItemPicturePrint)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Item Picture';
                        ToolTip = 'Specifies that the  images are printed ';
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
            LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
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
        CorrSetup.Get();
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.USEREQUESTPAGE() then
            InitLogInteraction();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        VATAmountLine: Record "VAT Amount Line" temporary;
        VATClause: Record "VAT Clause";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        CurrExchRate: Record "Currency Exchange Rate";
        Item: Record Item;
        TempLeBitPostedPSLongtextLine: Record "lbt Posted PS Longtext Line" temporary;
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        ShipmentMethod: Record "Shipment Method";
        CorrSetup: Record "lbt Corr Setup";
        Language: Codeunit Language;
        LeBitReportFunctions: Codeunit "lbt Report Functions";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ReturnOrderNoText: Text[80];
        SalesPersonText: Text[50];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        AppliedToText: Text;
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        DimText: Text;
        OldDimText: Text;
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        FirstValueEntryNo: Integer;
        PostedReceiptDate: Date;
        NextEntryNo: Integer;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VatAmountLbl: Label 'VAT Amount Specification in ';
        LCYLbl: Label 'Local Currency';
        ExchangeRateLbl: Label 'Exchange rate: %1/%2', Comment = '%1 - Rel. Amount, %2 - Amount';
        AppliesLbl: Label '(Applies to %1 %2)', Comment = '%1 - Doctype, %2 - DocNo';
        PageCaptionCapLbl: Label 'Page %1 of %2', Comment = '%1 - Current Page, %2 - Total Pages';
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        CalculatedExchRate: Decimal;
        OutputNo: Integer;
        NNC_TotalLineAmount: Decimal;
        NNC_TotalAmountInclVat: Decimal;
        NNC_TotalInvDiscAmount: Decimal;
        NNC_TotalAmount: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DocCreditMemoCapLbl: Label 'Credit Memo %1', Comment = '%1 - Document No.';
        DocCreditMemoPrepmtCapLbl: Label 'Prepmt. Credit Memo %1', Comment = '%1 - Document No.';
        DocDECapLbl: Label 'Corrective Invoice %1', Comment = '%1 - Document No.';
        DocDEPrepmtCapLbl: Label 'Prepmt. Corrective Invoice %1', Comment = '%1 - Document No.';
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoFaxNoCaptionLbl: Label 'Fax No.';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Reg. No.';
        SalesHeaderNoLbl: Label 'Credit Memo No.';
        DESalesHeaderNoLbl: Label 'Corrective Invoice No.';
        PostingDateCaptionLbl: Label 'Posting Date';
        HeaderDimCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        DiscountCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        PostedReceiptDateCaptionLbl: Label 'Posted Return Receipt Date';
        ContinuedCaptionLbl: Label 'Continued';
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        PaymentDiscountVATCaptionLbl: Label 'Payment Discount on VAT';
        VATClausesCapLbl: Label 'VAT Clause';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        VATAmtLineVATCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmountCaptionLbl: Label 'VAT Amount';
        VATAmtSpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmtCaptionLbl: Label 'Line Amount';
        InvoiceDiscoutAmountCaptionLbl: Label 'Invoice Discount Amount';
        TotalCaptionLbl: Label 'Total';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        EMailCaptionLbl: Label 'Email';
        HomePageCaptionLbl: Label 'Home Page';
        DocumentDateCaptionLbl: Label 'Document Date';
        CompanyAddressLine: Text;
        InfoCaptionArry: array[99] of Text;
        InfoValueArry: array[99] of Text;
        ItemUnitCodeArry: array[50] of Code[20];
        ItemUnitDescriptionArry: array[50] of Text;
        ItemUnitQtyArry: array[50] of Text;
        InfoRowNo: Integer;
        ItemUnitCode: Code[20];
        ItemUnitDescription: Text;
        ItemUnitQty: Text;
        HideCompanyInfo: Boolean;
        NewPageGroup: Integer;
        ItemPictureExist: Boolean;
        ItemPicturePrint: Boolean;
        LBKopf_Description: Text;
        NewPageLBKopf: Integer;
        LBLang_Description: Text;
        NewPageLBLang: Integer;
        LBFuss_Description: Text;
        NewPageLBFuss: Integer;
        PageFromPageCaptionLbl: Label 'Page %1 of %2', Comment = '%1 - Current Page, %2 - Total Pages';
        NoCaptionLbl: Label 'No.';
        FromCaptionLbl: Label 'from';
        Bill_to_Customer_No__CaptionLbl: Label 'Customer ID';
        DatumCaptionLbl: Label 'Date';
        PosNo_CaptionLbl: Label 'Pos.';
        UOM_CaptionLbl: Label 'Unit';
        CarryForwardCaptionLbl: Label 'Carry-forward %1', Comment = '%1 - Amount';
        CompanyInfo__LeBit_Trade_Register_Name_Caption_Lbl: Label 'Registered in:';
        CompanyInfo__LeBit_CEO_Caption_Lbl: Label 'Chief Executive Officer';
        CompanyInfo__Bank_Name_Caption_Lbl: Label 'Bank';
        CompanyInfo_IBAN_Caption_Lbl: Label 'IBAN';
        CompanyInfo__SWIFT_Code_Caption_Lbl: Label 'SWIFT-BIC';
        SalesPersonText_CaptionLbl: Label 'Salesperson';
        CompanyInfo_E_Mail_Caption_Lbl: Label 'Mail:';
        CompanyInfo__Home_Page_Caption_Lbl: Label 'Homepage:';
        ShipmentLbl: Label 'Shipment';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        PaymentMethod_DescriptionCaptionLbl: Label 'Payment Method';
        ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report";
        VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
    end;

    local procedure FindPostedShipmentDate(): Date
    var
        ReturnReceiptHeader: Record "Return Receipt Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        if "Sales Cr.Memo Line"."Return Receipt No." <> '' then
            if ReturnReceiptHeader.Get("Sales Cr.Memo Line"."Return Receipt No.") then
                exit(ReturnReceiptHeader."Posting Date");
        if "Sales Cr.Memo Header"."Return Order No." = '' then
            exit("Sales Cr.Memo Header"."Posting Date");

        case "Sales Cr.Memo Line".Type of
            "Sales Cr.Memo Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Cr.Memo Line");
            "Sales Cr.Memo Line".Type::"G/L Account", "Sales Cr.Memo Line".Type::Resource,
          "Sales Cr.Memo Line".Type::"Charge (Item)", "Sales Cr.Memo Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Cr.Memo Line");
            "Sales Cr.Memo Line".Type::" ":
                exit(0D);
        end;

        SalesShipmentBuffer.Reset();
        SalesShipmentBuffer.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "Sales Cr.Memo Line"."Line No.");

        if SalesShipmentBuffer.FIND('-') then begin
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            if SalesShipmentBuffer.Next() = 0 then begin
                SalesShipmentBuffer.Get(
                  SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.Delete();
                exit(SalesShipmentBuffer2."Posting Date");
            end;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            if SalesShipmentBuffer.Quantity <> "Sales Cr.Memo Line".Quantity then begin
                SalesShipmentBuffer.DeleteAll();
                exit("Sales Cr.Memo Header"."Posting Date");
            end;
        end else
            exit("Sales Cr.Memo Header"."Posting Date");
    end;

    local procedure GenerateBufferFromValueEntry(SalesCrMemoLine2: Record "Sales Cr.Memo Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesCrMemoLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesCrMemoLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Cr.Memo Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        if ValueEntry.FIND('-') then
            repeat
                if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
                    if SalesCrMemoLine2."Qty. per Unit of Measure" <> 0 then
                        Quantity := ValueEntry."Invoiced Quantity" / SalesCrMemoLine2."Qty. per Unit of Measure"
                    else
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesCrMemoLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity - ValueEntry."Invoiced Quantity";
                end;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            until (ValueEntry.Next() = 0) or (TotalQuantity = 0);
    end;

    local procedure GenerateBufferFromShipment(SalesCrMemoLine: Record "Sales Cr.Memo Line")
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
        ReturnReceiptHeader: Record "Return Receipt Header";
        ReturnReceiptLine: Record "Return Receipt Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesCrMemoHeader.SETCURRENTKEY("Return Order No.");
        SalesCrMemoHeader.SETFILTER("No.", '..%1', "Sales Cr.Memo Header"."No.");
        SalesCrMemoHeader.SETRANGE("Return Order No.", "Sales Cr.Memo Header"."Return Order No.");
        if SalesCrMemoHeader.FIND('-') then
            repeat
                SalesCrMemoLine2.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                SalesCrMemoLine2.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
                SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine.Type);
                SalesCrMemoLine2.SETRANGE("No.", SalesCrMemoLine."No.");
                SalesCrMemoLine2.SETRANGE("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
                if SalesCrMemoLine2.FIND('-') then
                    repeat
                        TotalQuantity := TotalQuantity + SalesCrMemoLine2.Quantity;
                    until SalesCrMemoLine2.Next() = 0;
            until SalesCrMemoHeader.Next() = 0;

        ReturnReceiptLine.SETCURRENTKEY("Return Order No.", "Return Order Line No.");
        ReturnReceiptLine.SETRANGE("Return Order No.", "Sales Cr.Memo Header"."Return Order No.");
        ReturnReceiptLine.SETRANGE("Return Order Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SETRANGE(Type, SalesCrMemoLine.Type);
        ReturnReceiptLine.SETRANGE("No.", SalesCrMemoLine."No.");
        ReturnReceiptLine.SETRANGE("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
        ReturnReceiptLine.SETFILTER(Quantity, '<>%1', 0);

        if ReturnReceiptLine.FIND('-') then
            repeat
                if "Sales Cr.Memo Header"."Get Return Receipt Used" then
                    CorrectShipment(ReturnReceiptLine);
                if ABS(ReturnReceiptLine.Quantity) <= ABS(TotalQuantity - SalesCrMemoLine.Quantity) then
                    TotalQuantity := TotalQuantity - ReturnReceiptLine.Quantity
                else begin
                    if ABS(ReturnReceiptLine.Quantity) > ABS(TotalQuantity) then
                        ReturnReceiptLine.Quantity := TotalQuantity;
                    Quantity :=
                      ReturnReceiptLine.Quantity - (TotalQuantity - SalesCrMemoLine.Quantity);

                    SalesCrMemoLine.Quantity := SalesCrMemoLine.Quantity - Quantity;
                    TotalQuantity := TotalQuantity - ReturnReceiptLine.Quantity;

                    if ReturnReceiptHeader.Get(ReturnReceiptLine."Document No.") then
                        AddBufferEntry(
                          SalesCrMemoLine,
                          -Quantity,
                          ReturnReceiptHeader."Posting Date");
                end;
            until (ReturnReceiptLine.Next() = 0) or (TotalQuantity = 0);
    end;

    local procedure CorrectShipment(var ReturnReceiptLine: Record "Return Receipt Line")
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        SalesCrMemoLine.SETCURRENTKEY("Return Receipt No.", "Return Receipt Line No.");
        SalesCrMemoLine.SETRANGE("Return Receipt No.", ReturnReceiptLine."Document No.");
        SalesCrMemoLine.SETRANGE("Return Receipt Line No.", ReturnReceiptLine."Line No.");
        if SalesCrMemoLine.FIND('-') then
            repeat
                ReturnReceiptLine.Quantity := ReturnReceiptLine.Quantity - SalesCrMemoLine.Quantity;
            until SalesCrMemoLine.Next() = 0;
    end;

    local procedure AddBufferEntry(SalesCrMemoLine: Record "Sales Cr.Memo Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        if SalesShipmentBuffer.FIND('-') then begin
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity - QtyOnShipment;
            SalesShipmentBuffer.Modify();
            exit;
        end;

        with SalesShipmentBuffer do begin
            Init();
            "Document No." := SalesCrMemoLine."Document No.";
            "Line No." := SalesCrMemoLine."Line No.";
            "Entry No." := NextEntryNo;
            Type := SalesCrMemoLine.Type;
            "No." := SalesCrMemoLine."No.";
            Quantity := -QtyOnShipment;
            "Posting Date" := PostingDate;
            Insert();
            NextEntryNo := NextEntryNo + 1
        end;
    end;

    local procedure GetDocumentCaption(): Text
    var
        Caption: Text;
    begin
        OnBeforeGetDocumentCaption("Sales Cr.Memo Header", Caption);
        if Caption <> '' then
            exit(Caption);
        if CompanyInfo."Country/Region Code" = 'DE' then begin
            if "Sales Cr.Memo Header"."Prepayment Credit Memo" then
                Caption := DocDEPrepmtCapLbl
            else
                Caption := DocDECapLbl;
        end else
            if "Sales Cr.Memo Header"."Prepayment Credit Memo" then
                Caption := DocCreditMemoPrepmtCapLbl
            else
                Caption := DocCreditMemoCapLbl;

        exit(STRSUBSTNO(Caption, CopyText));
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
    end;

    local procedure FormatAddressFields(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        i: Integer;
    begin
        FormatAddr.GetCompanyAddr(SalesCrMemoHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesCrMemoBillTo(CustAddr, SalesCrMemoHeader);
        ShowShippingAddr := FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, SalesCrMemoHeader);
        CLEAR(CompanyAddressLine);

        for i := 1 to 6 do
            if CompanyAddr[i] <> '' then begin
                if CompanyAddressLine <> '' then
                    CompanyAddressLine := CompanyAddressLine + ', ';
                CompanyAddressLine := CompanyAddressLine + CompanyAddr[i];
            end;
    end;

    local procedure FormatDocumentFields(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        with SalesCrMemoHeader do begin
            FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalesPurchPerson, "Salesperson Code", SalesPersonText);

            ReturnOrderNoText := FormatDocument.SetText("Return Order No." <> '', CopyStr(FIELDCAPTION("Return Order No."), 1, 80));
            ReferenceText := FormatDocument.SetText("Your Reference" <> '', CopyStr(FIELDCAPTION("Your Reference"), 1, 80));
            VATNoText := FormatDocument.SetText("VAT Registration No." <> '', CopyStr(FIELDCAPTION("VAT Registration No."), 1, 80));
            AppliedToText :=
              FormatDocument.SetText(
                "Applies-to Doc. No." <> '', FORMAT(STRSUBSTNO(AppliesLbl, FORMAT("Applies-to Doc. Type"), "Applies-to Doc. No.")));
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentMethod(PaymentMethod, "Payment Method Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
            if SalesPersonText <> '' then
                SalesPersonText := SalesPersonText_CaptionLbl;
        end;
    end;

    local procedure GetDocumentNoLbl(): Text
    begin
        if CompanyInfo."Country/Region Code" = 'DE' then
            exit(DESalesHeaderNoLbl);
        exit(SalesHeaderNoLbl);
    end;

    local procedure "### Lebit Correspondence Functions ###"()
    begin
    end;

    local procedure Createlbtext(LeBitPostedPSLongtextLine: Record "lbt Posted PS Longtext Line")
    var
        lbtext: Text;
        Streamin: InStream;
        Streamout: OutStream;
        LastSign: Text[10];
        NewLine: Boolean;
    begin
        if TempLeBitPostedPSLongtextLine.IsEmpty() then begin
            TempLeBitPostedPSLongtextLine := LeBitPostedPSLongtextLine;
            TempLeBitPostedPSLongtextLine.Description := '';
            TempLeBitPostedPSLongtextLine.Insert();
        end;

        TempLeBitPostedPSLongtextLine.FindLast();
        NewLine := false;

        TempLeBitPostedPSLongtextLine.CALCFIELDS(Text);
        if TempLeBitPostedPSLongtextLine.Text.HasValue() then begin
            TempLeBitPostedPSLongtextLine.Text.CREATEINSTREAM(Streamin);
            Streamin.READ(lbtext);
        end;

        case LeBitPostedPSLongtextLine.Type of
            LeBitPostedPSLongtextLine.Type::"New Page":
                begin
                    TempLeBitPostedPSLongtextLine := LeBitPostedPSLongtextLine;
                    TempLeBitPostedPSLongtextLine."Line No." := TempLeBitPostedPSLongtextLine."Line No." + 10000;
                    TempLeBitPostedPSLongtextLine.Insert();
                    NewLine := true;
                    lbtext := '';
                end;
            LeBitPostedPSLongtextLine.Type::Text:
                if LeBitPostedPSLongtextLine.Description = '' then begin
                    if STRLEN(lbtext) <> 0 then begin
                        LastSign := COPYSTR(lbtext, STRLEN(lbtext) - 3, 4);
                        if LastSign = '<br>' then
                            lbtext := COPYSTR(lbtext, 1, STRLEN(lbtext) - 4);
                    end;
                    lbtext += '<br>';
                    NewLine := true;
                end else
                    if STRLEN(lbtext) <> 0 then begin
                        LastSign := COPYSTR(lbtext, STRLEN(lbtext), 1);
                        if LastSign in ['>', ' '] then
                            lbtext += LeBitPostedPSLongtextLine.Description
                        else
                            lbtext += (' ' + LeBitPostedPSLongtextLine.Description);
                    end else
                        lbtext += LeBitPostedPSLongtextLine.Description;

            LeBitPostedPSLongtextLine.Type::"Text + Line break":
                if LeBitPostedPSLongtextLine.Description = '' then begin
                    if STRLEN(lbtext) <> 0 then begin
                        LastSign := COPYSTR(lbtext, STRLEN(lbtext) - 3, 4);
                        if LastSign = '<br>' then
                            lbtext := COPYSTR(lbtext, 1, STRLEN(lbtext) - 4);
                    end;
                    lbtext += '<br>';
                    NewLine := true;
                end else
                    if STRLEN(lbtext) <> 0 then begin
                        LastSign := COPYSTR(lbtext, STRLEN(lbtext), 1);
                        if LastSign in ['>', ' '] then
                            lbtext += LeBitPostedPSLongtextLine.Description + '<br>'
                        else
                            lbtext += (' ' + LeBitPostedPSLongtextLine.Description) + '<br>';
                    end else
                        lbtext += LeBitPostedPSLongtextLine.Description + '<br>';

        end;

        if lbtext <> '' then begin
            TempLeBitPostedPSLongtextLine.Text.CREATEOUTSTREAM(Streamout);
            Streamout.WRITE(lbtext);
            TempLeBitPostedPSLongtextLine.Modify();
        end;
        if NewLine then begin
            TempLeBitPostedPSLongtextLine.Init();
            TempLeBitPostedPSLongtextLine."Line No." := TempLeBitPostedPSLongtextLine."Line No." + 10000;
            TempLeBitPostedPSLongtextLine.Type := TempLeBitPostedPSLongtextLine.Type::Text;
            TempLeBitPostedPSLongtextLine.Insert();
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesCrMemoHeaderHeader: Record "Sales Cr.Memo Header"; var DocCaption: text);
    begin
    end;

}

