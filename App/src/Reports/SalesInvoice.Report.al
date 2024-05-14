report 50722 "lbt Sales - Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/SalesInvoice.Report.rdlc';
    Caption = 'Sales - Invoice';
    EnableHyperlinks = true;
    Permissions = tabledata "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(Footer; Footer) { }
            column(AlwaysPrintVat_CorrSetup; CorrSetup."Always print VAT") { }
            column(No_SalesInvHdr; "No.")
            {
            }
            column(InvDiscountAmountCaption; InvDiscountAmountCaptionLbl)
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PaymentTermsCaption; PaymentTermsCaptionLbl)
            {
            }
            column(PaymentMethodCaption; PaymentMethodCaptionLbl) { }
            column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(DocumentConfirmCopyCaption; StrSubstNo(DocumentCaption(), CopyText))
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
                    column(DocDate_SalesInvoiceHdr; Format("Sales Invoice Header"."Document Date", 0, 4))
                    {
                    }
                    column(BillToCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(VATRegNo_SalesInvHeader; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(OrderNo_SalesInvHeader; OrderNo)
                    {
                    }
                    column(YourReference_SalesInvHdr; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(HideCompanyInfo; HideCompanyInfo)
                    {
                    }
                    column(PmntTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShptMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentMethodDescription; PaymentMethod.Description) { }
                    column(InvoiceNoCaption; InvoiceNoCaptionLbl)
                    {
                    }
                    column(BillToCustNo_SalesInvHdrCaption; Bill_to_Customer_No__CaptionLbl)
                    {
                    }
                    column(PagefromPageCaption; PageFromPageCaptionLbl)
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
                    column(Description_SalesInvLineCaption; "Sales Invoice Line".FieldCaption(Description))
                    {
                    }
                    column(Quantity_SalesInvoiceLineCaption; "Sales Invoice Line".FieldCaption(Quantity))
                    {
                    }
                    column(UOM_Caption; UOM_CaptionLbl)
                    {
                    }
                    column(Unit_PriceCaption; UnitPriceCaptionLbl)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(CarryForwardText; StrSubstNo(CarryForwardCaptionLbl, GLSetup."LCY Code"))
                    {
                    }
                    column(SubtotalCaption; SubtotalCaptionLbl)
                    {
                    }
                    column(CompanyAddressLine; CompanyAddressLine)
                    {
                    }
                    column(VAT_Registration_No__Caption; VAT_Registration_No__CaptionLbl)
                    {
                    }
                    dataitem(LBKopf; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(LBKopf_LineNo; '0')
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
                            TempBlob: Codeunit "Temp Blob";
                            Streamin: InStream;
                        begin
                            TempBlobList.Get(LBKopf.Number, TempBlob);
                            TempBlob.CreateInStream(Streamin, TextEncoding::UTF8);

                            Streamin.Read(LBKopf_Description);
                            NewPageLBKopf += 1;
                        end;

                        trigger OnPreDataItem()
                        begin
                            PrintLongText.GetPrintText("Sales Invoice Header", Enum::"lbt Position"::Header, TempBlobList);
                            if TempBlobList.IsEmpty() then
                                CurrReport.Break();
                            LBKopf.SetRange(Number, 1, TempBlobList.Count());
                        end;
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(Number_Integer; DimensionLoop1.Number)
                        {
                        }
                        column(DimensionsCaption; DimensionsCaptionLbl)
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

                            LeBitReportFunctions.GetDimTextFromDimSetEntry(DimSetEntry1, DimText, Continue);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting("Document No.", "Line No.");
                        column(Item_Picture; Item.Picture)
                        {
                        }
                        column(ItemPictureExist; ItemPictureExist)
                        {
                        }
                        column(LineAmt_SalesInvoiceLine; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Description_SalesInvLine; Description)
                        {
                        }
                        column(Quantity_SalesInvoiceLine; Quantity)
                        {
                        }
                        column(UOM_SalesInvoiceLine; "Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvLine; UnitPrice)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 2;
                        }
                        column(SalesLineType; Format("Sales Invoice Line".Type, 0, 2))
                        {
                        }
                        column(InvDiscountAmount; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmt; TotalInvoiceDiscountAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amount_SalesInvoiceLine; Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountIncludingVATAmount; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(AmtInclVAT_SalesInvLine; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountVAT; TotalAmountVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscountOnVAT; TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(LineNo_SalesInvoiceLine; "Line No.")
                        {
                        }
                        column(PaymentDiscVATCaption; PaymentDiscVATCaptionLbl)
                        {
                        }
                        column(SalesLineLeBitPrintoption; Format("Sales Invoice Line"."lbt Printoption", 0, 2))
                        {
                        }
                        column(LeBitBalance_SalesInvoiceLine; "lbt Balance")
                        {
                        }
                        column(LeBitPosNo_SalesInvoiceLine; "lbt Pos. No.")
                        {
                        }
                        column(Description2_SalesInvoiceLine; "Description 2")
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
                        dataitem(ParameterAndUnits; "Integer")
                        {
                            DataItemTableView = sorting(Number);
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
                                SetRange(Number, 1, InfoRowNo);
                            end;
                        }
                        dataitem(LBLang; Integer)
                        {
                            DataItemTableView = sorting(Number);
                            column(LBLang_LineNo; '0') { }
                            column(LBLang_Description; LBLang_Description)
                            {
                            }
                            column(NewPageLBLang; NewPageLBLang)
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                TempBlob: Codeunit "Temp Blob";
                                Streamin: InStream;
                            begin
                                TempBlobList.Get(LBLang.Number, TempBlob);
                                TempBlob.CreateInStream(Streamin, TextEncoding::UTF8);

                                Streamin.Read(LBLang_Description);
                                NewPageLBLang += 1;
                            end;

                            trigger OnPreDataItem()
                            begin
                                PrintLongText.GetPrintText("Sales Invoice Line", Enum::"lbt Position"::Longtext, TempBlobList);
                                if TempBlobList.IsEmpty() then
                                    CurrReport.Break();
                                LBLang.SetRange(Number, 1, TempBlobList.Count());
                            end;
                        }
                        dataitem("Sales Shipment Buffer"; "Integer")
                        {
                            DataItemTableView = sorting(Number);
                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then
                                    TempSalesShipmentBuffer.Find('-')
                                else
                                    TempSalesShipmentBuffer.Next();
                            end;

                            trigger OnPreDataItem()
                            begin
                                TempSalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                                TempSalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");

                                SetRange(Number, 1, TempSalesShipmentBuffer.Count());
                            end;
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                            column(DimText_DimensionLoop2; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FindSet() then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                LeBitReportFunctions.GetDimTextFromDimSetEntry(DimSetEntry2, DimText, Continue);
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.Break();

                                DimSetEntry2.SetRange("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                            }
                            column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineDesc; BlanksForIndent() + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineNo; BlanksForIndent() + TempPostedAsmLine."No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record "Item Translation";
                            begin
                                if Number = 1 then
                                    TempPostedAsmLine.FindSet()
                                else
                                    TempPostedAsmLine.Next();

                                if ItemTranslation.Get(TempPostedAsmLine."No.",
                                     TempPostedAsmLine."Variant Code",
                                     "Sales Invoice Header"."Language Code")
                                then
                                    TempPostedAsmLine.Description := ItemTranslation.Description;
                            end;

                            trigger OnPreDataItem()
                            begin
                                Clear(TempPostedAsmLine);
                                if not DisplayAssemblyInformation then
                                    CurrReport.Break();
                                CollectAsmInformation();
                                Clear(TempPostedAsmLine);
                                SetRange(Number, 1, TempPostedAsmLine.Count());
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            IntVar: Integer;
                            TxtVar: Text;
                            Counter: Integer;
                        begin
                            PostedShipmentDate := 0D;
                            if Quantity <> 0 then
                                PostedShipmentDate := FindPostedShipmentDate();

                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then
                                "No." := '';

                            TempVATAmountLine.Init();
                            ;
                            TempVATAmountLine."VAT Identifier" := "VAT Identifier";
                            TempVATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            TempVATAmountLine."Tax Group Code" := "Tax Group Code";
                            TempVATAmountLine."VAT %" := "VAT %";
                            TempVATAmountLine."VAT Base" := Amount;
                            TempVATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            TempVATAmountLine."Line Amount" := "Line Amount";
                            if "Allow Invoice Disc." then
                                TempVATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            TempVATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            TempVATAmountLine."VAT Clause Code" := "VAT Clause Code";
                            TempVATAmountLine.InsertLine();

                            TotalSubTotal += "Line Amount";
                            TotalInvoiceDiscountAmt -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                            if "lbt Printoption" = "lbt Printoption"::"New Page" then
                                NewPageGroup += 1;

                            ItemUnitDescription := '';
                            ItemUnitQty := '';
                            Clear(InfoRowNo);
                            Clear(InfoCaptionArry);
                            Clear(InfoValueArry);
                            Clear(ItemUnitCodeArry);
                            Clear(ItemUnitDescriptionArry);
                            Clear(ItemUnitQtyArry);
                            Clear(Item);
                            ItemPictureExist := false;
                            CalcFields("lbt Balance");

                            if Quantity <> 0 then
                                UnitPrice := "Unit Price" - "Line Discount Amount" / Quantity
                            else
                                UnitPrice := 0;

                            if Type = Type::Item then begin
                                Item.Get("No.");
                                ItemPictureExist := Item.Picture.Count() > 0;
                                if not ItemPicturePrint then
                                    ItemPictureExist := false;
                                TxtVar := CurrReport.ObjectId(false);
                                TxtVar := CopyStr(TxtVar, StrPos(TxtVar, ' '));
                                Evaluate(IntVar, TxtVar);
                                LeBitReportFunctions.GetParameterArry(ReportType::Sales, IntVar, 1, "Sales Invoice Header"."Language Code", "Sales Invoice Line".RowID1(), '', "Sales Invoice Line"."No.", InfoCaptionArry, InfoValueArry);
                                LeBitReportFunctions.GetItemUnitArry(1, "Sales Invoice Line".RowID1(), '', "Sales Invoice Header"."Language Code", ItemUnitCodeArry, ItemUnitDescriptionArry, ItemUnitQtyArry);
                                Counter := 0;
                                repeat
                                    Counter += 1;
                                until (ItemUnitCodeArry[Counter] = "Unit of Measure Code") or
                                  (ItemUnitCodeArry[Counter] = '');
                                if ItemUnitCodeArry[Counter] <> '' then begin
                                    ItemUnitCodeArry[Counter] := '';
                                    ItemUnitDescriptionArry[Counter] := '';
                                    ItemUnitQtyArry[Counter] := '';
                                    CompressArray(ItemUnitCodeArry);
                                    CompressArray(ItemUnitDescriptionArry);
                                    CompressArray(ItemUnitQtyArry);
                                end;
                                if "Description 2" <> '' then begin
                                    ItemUnitDescription := ItemUnitDescriptionArry[1];
                                    ItemUnitQty := ItemUnitQtyArry[1];
                                    ItemUnitCodeArry[1] := '';
                                    ItemUnitDescriptionArry[1] := '';
                                    ItemUnitQtyArry[1] := '';
                                    CompressArray(ItemUnitCodeArry);
                                    CompressArray(ItemUnitDescriptionArry);
                                    CompressArray(ItemUnitQtyArry);
                                end;
                                //zus�tzliche Infos
                                if not HideShipmentDate then
                                    PrintShipmentDate(Counter);

                                //Auftragsnummer
                                if OrderNoText = '' then
                                    if "Sales Invoice Line"."Order No." <> '' then begin
                                        Counter := 0;
                                        repeat
                                            Counter += 1;
                                        until InfoCaptionArry[Counter] = '';
                                        InfoCaptionArry[Counter] := "Sales Invoice Header".FieldCaption("Order No.");
                                        InfoValueArry[Counter] := "Sales Invoice Line"."Order No.";
                                    end;

                                ///Pr�fung auf MaxRowNo
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
                            TempVATAmountLine.DeleteAll();
                            TempSalesShipmentBuffer.Reset();
                            TempSalesShipmentBuffer.DeleteAll();
                            FirstValueEntryNo := 0;
                            MoreLines := Find('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                                MoreLines := Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            SetRange("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(VATAmountLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATAmount; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineLineAmount; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscountAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmntSpecificCaption; VATAmntSpecificCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmountCaption; LineAmountCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if TempVATAmountLine.Count() < 2 then
                                CurrReport.Break();
                            SetRange(Number, 1, TempVATAmountLine.Count());
                        end;
                    }
                    dataitem(VATClauseEntryCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(VATClauseVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATClauseCode; TempVATAmountLine."VAT Clause Code")
                        {
                        }
                        column(VATClauseDescription; VATClause.Description)
                        {
                        }
                        column(VATClauseDescription2; VATClause."Description 2")
                        {
                        }
                        column(VATClauseAmount; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
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
                            TempVATAmountLine.GetLine(Number);
                            if not VATClause.Get(TempVATAmountLine."VAT Clause Code") then
                                CurrReport.Skip();
                            VATClause.TranslateDescription("Sales Invoice Header"."Language Code");
                        end;

                        trigger OnPreDataItem()
                        begin
                            Clear(VATClause);
                            SetRange(Number, 1, TempVATAmountLine.Count());
                        end;
                    }
                    dataitem(VatCounterLCY; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVAT_VatCounterLCY; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier_VatCounterLCY; TempVATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              TempVATAmountLine.GetBaseLCY(
                                "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                                "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY :=
                              TempVATAmountLine.GetAmountLCY(
                                "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                                "Sales Invoice Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if TempVATAmountLine.Count() < 2 then
                                CurrReport.Break();
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Invoice Header"."Currency Code" = '')
                            then
                                CurrReport.Break();

                            SetRange(Number, 1, TempVATAmountLine.Count());

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := VatAmountLbl + LCYLbl
                            else
                                VALSpecLCYHeader := VatAmountLbl + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            CalculatedExchRate := Round(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := StrSubstNo(ExchangeRateLbl, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(PaymentReportingArgument; "Payment Reporting Argument")
                    {
                        DataItemTableView = sorting(Key);
                        UseTemporary = true;
                        trigger OnPreDataItem()
                        var
                            PaymentServiceSetup: Record "Payment Service Setup";
                        begin
                            PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, "Sales Invoice Header");
                            if IsEmpty() then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                        column(SellToCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
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
                        column(ShipToAddressCaption; ShipToAddressCaptionLbl)
                        {
                        }
                        column(SellToCustNo_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(LineFee; "Integer")
                    {
                        DataItemTableView = sorting(Number) order(ascending) where(Number = filter(1 ..));
                        column(LineFeeCaptionLbl; TempLineFeeNoteOnReportHist.ReportText)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if not DisplayAdditionalFeeNote then
                                CurrReport.Break();

                            if Number = 1 then begin
                                if not TempLineFeeNoteOnReportHist.FindSet() then
                                    CurrReport.Break();
                            end else
                                if TempLineFeeNoteOnReportHist.Next() = 0 then
                                    CurrReport.Break();
                        end;
                    }
                    dataitem(LBFuss; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(LBFuss_LineNo; '0')
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
                            TempBlob: Codeunit "Temp Blob";
                            Streamin: InStream;
                        begin
                            TempBlobList.Get(LBFuss.Number, TempBlob);
                            TempBlob.CreateInStream(Streamin, TextEncoding::UTF8);

                            Streamin.Read(LBFuss_Description);
                            NewPageLBFuss += 1;
                        end;

                        trigger OnPreDataItem()
                        begin
                            PrintLongText.GetPrintText("Sales Invoice Header", Enum::"lbt Position"::Footer, TempBlobList);
                            if TempBlobList.IsEmpty() then
                                CurrReport.Break();
                            LBFuss.SetRange(Number, 1, TempBlobList.Count());
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    end;

                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmt := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscountOnVAT := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview() then
                        Codeunit.Run(Codeunit::"Sales Inv.-Printed", "Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                FormatAddressFields("Sales Invoice Header");
                FormatDocumentFields("Sales Invoice Header");
                CompanyInfo."lbt SetReportFooter"(Footer);

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");

                GetLineFeeNoteOnReportHist("No.");

                if LogInteraction then
                    if not CurrReport.Preview() then
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, Database::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        else
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, Database::Customer, "Bill-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');

                OrderNo := "Sales Invoice Header"."Order No.";
                Counter := 0;
                if OrderNoText = '' then begin
                    SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                    SalesInvoiceLine.SetFilter(Type, '<>%1', SalesInvoiceLine.Type::" ");
                    if SalesInvoiceLine.FindSet() then
                        repeat
                            Counter += 1;
                            if Counter = 1 then
                                OrderNo := SalesInvoiceLine."Order No."
                            else
                                if OrderNo <> SalesInvoiceLine."Order No." then
                                    OrderNo := '';
                        until SalesInvoiceLine.Next() = 0;
                    OrderNoText := FormatDocument.SetText(OrderNo <> '', CopyStr(FieldCaption("Order No."), 1, 80));
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
                    field("Display AsmInformation"; DisplayAssemblyInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies that you want to display the assembly components';
                    }
                    field("Display AdditionalFeeNote"; DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Additional Fee Note';
                        ToolTip = 'Specifies that any notes about additional fees are included on the document.';
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
                        ToolTip = 'Specifies that the images are printed ';
                    }
                    field("Hide Shipment Date"; HideShipmentDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Hide Shipment Date';
                        ToolTip = 'Hide Shipment Date in Lines';
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
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        SalesSetup.Get();
        CorrSetup.Get();
        CompanyInfo.Get();
        CompanyInfo.VerifyAndSetPaymentInfo();
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage() then
            InitLogInteraction();
    end;

    protected var
        CompanyInfo: Record "Company Information";

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        Cust: Record Customer;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        VATClause: Record "VAT Clause";
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        Item: Record Item;
        SalesInvoiceLine: Record "Sales Invoice Line";
        CorrSetup: Record "lbt Corr Setup";
        PaymentMethod: Record "Payment Method";
        LeBitReportFunctions: Codeunit "lbt Report Functions";
        Language: Codeunit Language;
        PrintLongText: Codeunit "lbt cl Print Longtext";
        TempBlobList: Codeunit "Temp Blob List";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[80];
        SalesPersonText: Text[50];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VatAmountLbl: Label 'VAT Amount Specification in ';
        LCYLbl: Label 'Local Currency';
        VALExchRate: Text[50];
        ExchangeRateLbl: Label 'Exchange rate: %1/%2', Comment = '%1 - Rel. Amount, %2 - Amount';
        CalculatedExchRate: Decimal;
        PrepaymentTitleLbl: Label 'Prepayment Invoice %1', Comment = '%1 - Document No.';
        TitleLbl: Label 'Invoice %1', Comment = '%1 - Document No.';
        OutputNo: Integer;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmt: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        InvoiceNoCaptionLbl: Label 'Invoice No.';
        DimensionsCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        VATClausesCapLbl: Label 'VAT Clause';
        PostedShipmentDateCaptionLbl: Label 'Posted Shipment Date';
        SubtotalCaptionLbl: Label 'Subtotal';
        PaymentDiscVATCaptionLbl: Label 'Payment Discount on VAT';
        ShipmentCaptionLbl: Label 'Shipment';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        VATAmntSpecificCaptionLbl: Label 'VAT Amount Specification';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmountCaptionLbl: Label 'Line Amount';
        ShipToAddressCaptionLbl: Label 'Ship-to Address';
        InvDiscountAmountCaptionLbl: Label 'Invoice Discount Amount';
        VATCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmountCaptionLbl: Label 'VAT Amount';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        TotalCaptionLbl: Label 'Total';
        PaymentTermsCaptionLbl: Label 'Payment Terms';
        ShipmentMethodCaptionLbl: Label 'Shipment Method';
        DisplayAdditionalFeeNote: Boolean;
        CompanyAddressLine: Text;
        InfoCaptionArry: array[99] of Text;
        InfoValueArry: array[99] of Text;
        ItemUnitCodeArry: array[50] of Code[20];
        ItemUnitDescriptionArry: array[50] of Text;
        ItemUnitQtyArry: array[50] of Text;
        InfoRowNo: Integer;
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
        SalesPersonText_CaptionLbl: Label 'Salesperson';
        ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report";
        UnitPrice: Decimal;
        OrderNo: Code[20];
        Counter: Integer;
        VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        Footer: Text;
        PaymentMethodCaptionLbl: Label 'Payment Method';
        HideShipmentDate: Boolean;

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Inv.") <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        TempSalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        if "Sales Invoice Line"."Shipment No." <> '' then
            if SalesShipmentHeader.Get("Sales Invoice Line"."Shipment No.") then
                exit(SalesShipmentHeader."Posting Date");

        if "Sales Invoice Header"."Order No." = '' then
            exit("Sales Invoice Header"."Posting Date");

        case "Sales Invoice Line".Type of
            "Sales Invoice Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Invoice Line");
            "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource,
          "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Invoice Line");
            "Sales Invoice Line".Type::" ":
                exit(0D);
        end;

        TempSalesShipmentBuffer.Reset();
        TempSalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
        TempSalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
        if TempSalesShipmentBuffer.Find('-') then begin
            TempSalesShipmentBuffer2 := TempSalesShipmentBuffer;
            if TempSalesShipmentBuffer.Next() = 0 then begin
                TempSalesShipmentBuffer.Get(
                  TempSalesShipmentBuffer2."Document No.", TempSalesShipmentBuffer2."Line No.", TempSalesShipmentBuffer2."Entry No.");
                TempSalesShipmentBuffer.Delete();
                exit(TempSalesShipmentBuffer2."Posting Date");
            end;
            TempSalesShipmentBuffer.CalcSums(Quantity);
            if TempSalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity then begin
                TempSalesShipmentBuffer.DeleteAll();
                exit("Sales Invoice Header"."Posting Date");
            end;
        end else
            exit("Sales Invoice Header"."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SetCurrentKey("Document No.");
        ValueEntry.SetRange("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
        ValueEntry.SetRange("Item Charge No.", '');
        ValueEntry.SetFilter("Entry No.", '%1..', FirstValueEntryNo);
        if ValueEntry.Find('-') then
            repeat
                if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
                    if SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 then
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    else
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesInvoiceLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                end;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            until (ValueEntry.Next() = 0) or (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesInvoiceHeader.SetCurrentKey("Order No.");
        SalesInvoiceHeader.SetFilter("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        if SalesInvoiceHeader.Find('-') then
            repeat
                SalesInvoiceLine2.SetRange("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SetRange("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SetRange("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                if SalesInvoiceLine2.Find('-') then
                    repeat
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    until SalesInvoiceLine2.Next() = 0;
            until SalesInvoiceHeader.Next() = 0;

        SalesShipmentLine.SetCurrentKey("Order No.", "Order Line No.");
        SalesShipmentLine.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SetRange("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SetRange("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SetRange(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SetRange("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SetFilter(Quantity, '<>%1', 0);

        if SalesShipmentLine.Find('-') then
            repeat
                if "Sales Invoice Header"."Get Shipment Used" then
                    CorrectShipment(SalesShipmentLine);
                if Abs(SalesShipmentLine.Quantity) <= Abs(TotalQuantity - SalesInvoiceLine.Quantity) then
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                else begin
                    if Abs(SalesShipmentLine.Quantity) > Abs(TotalQuantity) then
                        SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity :=
                      SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

                    if SalesShipmentHeader.Get(SalesShipmentLine."Document No.") then
                        AddBufferEntry(
                          SalesInvoiceLine,
                          Quantity,
                          SalesShipmentHeader."Posting Date");

                end;
            until (SalesShipmentLine.Next() = 0) or (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        l_SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        l_SalesInvoiceLine.SetCurrentKey("Shipment No.", "Shipment Line No.");
        l_SalesInvoiceLine.SetRange("Shipment No.", SalesShipmentLine."Document No.");
        l_SalesInvoiceLine.SetRange("Shipment Line No.", SalesShipmentLine."Line No.");
        if l_SalesInvoiceLine.Find('-') then
            repeat
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - l_SalesInvoiceLine.Quantity;
            until l_SalesInvoiceLine.Next() = 0;
    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        TempSalesShipmentBuffer.SetRange("Document No.", SalesInvoiceLine."Document No.");
        TempSalesShipmentBuffer.SetRange("Line No.", SalesInvoiceLine."Line No.");
        TempSalesShipmentBuffer.SetRange("Posting Date", PostingDate);
        if TempSalesShipmentBuffer.Find('-') then begin
            TempSalesShipmentBuffer.Quantity := TempSalesShipmentBuffer.Quantity + QtyOnShipment;
            TempSalesShipmentBuffer.Modify();
            exit;
        end;

        TempSalesShipmentBuffer."Document No." := SalesInvoiceLine."Document No.";
        TempSalesShipmentBuffer."Line No." := SalesInvoiceLine."Line No.";
        TempSalesShipmentBuffer."Entry No." := NextEntryNo;
        TempSalesShipmentBuffer.Type := SalesInvoiceLine.Type;
        TempSalesShipmentBuffer."No." := SalesInvoiceLine."No.";
        TempSalesShipmentBuffer.Quantity := QtyOnShipment;
        TempSalesShipmentBuffer."Posting Date" := PostingDate;
        TempSalesShipmentBuffer.Insert();
        NextEntryNo := NextEntryNo + 1
    end;

    local procedure DocumentCaption(): Text
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption("Sales Invoice Header", DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);
        if "Sales Invoice Header"."Prepayment Invoice" then
            exit(PrepaymentTitleLbl);
        exit(TitleLbl);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        lbtFormatDocument: Codeunit "lbt Format Document";
    begin
        lbtFormatDocument.SetTotalLabels(SalesInvoiceHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalesPurchPerson, SalesInvoiceHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesInvoiceHeader."Payment Terms Code", SalesInvoiceHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesInvoiceHeader."Shipment Method Code", SalesInvoiceHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesInvoiceHeader."Payment Method Code", SalesInvoiceHeader."Language Code");

        OrderNoText := FormatDocument.SetText(SalesInvoiceHeader."Order No." <> '', CopyStr(SalesInvoiceHeader.FieldCaption("Order No."), 1, 80));
        ReferenceText := FormatDocument.SetText(SalesInvoiceHeader."Your Reference" <> '', CopyStr(SalesInvoiceHeader.FieldCaption("Your Reference"), 1, 80));
        VATNoText := FormatDocument.SetText(SalesInvoiceHeader."VAT Registration No." <> '', CopyStr(SalesInvoiceHeader.FieldCaption("VAT Registration No."), 1, 80));
        if SalesPersonText <> '' then
            SalesPersonText := SalesPersonText_CaptionLbl;
    end;

    local procedure FormatAddressFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        i: Integer;
    begin
        FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
        ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);
        Clear(CompanyAddressLine);

        for i := 1 to 6 do
            if CompanyAddr[i] <> '' then begin
                if CompanyAddressLine <> '' then
                    CompanyAddressLine := CompanyAddressLine + ', ';
                CompanyAddressLine := CompanyAddressLine + CompanyAddr[i];
            end;
    end;

    procedure CollectAsmInformation()
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        TempPostedAsmLine.DeleteAll();
        if "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item then
            exit;
        ValueEntry.SetCurrentKey("Document No.");
        ValueEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
        ValueEntry.SetRange(Adjustment, false);
        if not ValueEntry.FindSet() then
            exit;
        repeat
            if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then
                if ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" then begin
                    SalesShipmentLine.Get(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) then begin
                        PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
                        if PostedAsmLine.FindSet() then
                            repeat
                                TreatAsmLineBuffer(PostedAsmLine);
                            until PostedAsmLine.Next() = 0;
                    end;
                end;

        until ValueEntry.Next() = 0;
    end;

    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        Clear(TempPostedAsmLine);
        TempPostedAsmLine.SetRange(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SetRange("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SetRange("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SetRange(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SetRange("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        if TempPostedAsmLine.FindFirst() then begin
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.Modify();
        end else begin
            Clear(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.Insert();
        end;
    end;

    procedure GetUOMText(UOMCode: Code[10]): Text
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PadStr('', 2, ' '));
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
    begin
        TempLineFeeNoteOnReportHist.DeleteAll();
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FindFirst() then
            exit;

        if not Customer.Get(CustLedgerEntry."Customer No.") then
            exit;

        LineFeeNoteOnReportHist.SetRange("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SetRange("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FindSet() then
            repeat
                TempLineFeeNoteOnReportHist.Init();
                ;
                TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.Insert();
            until LineFeeNoteOnReportHist.Next() = 0
        else begin
            LineFeeNoteOnReportHist.SetRange("Language Code", Language.GetUserLanguageCode());
            if LineFeeNoteOnReportHist.FindSet() then
                repeat
                    TempLineFeeNoteOnReportHist.Init();
                    ;
                    TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.Insert();
                until LineFeeNoteOnReportHist.Next() = 0;
        end;
    end;

    local procedure PrintShipmentDate(var Counter: Integer)
    begin
        if PostedShipmentDate <> 0D then begin
            Counter := 0;
            repeat
                Counter += 1;
            until InfoCaptionArry[Counter] = '';
            InfoCaptionArry[Counter] := PostedShipmentDateCaptionLbl;
            InfoValueArry[Counter] := Format(PostedShipmentDate);
        end else begin
            TempSalesShipmentBuffer.Reset();
            TempSalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
            TempSalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
            if TempSalesShipmentBuffer.FindSet() then begin
                Counter := 0;
                repeat
                    Counter += 1;
                until (InfoCaptionArry[Counter] = '') and
                  (ItemUnitDescriptionArry[Counter] = '');
                Counter -= 1;
                repeat
                    Counter += 1;
                    InfoCaptionArry[Counter] := ShipmentCaptionLbl;
                    InfoValueArry[Counter] := Format(TempSalesShipmentBuffer."Posting Date");
                    ItemUnitQtyArry[Counter] := Format(TempSalesShipmentBuffer.Quantity);
                    ItemUnitDescriptionArry[Counter] := "Sales Invoice Line"."Unit of Measure";
                until TempSalesShipmentBuffer.Next() = 0;
            end;
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesInvoiceHeader: Record "Sales Invoice Header"; var DocCaption: Text);
    begin
    end;
}


