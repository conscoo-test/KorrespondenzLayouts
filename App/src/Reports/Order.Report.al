report 5272728 "lbt Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Order.Report.rdlc';
    Caption = 'Order', Comment = 'DEU="Bestellung"';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
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
                    column(DocumentConfirmCopyCaption; STRSUBSTNO(DocCaptionLbl, CopyText))
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddr[8])
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
                    column(FORMAT__Purchase_Header___Document_Date__0_4_; FORMAT("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(Purchase_Header___Your_Reference_; "Purchase Header"."Your Reference")
                    {
                    }
                    column(Purchase_Header___Buy_from_Vendor_No__; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(Purchase_Header___Prices_Including_VAT_; "Purchase Header"."Prices Including VAT")
                    {
                    }
                    column(Purchase_Header___VAT_Registration_No__; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(Purchase_Header___VAT_Base_Discount___; "Purchase Header"."VAT Base Discount %")
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(Purchase_Header___No__; "Purchase Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(Order_No_Caption; Order_No_CaptionLbl)
                    {
                    }
                    column(Purchase_Header___Buy_from_Vendor_No__Caption; "Purchase Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    column(Purchase_Header___Prices_Including_VAT_Caption; "Purchase Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__Caption; CompanyInfo__VAT_Registration_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Phone_No__Caption; CompanyInfo__Phone_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No__Caption; CompanyInfo__Fax_No__CaptionLbl)
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
                    column(UOM_Caption; UOM_CaptionLbl)
                    {
                    }
                    column(Direct_Unit_CostCaption; Direct_Unit_CostCaptionLbl)
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
                    column(Purchase_Line__Quantity_Caption; "Purchase Line".FIELDCAPTION(Quantity))
                    {
                    }
                    column(Purchase_Line__Description_Caption; "Purchase Line".FIELDCAPTION(Description))
                    {
                    }
                    column(OurAccountNo_Vendor; Vendor."Our Account No.")
                    {
                    }
                    column(OurAccountNo_Vendor_Caption; Vendor.FIELDCAPTION("Our Account No."))
                    {
                    }
                    column(VAT_Registration_No__Caption; VAT_Registration_No__CaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimText_Control72; DimText)
                        {
                        }
                        column(DimensionLoop1_Number; Number)
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
                    dataitem(LBKopf; "lbt PS Longtext Line")
                    {
                        DataItemLink = "Document No." = FIELD("No."), "Document Type" = FIELD("Document Type");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE("Table ID" = CONST(38), Position = CONST(Header));

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
                        column(LBKopfNumber; Number)
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
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break();
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(PurchLine__Line_Amount_; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line__Description; "Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line___Line_No__; "Purchase Line"."Line No.")
                        {
                        }
                        column(AllowInvDisctxt; AllowInvDisctxt)
                        {
                        }
                        column(PurchaseLineType; FORMAT("Purchase Line".Type, 0, 2))
                        {
                        }
                        column(Purchase_Line___No__; "Purchase Line"."No.")
                        {
                        }
                        column(Purchase_Line__Description_Control63; "Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line__Quantity; "Purchase Line".Quantity)
                        {
                        }
                        column(Purchase_Line___Unit_of_Measure_; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(Purchase_Line___Direct_Unit_Cost_; DirectUnitCost)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line___Line_Discount___; "Purchase Line"."Line Discount %")
                        {
                        }
                        column(Purchase_Line___Line_Amount_; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line___Allow_Invoice_Disc__; "Purchase Line"."Allow Invoice Disc.")
                        {
                        }
                        column(Purchase_Line___VAT_Identifier_; "Purchase Line"."VAT Identifier")
                        {
                        }
                        column(PurchLine__Line_Amount__Control77; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Inv__Discount_Amount_; -PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__Control109; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount_; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText())
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount____VATAmount; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount__Control147; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText_Control32; VATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText_Control51; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText_Control69; TotalInclVATText)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount_Control83; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line___No__Caption; "Purchase Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Purchase_Line__Description_Control63Caption; "Purchase Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Purchase_Line__QuantityCaption; "Purchase Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(Purchase_Line___Unit_of_Measure_Caption; "Purchase Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(Purchase_Line___Line_Discount___Caption; Purchase_Line___Line_Discount___CaptionLbl)
                        {
                        }
                        column(Purchase_Line___Allow_Invoice_Disc__Caption; "Purchase Line".FIELDCAPTION("Allow Invoice Disc."))
                        {
                        }
                        column(Purchase_Line___VAT_Identifier_Caption; "Purchase Line".FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control76; ContinuedCaption_Control76Lbl)
                        {
                        }
                        column(PurchLine__Inv__Discount_Amount_Caption; PurchLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(NewPageGroup; NewPageGroup)
                        {
                        }
                        column(PurchaseLineLeBitPrintoption; FORMAT("Purchase Line"."lbt Printoption", 0, 2))
                        {
                        }
                        column(LeBitPosNo_PurchaseLine; "Purchase Line"."lbt Pos. No.")
                        {
                        }
                        column(LeBitBalance_PurchaseLine; PurchLine."lbt Balance")
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
                        column(Description2_PurchaseLine; "Purchase Line"."Description 2")
                        {
                        }
                        column(ItemUnitQty; ItemUnitQty)
                        {
                        }
                        column(ItemUnitDescription; ItemUnitDescription)
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
                        dataitem(LBLang; "lbt PS Longtext Line")
                        {
                            DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                            DataItemLinkReference = "Purchase Line";
                            DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE("Table ID" = CONST(39), Position = CONST(Longtext));

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
                            column(DimText_Control74; DimText)
                            {
                            }
                            column(DimensionLoop2_Number; Number)
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            IntVar: Integer;
                            TxtVar: Text;
                            Counter: Integer;
                        begin
                            if Number = 1 then
                                PurchLine.FIND('-')
                            else
                                PurchLine.Next();
                            "Purchase Line" := PurchLine;

                            if not "Purchase Header"."Prices Including VAT" and
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            then
                                PurchLine."Line Amount" := 0;

                            if (PurchLine.Type = PurchLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Purchase Line"."No." := '';
                            AllowInvDisctxt := FORMAT("Purchase Line"."Allow Invoice Disc.");
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;

                            if PurchLine."lbt Printoption" = PurchLine."lbt Printoption"::"New Page" then
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

                            if "Purchase Line".Quantity <> 0 then
                                DirectUnitCost := "Purchase Line"."Direct Unit Cost" - "Purchase Line"."Line Discount Amount" / "Purchase Line".Quantity
                            else
                                DirectUnitCost := 0;

                            PurchLine.CALCFIELDS("lbt Balance");
                            if PurchLine.Type = PurchLine.Type::Item then begin
                                Item.Get(PurchLine."No.");
                                ItemPictureExist := Item.Picture.Count() > 0;
                                if not ItemPicturePrint then
                                    ItemPictureExist := false;
                                TxtVar := CurrReport.OBJECTID(false);
                                TxtVar := COPYSTR(TxtVar, STRPOS(TxtVar, ' '));
                                EVALUATE(IntVar, TxtVar);
                                LeBitReportFunctions.GetParameterArry(ReportType::Purchase, IntVar, 2, "Purchase Header"."Language Code", "Purchase Line".RowID1(), '', "Purchase Line"."No.", InfoCaptionArry, InfoValueArry);
                                LeBitReportFunctions.GetItemUnitArry(2, "Purchase Line".RowID1(), '', "Purchase Header"."Language Code", ItemUnitCodeArry, ItemUnitDescriptionArry, ItemUnitQtyArry);
                                Counter := 0;
                                repeat
                                    Counter += 1;
                                until (ItemUnitCodeArry[Counter] = PurchLine."Unit of Measure Code") or
                                  (ItemUnitCodeArry[Counter] = '');
                                if ItemUnitCodeArry[Counter] <> '' then begin
                                    ItemUnitCodeArry[Counter] := '';
                                    ItemUnitDescriptionArry[Counter] := '';
                                    ItemUnitQtyArry[Counter] := '';
                                    COMPRESSARRAY(ItemUnitCodeArry);
                                    COMPRESSARRAY(ItemUnitDescriptionArry);
                                    COMPRESSARRAY(ItemUnitQtyArry);
                                end;
                                if PurchLine."Description 2" <> '' then begin
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
                                Counter := 0;
                                repeat
                                    Counter += 1;
                                until InfoCaptionArry[Counter] = '';
                                Counter -= 1;
                                if PurchLine."Vendor Item No." <> '' then begin
                                    Counter += 1;
                                    InfoCaptionArry[Counter] := Purchase_Line___Vendor_Item_No__CaptionLbl;
                                    InfoValueArry[Counter] := PurchLine."Vendor Item No.";
                                end;
                                /*
                                IF PurchLine."Expected Receipt Date" <> 0D THEN BEGIN
                                  Counter += 1;
                                  InfoCaptionArry[Counter] := Expected_DateCaptionLbl;
                                  InfoValueArry[Counter] := FORMAT(PurchLine."Expected Receipt Date",0,4);
                                END;
                                */
                                // Ermittlung der RowNo
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

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DeleteAll();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.FIND('+');
                            while MoreLines and (PurchLine.Description = '') and (PurchLine."Description 2" = '') and
                                  (PurchLine."No." = '') and (PurchLine.Quantity = 0) and
                                  (PurchLine.Amount = 0)
                            do
                                MoreLines := PurchLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.Count());
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine__VAT_Base_; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Base__Control99; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control100; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control131; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control132; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control133; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control103; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control104; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control56; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control57; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control58; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control107; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control108; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control59; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control60; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control61; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounter_Number; Number)
                        {
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control99Caption; VATAmountLine__VAT_Base__Control99CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control100Caption; VATAmountLine__VAT_Amount__Control100CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control132Caption; VATAmountLine__Inv__Disc__Base_Amount__Control132CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control131Caption; VATAmountLine__Line_Amount__Control131CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control133Caption; VATAmountLine__Invoice_Discount_Amount__Control133CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control103Caption; VATAmountLine__VAT_Base__Control103CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control107Caption; VATAmountLine__VAT_Base__Control107CaptionLbl)
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
                            if VATAmount = 0 then
                                CurrReport.Break();
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
                        column(VALVATAmountLCY_Control158; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control159; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT____Control160; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier__Control161; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATAmountLCY_Control162; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control163; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control165; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control166; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATCounterLCY_Number; Number)
                        {
                        }
                        column(VALVATAmountLCY_Control158Caption; VALVATAmountLCY_Control158CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control159Caption; VALVATBaseLCY_Control159CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT____Control160Caption; VATAmountLine__VAT____Control160CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier__Control161Caption; VATAmountLine__VAT_Identifier__Control161CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control163Caption; VALVATBaseLCY_Control163CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control166Caption; VALVATBaseLCY_Control166CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmountLine.Count() < 2 then
                                CurrReport.Break();
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Purchase Header"."Currency Code" = '') or
                               (VATAmountLine.GetTotalVATAmount() = 0)
                            then
                                CurrReport.Break();

                            SETRANGE(Number, 1, VATAmountLine.Count());

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := VatAmountLbl + LCYLbl
                            else
                                VALSpecLCYHeader := VatAmountLbl + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
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
                        column(Total_Number; Number)
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
                        column(Purchase_Header___Pay_to_Vendor_No__; "Purchase Header"."Pay-to Vendor No.")
                        {
                        }
                        column(VendAddr_8_; VendAddr[8])
                        {
                        }
                        column(VendAddr_7_; VendAddr[7])
                        {
                        }
                        column(VendAddr_6_; VendAddr[6])
                        {
                        }
                        column(VendAddr_5_; VendAddr[5])
                        {
                        }
                        column(VendAddr_4_; VendAddr[4])
                        {
                        }
                        column(VendAddr_3_; VendAddr[3])
                        {
                        }
                        column(VendAddr_2_; VendAddr[2])
                        {
                        }
                        column(VendAddr_1_; VendAddr[1])
                        {
                        }
                        column(Total2_Number; Number)
                        {
                        }
                        column(Payment_DetailsCaption; Payment_DetailsCaptionLbl)
                        {
                        }
                        column(Vendor_No_Caption; Vendor_No_CaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(Total3; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(Purchase_Header___Sell_to_Customer_No__; "Purchase Header"."Sell-to Customer No.")
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
                        column(Total3_Number; Number)
                        {
                        }
                        column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
                        {
                        }
                        column(Purchase_Header___Sell_to_Customer_No__Caption; "Purchase Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(PrepmtLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBuf__G_L_Account_No__; PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(PrepmtLineAmount_Control173; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                        }
                        column(PrepmtInvBuf_Description; PrepmtInvBuf.Description)
                        {
                        }
                        column(PrepmtLineAmount_Control177; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control182; TotalExclVATText)
                        {
                        }
                        column(PrepmtInvBuf_Amount; PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine_VATAmountText; PrepmtVATAmountLine.VATAmountText())
                        {
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control186; TotalInclVATText)
                        {
                        }
                        column(PrepmtInvBuf_Amount___PrepmtVATAmount; PrepmtInvBuf.Amount + PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control188; TotalInclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText_Control189; VATAmountLine.VATAmountText())
                        {
                        }
                        column(PrepmtVATAmount_Control190; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control192; TotalExclVATText)
                        {
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtLoop_Number; Number)
                        {
                        }
                        column(PrepmtLineAmount_Control173Caption; PrepmtLineAmount_Control173CaptionLbl)
                        {
                        }
                        column(PrepmtInvBuf_DescriptionCaption; PrepmtInvBuf_DescriptionCaptionLbl)
                        {
                        }
                        column(PrepmtInvBuf__G_L_Account_No__Caption; PrepmtInvBuf__G_L_Account_No__CaptionLbl)
                        {
                        }
                        column(Prepayment_SpecificationCaption; Prepayment_SpecificationCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control176; ContinuedCaption_Control176Lbl)
                        {
                        }
                        column(ContinuedCaption_Control178; ContinuedCaption_Control178Lbl)
                        {
                        }
                        column(DimText_Control179; DimText)
                        {
                        }
                        column(Line_DimensionsCaption_Control180; Line_DimensionsCaption_Control180Lbl)
                        {
                        }
                        dataitem(PrepmtDimLoop; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not PrepmtDimSetEntry.FindSet() then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                CLEAR(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := STRSUBSTNO('%1 %2', PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code")
                                    else
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code");
                                    if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until PrepmtDimSetEntry.Next() = 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not PrepmtInvBuf.FIND('-') then
                                    CurrReport.Break();
                            end else
                                if PrepmtInvBuf.Next() = 0 then
                                    CurrReport.Break();

                            if ShowInternalInfo then
                                PrepmtDimSetEntry.SETRANGE("Dimension Set ID", PrepmtInvBuf."Dimension Set ID");

                            if "Purchase Header"."Prices Including VAT" then
                                PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            else
                                PrepmtLineAmount := PrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem()
                        begin
                        end;
                    }
                    dataitem(PrepmtVATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrepmtVATAmountLine__VAT_Amount_; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT_Base_; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__Line_Amount_; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT___; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmountLine__VAT_Amount__Control194; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT_Base__Control195; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__Line_Amount__Control196; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT____Control197; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmountLine__VAT_Identifier_; PrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepmtVATAmountLine__VAT_Amount__Control210; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT_Base__Control211; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__Line_Amount__Control212; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT____Control213; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmountLine__VAT_Amount__Control215; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT_Base__Control216; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__Line_Amount__Control217; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATCounter_Number; Number)
                        {
                        }
                        column(PrepmtVATAmountLine__VAT_Amount__Control194Caption; PrepmtVATAmountLine__VAT_Amount__Control194CaptionLbl)
                        {
                        }
                        column(PrepmtVATAmountLine__VAT_Base__Control195Caption; PrepmtVATAmountLine__VAT_Base__Control195CaptionLbl)
                        {
                        }
                        column(PrepmtVATAmountLine__Line_Amount__Control196Caption; PrepmtVATAmountLine__Line_Amount__Control196CaptionLbl)
                        {
                        }
                        column(PrepmtVATAmountLine__VAT____Control197Caption; PrepmtVATAmountLine__VAT____Control197CaptionLbl)
                        {
                        }
                        column(Prepayment_VAT_Amount_SpecificationCaption; Prepayment_VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(PrepmtVATAmountLine__VAT_Identifier_Caption; PrepmtVATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control209; ContinuedCaption_Control209Lbl)
                        {
                        }
                        column(ContinuedCaption_Control214; ContinuedCaption_Control214Lbl)
                        {
                        }
                        column(PrepmtVATAmountLine__VAT_Base__Control216Caption; PrepmtVATAmountLine__VAT_Base__Control216CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, PrepmtVATAmountLine.Count());
                        end;
                    }
                    dataitem(PrepmtTotal; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(PrepmtPaymentTerms_Description; PrepmtPaymentTerms.Description)
                        {
                        }
                        column(PrepmtTotal_Number; Number)
                        {
                        }
                        column(PrepmtPaymentTerms_DescriptionCaption; PrepmtPaymentTerms_DescriptionCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not PrepmtInvBuf.FIND('-') then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(LBFuss; "lbt PS Longtext Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE("Table ID" = CONST(38), Position = CONST(Footer));

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
                    PrepmtPurchLine: Record "Purchase Line" temporary;
                    TempPurchLine: Record "Purchase Line" temporary;
                begin
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DeleteAll();
                    VATAmountLine.DeleteAll();
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := VATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT();

                    PrepmtInvBuf.DeleteAll();
                    PurchPostPrepmt.GetPurchLines("Purchase Header", 0, PrepmtPurchLine);
                    if not PrepmtPurchLine.IsEmpty() then begin
                        PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        if not TempPurchLine.IsEmpty() then
                            PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, PrePmtVATAmountLineDeduct, 1);
                    end;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    PrepmtVATAmountLine.DeductVATAmountLine(PrePmtVATAmountLineDeduct);
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then
                        CopyText := FormatDocument.GetCOPYText();
                    OutputNo := OutputNo + 1;

                    TotalSubTotal := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.PREVIEW() then
                        CODEUNIT.RUN(CODEUNIT::"Purch.Header-Printed", "Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;
                    NewPageGroup := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");
                PricesInclVATtxt := FORMAT("Prices Including VAT");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if not CurrReport.PREVIEW() then begin
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    if LogInteraction then begin
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    end;
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
                    Caption = 'Options', Comment = 'DEU="Optionen"';
                    field("No of Copies"; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies', Comment = 'DEU="Anzahl Kopien"';
                        ToolTip = 'Specifies how many copies of the document to print.', comment = 'DEU="Legt die Anzahl der Ausdrücke fest"';
                    }
                    field("Show Internal Information"; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Internal Information', Comment = 'DEU="Interne Informationen anzeigen"';
                        ToolTip = 'Specifies if the document shows internal information.', comment = 'DEU="Legt fest ob vorhandene Dimensionswerte mit ausgedruckt werden sollen"';
                    }
                    field("Archive Document"; ArchiveDocument)
                    {
                        ApplicationArea = All;
                        Caption = 'Archive Document', Comment = 'DEU="Beleg archivieren"';
                        ToolTip = 'Specifies if the document is archived after you preview or print it.', comment = 'DEU="Legt fest ob das Dokument nach dem Ausdruck oder Vorschau auch archiviert wird"';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field("Log Interaction"; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction', Comment = 'DEU="Aktivität protokollieren"';
                        ToolTip = 'Specifies that interactions with the contact are logged.', comment = 'DEU="Legt fest, dass Aktivitäten mit dem Kontakt protokolliert werden."';
                        Enabled = LogInteractionEnable;
                    }
                    field("Hide CompanyInfo"; HideCompanyInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Hide Company Info', Comment = 'DEU="Firmendaten ausblenden"';
                        ToolTip = 'Specifies that the company data is to be "hidden" for printing', comment = 'DEU="Hiermit können Sie die Firmendaten für den Druck ausblenden"';
                    }
                    field("Item Picture Print"; ItemPicturePrint)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Item Picture', Comment = 'DEU="Artikelbilder drucken"';
                        ToolTip = 'Specifies that the images are printed ', comment = 'DEU="Legt fest ob Artikelbilder mit ausgedruckt werden"';
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
            ArchiveDocument := PurchSetup."Archive Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

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
        PurchSetup.Get();
        FormatDocument.SetLogoPosition(PurchSetup."lbt Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrePmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        PurchLine: Record "Purchase Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        PrepmtDimSetEntry: Record "Dimension Set Entry";
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        PurchSetup: Record "Purchases & Payables Setup";
        Item: Record Item;
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        TempLeBitPSLongtextLine: Record "lbt PS Longtext Line" temporary;
        Vendor: Record Vendor;
        Language: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        PurchPost: Codeunit "Purch.-Post";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
        LeBitReportFunctions: Codeunit "lbt Report Functions";
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        BuyFromAddr: array[8] of Text[50];
        PurchaserText: Text[50];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
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
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];

        VALExchRate: Text[50];
        VatAmountLbl: Label 'VAT Amount Specification in ', Comment = 'DEU="MwSt.-Betrag Spezifikation in"';
        LCYLbl: Label 'Local Currency', Comment = 'DEU="Landeswährung"';
        ExchangeRateLbl: Label 'Exchange rate: %1/%2', Comment = 'DEU="Wechselkurs: %1/%2"';
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        PricesInclVATtxt: Text[30];
        AllowInvDisctxt: Text[30];
        [InDataSet]
        LogInteractionEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.', Comment = 'DEU="Telefonnr."';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.', Comment = 'DEU="Faxnr."';
        CompanyInfo__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.', Comment = 'DEU="USt.IDNr."';
        Order_No_CaptionLbl: Label 'Order No.', Comment = 'DEU="Bestellnr."';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions', Comment = 'DEU="Kopfdimension"';
        Direct_Unit_CostCaptionLbl: Label 'Direct Unit Cost', Comment = 'DEU="EK-Preis"';
        Purchase_Line___Line_Discount___CaptionLbl: Label 'Disc. %', Comment = 'DEU="Rab. %"';
        AmountCaptionLbl: Label 'Amount', Comment = 'DEU="Betrag"';
        ContinuedCaptionLbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        ContinuedCaption_Control76Lbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        PurchLine__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount', Comment = 'DEU="Rechnungsrabattbetrag"';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'DEU="Zw. Summe"';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT', Comment = 'DEU="Skonto auf MwSt."';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions', Comment = 'DEU="Zeilendimension"';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %', Comment = 'DEU="MwSt. %"';
        VATAmountLine__VAT_Base__Control99CaptionLbl: Label 'VAT Base', Comment = 'DEU="MwSt.-Bemessungsgrundlage"';
        VATAmountLine__VAT_Amount__Control100CaptionLbl: Label 'VAT Amount', Comment = 'DEU="MwSt.-Betrag"';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification', Comment = 'DEU="MwSt.-Betrag - Spezifikation"';
        VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier', Comment = 'DEU="MwSt.-Kennzeichen"';
        VATAmountLine__Inv__Disc__Base_Amount__Control132CaptionLbl: Label 'Inv. Disc. Base Amount', Comment = 'DEU="Rechnungsrab.-Bemessungsgr."';
        VATAmountLine__Line_Amount__Control131CaptionLbl: Label 'Line Amount', Comment = 'DEU="Zeilenbetrag"';
        VATAmountLine__Invoice_Discount_Amount__Control133CaptionLbl: Label 'Invoice Discount Amount', Comment = 'DEU="Rechnungsrab.-Betrag"';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        VATAmountLine__VAT_Base__Control103CaptionLbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        VATAmountLine__VAT_Base__Control107CaptionLbl: Label 'Total', Comment = 'DEU="Gesamt"';
        VALVATAmountLCY_Control158CaptionLbl: Label 'VAT Amount', Comment = 'DEU="MwSt.-Betrag"';
        VALVATBaseLCY_Control159CaptionLbl: Label 'VAT Base', Comment = 'DEU="MwSt.-Bemessungsgrundlage"';
        VATAmountLine__VAT____Control160CaptionLbl: Label 'VAT %', Comment = 'DEU="MwSt. %"';
        VATAmountLine__VAT_Identifier__Control161CaptionLbl: Label 'VAT Identifier', Comment = 'DEU="MwSt.-Kennzeichen"';
        VALVATBaseLCYCaptionLbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        VALVATBaseLCY_Control163CaptionLbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        VALVATBaseLCY_Control166CaptionLbl: Label 'Total', Comment = 'DEU="Gesamt"';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms', Comment = 'DEU="Zahlungsbedingungen"';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method', Comment = 'DEU="Lieferbedingungen"';
        Payment_DetailsCaptionLbl: Label 'Payment Details', Comment = 'DEU="Zahlungsdaten"';
        Vendor_No_CaptionLbl: Label 'Vendor No.', Comment = 'DEU="Kreditorennr."';
        Ship_to_AddressCaptionLbl: Label 'Ship-to Address', Comment = 'DEU="Lief. an Adresse"';
        PrepmtLineAmount_Control173CaptionLbl: Label 'Amount', Comment = 'DEU="Betrag"';
        PrepmtInvBuf_DescriptionCaptionLbl: Label 'Description', Comment = 'DEU="Beschreibung"';
        PrepmtInvBuf__G_L_Account_No__CaptionLbl: Label 'G/L Account No.', Comment = 'DEU="Sachkontonr."';
        Prepayment_SpecificationCaptionLbl: Label 'Prepayment Specification', Comment = 'DEU="Vorauszahlung - Spezifikation"';
        ContinuedCaption_Control176Lbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        ContinuedCaption_Control178Lbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        Line_DimensionsCaption_Control180Lbl: Label 'Line Dimensions', Comment = 'DEU="Zeilendimension"';
        PrepmtVATAmountLine__VAT_Amount__Control194CaptionLbl: Label 'VAT Amount', Comment = 'DEU="MwSt.-Betrag"';
        PrepmtVATAmountLine__VAT_Base__Control195CaptionLbl: Label 'VAT Base', Comment = 'DEU="MwSt.-Bemessungsgrundlage"';
        PrepmtVATAmountLine__Line_Amount__Control196CaptionLbl: Label 'Line Amount', Comment = 'DEU="Zeilenbetrag"';
        PrepmtVATAmountLine__VAT____Control197CaptionLbl: Label 'VAT %', Comment = 'DEU="MwSt. %"';
        Prepayment_VAT_Amount_SpecificationCaptionLbl: Label 'Prepayment VAT Amount Specification', Comment = 'DEU="Vorauszahlung MwSt.-Betrag - Spezifikation"';
        PrepmtVATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier', Comment = 'DEU="MwSt.-Kennzeichen"';
        ContinuedCaption_Control209Lbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        ContinuedCaption_Control214Lbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        PrepmtVATAmountLine__VAT_Base__Control216CaptionLbl: Label 'Total', Comment = 'DEU="Gesamt"';
        PrepmtPaymentTerms_DescriptionCaptionLbl: Label 'Prepmt. Payment Terms', Comment = 'DEU="Vorausz. - Zahlungsbedingungen"';
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
        ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report";
        DocCaptionLbl: Label 'Order %1', Comment = 'DEU="Bestellung %1"';
        PagefromPageCaptionLbl: Label 'Page %1 of %2', Comment = 'DEU="Seite %1 von %2"';
        PageCaptionLbl: Label 'Page %1', Comment = 'DEU="Seite %1"';
        NoCaptionLbl: Label 'No.', Comment = 'DEU="Nr."';
        FromCaptionLbl: Label 'from', Comment = 'DEU="vom"';
        DatumCaptionLbl: Label 'Date', Comment = 'DEU="Datum"';
        PosNo_CaptionLbl: Label 'Pos.', Comment = 'DEU="Pos."';
        UOM_CaptionLbl: Label 'Unit', Comment = 'DEU="Einheit"';
        CompanyInfo__LeBit_Trade_Register_Name_Caption_Lbl: Label 'Registered in:', Comment = 'DEU="Eingetragen im:"';
        CompanyInfo__LeBit_CEO_Caption_Lbl: Label 'Chief Executive Officer', Comment = 'DEU="Geschäftsführer"';
        CompanyInfo__Bank_Name_Caption_Lbl: Label 'Bank', Comment = 'DEU="Bankkonto"';
        CompanyInfo_IBAN_Caption_Lbl: Label 'IBAN', Comment = 'DEU="IBAN"';
        CompanyInfo__SWIFT_Code_Caption_Lbl: Label 'SWIFT-BIC', Comment = 'DEU="SWIFT-BIC"';
        PurchPersonText_CaptionLbl: Label 'Salesperson', Comment = 'DEU="Bearbeiter"';
        CompanyInfo_E_Mail_Caption_Lbl: Label 'Mail:', Comment = 'DEU="E-Mail"';
        CompanyInfo__Home_Page_Caption_Lbl: Label 'Homepage:', Comment = 'DEU="Homepage"';
        CarryForwardCaptionLbl: Label 'Carry-forward %1', Comment = 'DEU="Carry-forward %1"';
        Alternativposition_CaptionLbl: Label 'Alternative position', Comment = 'DEU="Alternative Position"';
        Bedarfposition_CaptionLbl: Label 'Position requirements', Comment = 'DEU="Bedarfposition"';
        BitteAndern_CaptionLbl: Label 'please change!', Comment = 'DEU="bitte ändern!"';
        Purchase_Line___Vendor_Item_No__CaptionLbl: Label 'No.', Comment = 'DEU="Nr."';
        DirectUnitCost: Decimal;
        VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.', Comment = 'DEU="USt-IdNr."';
        VendSource: Option Default,"Pay-to Vendor","Buy-from Vendor";

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    var
        i: Integer;
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        GetVendSource();
        case VendSource of
            VendSource::"Pay-to Vendor":
                begin
                    FormatAddr.PurchHeaderPayTo(BuyFromAddr, PurchaseHeader);
                    Vendor.Get("Purchase Header"."Pay-to Vendor No.");
                end;
            VendSource::Default, VendSource::"Buy-from Vendor":
                begin
                    FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
                    Vendor.Get("Purchase Header"."Buy-from Vendor No.");
                end;
        end;
        if PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." then
            FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
        CLEAR(CompanyAddressLine);

        for i := 1 to 6 do
            if CompanyAddr[i] <> '' then begin
                if CompanyAddressLine <> '' then
                    CompanyAddressLine := CompanyAddressLine + ', ';
                CompanyAddressLine := CompanyAddressLine + CompanyAddr[i];
            end;
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        with PurchaseHeader do begin
            FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetPurchaser(SalesPurchPerson, "Purchaser Code", PurchaserText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, "Prepmt. Payment Terms Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");

            ReferenceText := FormatDocument.SetText("Your Reference" <> '', CopyStr(FIELDCAPTION("Your Reference"), 1, 80));
            VATNoText := FormatDocument.SetText("VAT Registration No." <> '', CopyStr(FIELDCAPTION("VAT Registration No."), 1, 80));
            if PurchaserText <> '' then
                PurchaserText := PurchPersonText_CaptionLbl;
        end;
    end;

    local procedure "### Lebit Correspondence Functions ###"()
    begin
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
            TempLeBitPSLongtextLine."Line No." := TempLeBitPSLongtextLine."Line No." + 10000;
            TempLeBitPSLongtextLine.Type := TempLeBitPSLongtextLine.Type::Text;
            TempLeBitPSLongtextLine.Insert();
        end;
    end;

    local procedure GetVendSource()
    var
        TypeVar: Option Sales,Purchase;
        RepType: Option " ","Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order","Purchase Quote","Purchase Order","Blanket Purchase Order";
    begin
        LeBitReportFunctions.GetSourceType(TypeVar::Purchase, RepType::"Purchase Order", VendSource);
    end;
}

