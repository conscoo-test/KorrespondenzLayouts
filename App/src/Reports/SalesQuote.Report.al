report 5272720 "lbt Sales - Quote"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/SalesQuote.Report.rdlc';

    Caption = 'Sales - Quote';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote';
            column(Footer; Footer) { }
            column(AlwaysPrintVat_CorrSetup; CorrSetup."Always print VAT") { }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInfo2_Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo1_Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(DocumentConfirmCopyCaption; STRSUBSTNO(DocCaptionLbl, CopyText))
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
                    column(Sales_Header___Document_Date; FORMAT("Sales Header"."Document Date", 0, 4))
                    {
                    }
                    column(Sales_Header___No__; "Sales Header"."No.")
                    {
                    }
                    column(Sales_Header___Bill_to_Customer_No__; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Header___VAT_Registration_No__; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(Sales_Header___Your_Reference_; "Sales Header"."Your Reference")
                    {
                    }
                    column(Sales_Header___Prices_Including_VAT_; "Sales Header"."Prices Including VAT")
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(HideCompanyInfo; HideCompanyInfo)
                    {
                    }
                    column(Sales_Header___Bill_to_Customer_No__Caption; Sales_Header___Bill_to_Customer_No__CaptionLbl)
                    {
                    }
                    column(Sales_Header___No__Caption; Sales_Header___No__CaptionLbl)
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
                    column(Sales_Line_PosNo_Caption; PosNo_SalesLineCaptionLbl)
                    {
                    }
                    column(Sales_Line__Description_Caption; "Sales Line".FIELDCAPTION(Description))
                    {
                    }
                    column(Sales_Line__Quantity_Caption; "Sales Line".FIELDCAPTION(Quantity))
                    {
                    }
                    column(Sales_Line_UOM_Caption; UOM_SalesLineCaptionLbl)
                    {
                    }
                    column(Sales_Line_Unit_Price_Caption; Unit_PriceCaptionLbl)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(CarryForwardText; STRSUBSTNO(CarryForwardCaptionLbl, GLSetup."LCY Code"))
                    {
                    }
                    column(SubtotalCaption; SubtotalCaptionLbl)
                    {
                    }
                    column(VAT_Registration_No__Caption; VAT_Registration_No__CaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
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
                                    DimText := STRSUBSTNO(DimLbl, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      STRSUBSTNO(
                                        CombinedDimLbl, DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
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
                    dataitem(LBKopf; "lbt PS Longtext Line")
                    {
                        DataItemLink = "Document No." = FIELD("No."), "Document Type" = FIELD("Document Type");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE("Table ID" = CONST(36), Position = CONST(Header));

                        trigger OnAfterGetRecord()
                        begin
                            Createlbtext(LBKopf);
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempLeBitPSLongtextLine.DeleteAll();
                        end;
                    }
                    dataitem(TempLBKopf; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(LBKopf_LineNo; FORMAT(TempLeBitPSLongtextLine."Line No."))
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
                                TempLeBitPSLongtextLine.FindSet()
                            else
                                TempLeBitPSLongtextLine.Next();

                            LBKopf_Description := '';

                            case TempLeBitPSLongtextLine.Type of
                                TempLeBitPSLongtextLine.Type::Text,
                                TempLeBitPSLongtextLine.Type::"Text + Line break":
                                    begin
                                        TempLeBitPSLongtextLine.CALCFIELDS(Text);
                                        if TempLeBitPSLongtextLine.Text.HasValue() then begin
                                            TempLeBitPSLongtextLine.Text.CREATEINSTREAM(Streamin);
                                            Streamin.READ(LBKopf_Description);
                                        end;
                                    end;
                                TempLeBitPSLongtextLine.Type::"New Page":
                                    begin
                                        NewPageLBKopf += 1;
                                        LBKopf_Description := '';
                                    end;
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if TempLeBitPSLongtextLine.IsEmpty() then
                                CurrReport.Break();

                            TempLBKopf.SETRANGE(Number, 1, TempLeBitPSLongtextLine.Count());
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break();
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(Item_Picture; Item.Picture)
                        {
                        }
                        column(ItemPictureExist; ItemPictureExist)
                        {
                        }
                        column(Sales_Line__Description; "Sales Line".Description)
                        {
                        }
                        column(Sales_Line__Quantity; "Sales Line".Quantity)
                        {
                        }
                        column(Sales_Line___Unit_of_Measure_; "Sales Line"."Unit of Measure")
                        {
                        }
                        column(Sales_Line___Line_Amount_; "Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line___Unit_Price_; "Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(UnitPrice; UnitPrice)
                        {
                        }
                        column(SalesLineType; FORMAT("Sales Line".Type, 0, 2))
                        {
                        }
                        column(SalesLineNo; "Sales Line"."Line No.")
                        {
                        }
                        column(SalesLine__Inv__Discount_Amount_; -TempSalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(VATAmountLine_VATAmountText; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Inv__Discount_Amount_Caption; SalesLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(SalesLineLeBitPrintoption; FORMAT("Sales Line"."lbt Printoption", 0, 2))
                        {
                        }
                        column(SalesLine__LeBit_Balance; TempSalesLine."lbt Balance")
                        {
                        }
                        column(Sales_Line___LeBit_Pos_No; "Sales Line"."lbt Pos. No.")
                        {
                        }
                        column(Alternativposition_Caption; Alternativposition_CaptionLbl)
                        {
                        }
                        column(Bedarfposition_Caption; Bedarfposition_CaptionLbl)
                        {
                        }
                        column(BitteAndern_Caption; BitteAndern_CaptionLbl)
                        {
                        }
                        column(Sales_Line___Description_2; "Sales Line"."Description 2")
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
                        dataitem(LBLang; "lbt PS Longtext Line")
                        {
                            DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                            DataItemLinkReference = "Sales Line";
                            DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE("Table ID" = CONST(37), Position = CONST(Longtext));

                            trigger OnAfterGetRecord()
                            begin
                                Createlbtext(LBLang);
                            end;

                            trigger OnPreDataItem()
                            begin
                                TempLeBitPSLongtextLine.DeleteAll();
                            end;
                        }
                        dataitem(TempLBLang; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(LBLang_LineNo; FORMAT(TempLeBitPSLongtextLine."Line No."))
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
                                    TempLeBitPSLongtextLine.FindSet()
                                else
                                    TempLeBitPSLongtextLine.Next();

                                LBLang_Description := '';

                                case TempLeBitPSLongtextLine.Type of
                                    TempLeBitPSLongtextLine.Type::Text,
                                    TempLeBitPSLongtextLine.Type::"Text + Line break":
                                        begin
                                            TempLeBitPSLongtextLine.CALCFIELDS(Text);
                                            if TempLeBitPSLongtextLine.Text.HasValue() then begin
                                                TempLeBitPSLongtextLine.Text.CREATEINSTREAM(Streamin);
                                                Streamin.READ(LBLang_Description);
                                            end;
                                        end;
                                    TempLeBitPSLongtextLine.Type::"New Page":
                                        begin
                                            NewPageLBLang += 1;
                                            LBLang_Description := '';
                                        end;
                                end;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if TempLeBitPSLongtextLine.IsEmpty() then
                                    CurrReport.Break();

                                TempLBLang.SETRANGE(Number, 1, TempLeBitPSLongtextLine.Count());
                            end;
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText_Control81; DimText)
                            {
                            }
                            column(Line_DimensionsCaption; Line_DimensionsCaptionLbl)
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

                                CLEAR(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := STRSUBSTNO(DimLbl, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          STRSUBSTNO(
                                            CombinedDimLbl, DimText,
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            IntVar: Integer;
                            TxtVar: Text;
                            Counter: Integer;
                        begin
                            if Number = 1 then
                                TempSalesLine.FIND('-')
                            else
                                TempSalesLine.Next();
                            "Sales Line" := TempSalesLine;

                            if not "Sales Header"."Prices Including VAT" and
                               (TempSalesLine."VAT Calculation Type" = TempSalesLine."VAT Calculation Type"::"Full VAT")
                            then
                                TempSalesLine."Line Amount" := 0;

                            if (TempSalesLine.Type = TempSalesLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Sales Line"."No." := '';

                            if TempSalesLine."lbt Printoption" = TempSalesLine."lbt Printoption"::"New Page" then
                                NewPageGroup += 1;

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

                            if TempSalesLine.Quantity <> 0 then
                                UnitPrice := TempSalesLine."Unit Price" - TempSalesLine."Line Discount Amount" / TempSalesLine.Quantity
                            else
                                UnitPrice := 0;

                            TempSalesLine.CALCFIELDS("lbt Balance");
                            if TempSalesLine.Type = TempSalesLine.Type::Item then begin
                                Item.Get("Sales Line"."No.");
                                ItemPictureExist := Item.Picture.Count() > 0;
                                if not ItemPicturePrint then
                                    ItemPictureExist := false;
                                TxtVar := CurrReport.OBJECTID(false);
                                TxtVar := COPYSTR(TxtVar, STRPOS(TxtVar, ' '));
                                EVALUATE(IntVar, TxtVar);
                                LeBitReportFunctions.GetParameterArry(ReportType::Sales, IntVar, 2, "Sales Header"."Language Code", "Sales Line".RowID1(), '', "Sales Line"."No.", InfoCaptionArry, InfoValueArry);
                                LeBitReportFunctions.GetItemUnitArry(2, "Sales Line".RowID1(), '', "Sales Header"."Language Code", ItemUnitCodeArry, ItemUnitDescriptionArry, ItemUnitQtyArry);
                                Counter := 0;
                                repeat
                                    Counter += 1;
                                until (ItemUnitCodeArry[Counter] = "Sales Line"."Unit of Measure Code") or
                                  (ItemUnitCodeArry[Counter] = '');
                                if ItemUnitCodeArry[Counter] <> '' then begin
                                    ItemUnitCodeArry[Counter] := '';
                                    ItemUnitDescriptionArry[Counter] := '';
                                    ItemUnitQtyArry[Counter] := '';
                                    COMPRESSARRAY(ItemUnitCodeArry);
                                    COMPRESSARRAY(ItemUnitDescriptionArry);
                                    COMPRESSARRAY(ItemUnitQtyArry);
                                end;
                                if TempSalesLine."Description 2" <> '' then begin
                                    ItemUnitDescription := ItemUnitDescriptionArry[1];
                                    ItemUnitQty := ItemUnitQtyArry[1];
                                    ItemUnitCodeArry[1] := '';
                                    ItemUnitDescriptionArry[1] := '';
                                    ItemUnitQtyArry[1] := '';
                                    COMPRESSARRAY(ItemUnitCodeArry);
                                    COMPRESSARRAY(ItemUnitDescriptionArry);
                                    COMPRESSARRAY(ItemUnitQtyArry);
                                end;
                                Counter := 0;
                                repeat
                                    Counter += 1;
                                until (InfoCaptionArry[Counter] = '') and
                                  (ItemUnitDescriptionArry[Counter] = '');
                                InfoRowNo := Counter - 1;
                            end;
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempSalesLine.DeleteAll();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempSalesLine.FIND('+');
                            while MoreLines and (TempSalesLine.Description = '') and (TempSalesLine."Description 2" = '') and
                                  (TempSalesLine."No." = '') and (TempSalesLine.Quantity = 0) and
                                  (TempSalesLine.Amount = 0)
                            do
                                MoreLines := TempSalesLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            TempSalesLine.SETRANGE("Line No.", 0, TempSalesLine."Line No.");
                            SETRANGE(Number, 1, TempSalesLine.Count());
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine__VAT_Base_; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control69; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control70; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control71; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control72; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control73; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier_; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control114; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control70Caption; VATAmountLine__VAT_Base__Control70CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control69Caption; VATAmountLine__VAT_Amount__Control69CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control73Caption; VATAmountLine__Line_Amount__Control73CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control72Caption; VATAmountLine__Inv__Disc__Base_Amount__Control72CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control71Caption; VATAmountLine__Invoice_Discount_Amount__Control71CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control114Caption; VATAmountLine__VAT_Base__Control114CaptionLbl)
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
                            if VATAmount = 0 then
                                CurrReport.Break();
                            SETRANGE(Number, 1, TempVATAmountLine.Count());
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
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control152; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control153; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT____Control154; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier__Control155; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATBaseLCY_Control160; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control152Caption; VALVATAmountLCY_Control152CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control153Caption; VALVATBaseLCY_Control153CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT____Control154Caption; VATAmountLine__VAT____Control154CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier__Control155Caption; VATAmountLine__VAT_Identifier__Control155CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control160Caption; VALVATBaseLCY_Control160CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              TempVATAmountLine.GetBaseLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                            VALVATAmountLCY :=
                              TempVATAmountLine.GetAmountLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if TempVATAmountLine.Count() < 2 then
                                CurrReport.Break();
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Header"."Currency Code" = '') or
                               (TempVATAmountLine.GetTotalVATAmount() = 0)
                            then
                                CurrReport.Break();

                            SETRANGE(Number, 1, TempVATAmountLine.Count());

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := VatAmountLbl + LCYLbl
                            else
                                VALSpecLCYHeader := VatAmountLbl + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Order Date", "Sales Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(ExchangeRateLbl, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(PaymentTerms_Description; PaymentTerms.Description)
                        {
                        }
                        column(ShipmentMethod_Description; ShipmentMethod.Description)
                        {
                        }
                        column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                        {
                        }
                        column(ShipmentMethod_DescriptionCaption; ShipmentMethod_DescriptionCaptionLbl)
                        {
                        }
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(Sales_Header___Sell_to_Customer_No__; "Sales Header"."Sell-to Customer No.")
                        {
                        }
                        column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
                        {
                        }
                        column(Sales_Header___Sell_to_Customer_No__Caption; "Sales Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }
                        column(ShipToAddr_1_; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr_2_; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr_3_; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr_4_; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr_5_; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr_6_; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr_7_; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr_8_; ShipToAddr[8])
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(LBFuss; "lbt PS Longtext Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE("Table ID" = CONST(36), Position = CONST(Footer));

                        trigger OnAfterGetRecord()
                        begin
                            Createlbtext(LBFuss);
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempLeBitPSLongtextLine.DeleteAll();
                        end;
                    }
                    dataitem(TempLBFuss; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(LBFuss_LineNo; FORMAT(TempLeBitPSLongtextLine."Line No."))
                        {
                        }
                        column(NewPageLBFuss; NewPageLBFuss)
                        {
                        }
                        column(LBFuss_Description; LBFuss_Description)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            Streamin: InStream;
                        begin
                            if TempLBFuss.Number = 1 then
                                TempLeBitPSLongtextLine.FindSet()
                            else
                                TempLeBitPSLongtextLine.Next();

                            LBFuss_Description := '';

                            case TempLeBitPSLongtextLine.Type of
                                TempLeBitPSLongtextLine.Type::Text,
                                TempLeBitPSLongtextLine.Type::"Text + Line break":
                                    begin
                                        TempLeBitPSLongtextLine.CALCFIELDS(Text);
                                        if TempLeBitPSLongtextLine.Text.HasValue() then begin
                                            TempLeBitPSLongtextLine.Text.CREATEINSTREAM(Streamin);
                                            Streamin.READ(LBFuss_Description);
                                        end;
                                    end;
                                TempLeBitPSLongtextLine.Type::"New Page":
                                    begin
                                        NewPageLBFuss += 1;
                                        LBFuss_Description := '';
                                    end;
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if TempLeBitPSLongtextLine.IsEmpty() then
                                CurrReport.Break();

                            TempLBFuss.SETRANGE(Number, 1, TempLeBitPSLongtextLine.Count());
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    CLEAR(TempSalesLine);
                    CLEAR(SalesPost);
                    TempSalesLine.DeleteAll();
                    TempVATAmountLine.DeleteAll();
                    SalesPost.GetSalesLines("Sales Header", TempSalesLine, 0);
                    TempSalesLine.CalcVATAmountLines(0, "Sales Header", TempSalesLine, TempVATAmountLine);
                    TempSalesLine.UpdateVATOnLines(0, "Sales Header", TempSalesLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    if Print then
                        CODEUNIT.RUN(CODEUNIT::"Sales-Printed", "Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                    NewPageGroup := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                FormatAddressFields("Sales Header");
                FormatDocumentFields("Sales Header");
                CompanyInfo."lbt SetReportFooter"(Footer);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if Print then begin
                    if CurrReport.UseRequestPage() and ArchiveDocument or
                       not CurrReport.UseRequestPage() and (SalesSetup."Archive Quotes" = SalesSetup."Archive Quotes"::Always)
                    then
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    if LogInteraction then begin
                        CALCFIELDS("No. of Archived Versions");
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        else
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    end;
                end;
                MARK(true);
            end;

            trigger OnPostDataItem()
            var
                ToDo: Record "To-do";
            begin
                MARKEDONLY := true;
                COMMIT();
                if CurrentClientType() <> ClientType::Web then
                    if FIND('-') and ToDo.WRITEPERMISSION() then
                        if Print and (NoOfRecords = 1) then
                            if CONFIRM(FollowUpQst) then
                                CreateTask();
            end;

            trigger OnPreDataItem()
            begin
                NoOfRecords := Count();
                Print := Print or not CurrReport.PREVIEW();
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
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }

                    field("Show InternalInfo"; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                        ApplicationArea = All;
                        ToolTip = 'Specifies if the document shows internal information.';
                    }
                    field("Archive Document"; ArchiveDocument)
                    {
                        Caption = 'Archive Document';
                        ApplicationArea = All;
                        ToolTip = 'Specifies if the document is archived after you preview or print it.';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field("Log Interaction"; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        ApplicationArea = All;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                        Enabled = LogInteractionEnable;
                    }
                    field("Hide CompanyInfo"; HideCompanyInfo)
                    {
                        Caption = 'Hide Company Info';
                        ApplicationArea = All;
                        ToolTip = 'Specifies that the company data is to be "hidden" for printing';
                    }
                    field("Item Picture Print"; ItemPicturePrint)
                    {
                        Caption = 'Print Item Picture';
                        ApplicationArea = All;
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
            case SalesSetup."Archive Quotes" of
                SalesSetup."Archive Quotes"::Never:
                    ArchiveDocument := false;
                SalesSetup."Archive Quotes"::Always:
                    ArchiveDocument := true;
            end;
            LogInteraction := SegManagement.FindInteractTmplCode(1) <> '';

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

        if not HideCompanyInfo then
            case SalesSetup."Logo Position on Documents" of
                SalesSetup."Logo Position on Documents"::"No Logo":
                    ;
                SalesSetup."Logo Position on Documents"::Left:
                    CompanyInfo.CALCFIELDS(Picture);
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
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        Item: Record Item;
        TempLeBitPSLongtextLine: Record "lbt PS Longtext Line" temporary;
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        TempSalesLine: Record "Sales Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        CorrSetup: Record "lbt Corr Setup";
        Language: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        LeBitReportFunctions: Codeunit "lbt Report Functions";
        FormatDocument: Codeunit "Format Document";
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
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
        DimText: Text;
        OldDimText: Text;
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        FollowUpQst: Label 'Do you want to create a follow-up to-do?';
        NoOfRecords: Integer;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        VatAmountLbl: Label 'VAT Amount Specification in ';
        LCYLbl: Label 'Local Currency';
        ExchangeRateLbl: Label 'Exchange rate: %1/%2', Comment = '%1 - Rel. Amount, %2 - Amount';
        OutputNo: Integer;
        Print: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        Sales_Header___No__CaptionLbl: Label 'Quote No.';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        AmountCaptionLbl: Label 'Amount';
        SalesLine__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT_Base__Control70CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT_Amount__Control69CaptionLbl: Label 'VAT Amount';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmountLine__Line_Amount__Control73CaptionLbl: Label 'Line Amount';
        VATAmountLine__Inv__Disc__Base_Amount__Control72CaptionLbl: Label 'Inv. Disc. Base Amount';
        VATAmountLine__Invoice_Discount_Amount__Control71CaptionLbl: Label 'Invoice Discount Amount';
        VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
        VATAmountLine__VAT_Base__Control114CaptionLbl: Label 'Total';
        VALVATAmountLCY_Control152CaptionLbl: Label 'VAT Amount';
        VALVATBaseLCY_Control153CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT____Control154CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT_Identifier__Control155CaptionLbl: Label 'VAT Identifier';
        VALVATBaseLCY_Control160CaptionLbl: Label 'Total';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method';
        Ship_to_AddressCaptionLbl: Label 'Ship-to Address';
        CompanyAddressLine: Text;
        DocCaptionLbl: Label 'Quote %1', Comment = '%1 - Document No.';
        PageFromPageCaptionLbl: Label 'Page %1 of %2', Comment = '%1 - Current Page, %2 - Total Pages';
        NoCaptionLbl: Label 'No.';
        FromCaptionLbl: Label 'from';
        Sales_Header___Bill_to_Customer_No__CaptionLbl: Label 'Customer ID';
        DatumCaptionLbl: Label 'Date';
        InfoCaptionArry: array[99] of Text;
        InfoValueArry: array[99] of Text;
        ItemUnitCodeArry: array[50] of Code[20];
        ItemUnitDescriptionArry: array[50] of Text;
        ItemUnitQtyArry: array[50] of Text;
        InfoRowNo: Integer;
        ItemUnitDescription: Text;
        ItemUnitQty: Text;
        HideCompanyInfo: Boolean;
        Alternativposition_CaptionLbl: Label 'Alternative position';
        Bedarfposition_CaptionLbl: Label 'Position requirements';
        BitteAndern_CaptionLbl: Label 'please change!';
        PosNo_SalesLineCaptionLbl: Label 'Pos.';
        UOM_SalesLineCaptionLbl: Label 'Unit';
        CarryForwardCaptionLbl: Label 'Carry-forward %1', Comment = '%1 - Amount';
        NewPageGroup: Integer;
        ItemPictureExist: Boolean;
        ItemPicturePrint: Boolean;
        LBKopf_Description: Text;
        NewPageLBKopf: Integer;
        LBLang_Description: Text;
        NewPageLBLang: Integer;
        LBFuss_Description: Text;
        NewPageLBFuss: Integer;
        SalesPersonText_CaptionLbl: Label 'Salesperson';
        ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report";
        UnitPrice: Decimal;
        VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        Footer: Text;
        CustSource: Option Default,"Bill-to Customer","Sell-to Customer";
        DimLbl: Label '%1 - %2', Locked = true;
        CombinedDimLbl: Label '%1; %2 - %3', Locked = true;

    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean)
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
        Print := PrintFrom;
    end;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    var
        lbtFormatDocument: Codeunit "lbt Format Document";
    begin
        lbtFormatDocument.SetTotalLabels(SalesHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalesPurchPerson, SalesHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");

        ReferenceText := FormatDocument.SetText(SalesHeader."Your Reference" <> '', CopyStr(SalesHeader.FIELDCAPTION("Your Reference"), 1, 80));
        VATNoText := FormatDocument.SetText(SalesHeader."VAT Registration No." <> '', CopyStr(SalesHeader.FIELDCAPTION("VAT Registration No."), 1, 80));

        if SalesPersonText <> '' then
            SalesPersonText := SalesPersonText_CaptionLbl;
    end;

    local procedure FormatAddressFields(var SalesHeader: Record "Sales Header")
    var
        i: Integer;
    begin
        FormatAddr.GetCompanyAddr(SalesHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        GetCustSource();
        case CustSource of
            CustSource::Default, CustSource::"Bill-to Customer":
                FormatAddr.SalesHeaderBillTo(CustAddr, SalesHeader);
            CustSource::"Sell-to Customer":
                FormatAddr.SalesHeaderSellTo(CustAddr, SalesHeader);
        end;
        ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, SalesHeader);
        CLEAR(CompanyAddressLine);

        for i := 1 to 6 do
            if CompanyAddr[i] <> '' then begin
                if CompanyAddressLine <> '' then
                    CompanyAddressLine := CompanyAddressLine + ', ';
                CompanyAddressLine := CompanyAddressLine + CompanyAddr[i];
            end;
    end;

    local procedure Createlbtext(LeBitPSLongtextLine: Record "lbt PS Longtext Line")
    var
        lbtext: Text;
        Streamin: InStream;
        Streamout: OutStream;
        LastSign: Text[10];
        NewLine: Boolean;
    begin
        if TempLeBitPSLongtextLine.IsEmpty() then begin
            TempLeBitPSLongtextLine := LeBitPSLongtextLine;
            TempLeBitPSLongtextLine.Description := '';
            TempLeBitPSLongtextLine.Insert();
        end;

        TempLeBitPSLongtextLine.FindLast();
        NewLine := false;

        TempLeBitPSLongtextLine.CALCFIELDS(Text);
        if TempLeBitPSLongtextLine.Text.HasValue() then begin
            TempLeBitPSLongtextLine.Text.CREATEINSTREAM(Streamin);
            Streamin.READ(lbtext);
        end;

        case LeBitPSLongtextLine.Type of
            LeBitPSLongtextLine.Type::"New Page":
                begin
                    TempLeBitPSLongtextLine := LeBitPSLongtextLine;
                    TempLeBitPSLongtextLine."Line No." := TempLeBitPSLongtextLine."Line No." + 10000;
                    TempLeBitPSLongtextLine.Insert();
                    NewLine := true;
                    lbtext := '';
                end;
            LeBitPSLongtextLine.Type::Text:
                if LeBitPSLongtextLine.Description = '' then begin
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
                            lbtext += LeBitPSLongtextLine.Description
                        else
                            lbtext += (' ' + LeBitPSLongtextLine.Description);
                    end else
                        lbtext += LeBitPSLongtextLine.Description;

            LeBitPSLongtextLine.Type::"Text + Line break":

                if LeBitPSLongtextLine.Description = '' then begin
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
                            lbtext += LeBitPSLongtextLine.Description + '<br>'
                        else
                            lbtext += (' ' + LeBitPSLongtextLine.Description) + '<br>';
                    end else
                        lbtext += LeBitPSLongtextLine.Description + '<br>';

        end;

        if lbtext <> '' then begin
            TempLeBitPSLongtextLine.Text.CREATEOUTSTREAM(Streamout);
            Streamout.WRITE(lbtext);
            TempLeBitPSLongtextLine.Modify();
        end;
        if NewLine then begin
            TempLeBitPSLongtextLine.Init();
            ;
            TempLeBitPSLongtextLine."Line No." := TempLeBitPSLongtextLine."Line No." + 10000;
            TempLeBitPSLongtextLine.Type := TempLeBitPSLongtextLine.Type::Text;
            TempLeBitPSLongtextLine.Insert();
        end;
    end;

    local procedure GetCustSource()
    var
        TypeVar: Option Sales,Purchase;
        RepType: Option " ","Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order","Purchase Quote","Purchase Order","Blanket Purchase Order";
    begin
        LeBitReportFunctions.GetSourceType(TypeVar::Sales, RepType::"Sales Quote", CustSource);
    end;
}


