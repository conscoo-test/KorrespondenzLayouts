report 5272730 "lbt Return Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Rep5272730.LBTReturnOrder.rdlc';
    Caption = 'Return Order', Comment = 'DEU="Reklamation"';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST("Return Order"));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Return Order';
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            column(VATIdentifierCaption1; VATIdentifierCaptionLbl)
            {
            }
            column(VATPctCaption; VATPctCaptionLbl)
            {
            }
            column(VATBaseCaption2; VATBaseCaption2Lbl)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(TotalCaption1; TotalCaption1Lbl)
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
                    column(CompanyInfo__LeBit_CEO1; CompanyInfo."LBT CEO1")
                    {
                    }
                    column(CompanyInfo__LeBit_CEO2; CompanyInfo."LBT CEO2")
                    {
                    }
                    column(CompanyInfo__LeBit_CEO3; CompanyInfo."LBT CEO3")
                    {
                    }
                    column(CompanyInfo__LeBit_Commercial_Register_No; CompanyInfo."LBT Commercial Register No.")
                    {
                    }
                    column(CompanyInfo__LeBit_Trade_Register_Name; CompanyInfo."LBT Trade Register Name")
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
                    column(CompanyInfo__LeBit_Bank_Name_2; CompanyInfo."LBT Bank Name 2")
                    {
                    }
                    column(CompanyInfo__LeBit_IBAN_2; CompanyInfo."LBT IBAN 2")
                    {
                    }
                    column(CompanyInfo__LeBit_SWIFT_Code_2; CompanyInfo."LBT SWIFT Code 2")
                    {
                    }
                    column(CompanyInfo__LeBit_Bank_Name_3; CompanyInfo."LBT Bank Name 3")
                    {
                    }
                    column(CompanyInfo__LeBit_IBAN_3; CompanyInfo."LBT IBAN 3")
                    {
                    }
                    column(CompanyInfo__LeBit_SWIFT_Code_3; CompanyInfo."LBT SWIFT Code 3")
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
                    column(ReturnOrderNoCaption; ReturnOrderNoCaptionLbl)
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
                                if not DimSetEntry1.FINDSET then
                                    CurrReport.BREAK;
                            end else
                                if not Continue then
                                    CurrReport.BREAK;

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
                            until DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(LBKopf; "LBT PS Longtext Line")
                    {
                        DataItemLink = "Document No." = FIELD("No."), "Document Type" = FIELD("Document Type");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE("Table ID" = CONST(38), Position = CONST(Header));

                        trigger OnAfterGetRecord()
                        begin
                            CreateLBText(LBKopf);
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempLeBitPSLongtextLine.DELETEALL;
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
                                TempLeBitPSLongtextLine.FINDSET
                            else
                                TempLeBitPSLongtextLine.NEXT;

                            LBKopf_Description := '';

                            case TempLeBitPSLongtextLine.Type of
                                TempLeBitPSLongtextLine.Type::Text,
                                TempLeBitPSLongtextLine.Type::"Text + Line break":
                                    begin
                                        TempLeBitPSLongtextLine.CALCFIELDS(Text);
                                        if TempLeBitPSLongtextLine.Text.HASVALUE then begin
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
                            if TempLeBitPSLongtextLine.ISEMPTY then
                                CurrReport.BREAK;

                            TempLBKopf.SETRANGE(Number, 1, TempLeBitPSLongtextLine.COUNT);
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
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
                        column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText)
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
                        column(VATAmountLine_VATAmountText_Control32; VATAmountLine.VATAmountText)
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
                        column(PurchaseLineLeBitPrintoption; FORMAT("Purchase Line"."LBT Printoption", 0, 2))
                        {
                        }
                        column(LeBitPosNo_PurchaseLine; "Purchase Line"."LBT Pos. No.")
                        {
                        }
                        column(LeBitBalance_PurchaseLine; PurchLine."LBT Balance")
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
                        column(Item_Picture; TempBlob.Blob)
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
                        dataitem(LBLang; "LBT PS Longtext Line")
                        {
                            DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                            DataItemLinkReference = "Purchase Line";
                            DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE("Table ID" = CONST(39), Position = CONST(Longtext));

                            trigger OnAfterGetRecord()
                            begin
                                CreateLBText(LBLang);
                            end;

                            trigger OnPreDataItem()
                            begin
                                TempLeBitPSLongtextLine.DELETEALL;
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
                                    TempLeBitPSLongtextLine.FINDSET
                                else
                                    TempLeBitPSLongtextLine.NEXT;

                                LBLang_Description := '';

                                case TempLeBitPSLongtextLine.Type of
                                    TempLeBitPSLongtextLine.Type::Text,
                                    TempLeBitPSLongtextLine.Type::"Text + Line break":
                                        begin
                                            TempLeBitPSLongtextLine.CALCFIELDS(Text);
                                            if TempLeBitPSLongtextLine.Text.HASVALUE then begin
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
                                if TempLeBitPSLongtextLine.ISEMPTY then
                                    CurrReport.BREAK;

                                TempLBLang.SETRANGE(Number, 1, TempLeBitPSLongtextLine.COUNT);
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
                                    if not DimSetEntry2.FINDSET then
                                        CurrReport.BREAK;
                                end else
                                    if not Continue then
                                        CurrReport.BREAK;

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
                                until DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.BREAK;

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
                                PurchLine.NEXT;
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

                            if PurchLine."LBT Printoption" = PurchLine."LBT Printoption"::"New Page" then
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

                            PurchLine.CALCFIELDS("LBT Balance");
                            if PurchLine.Type = PurchLine.Type::Item then begin
                                Item.GET(PurchLine."No.");
                                ItemPictureExist := GetFirstMediaFromSet(Item.Picture.MEDIAID, TempBlob);
                                if not ItemPicturePrint then
                                    ItemPictureExist := false;
                                TxtVar := CurrReport.OBJECTID(false);
                                TxtVar := COPYSTR(TxtVar, STRPOS(TxtVar, ' '));
                                EVALUATE(IntVar, TxtVar);
                                LeBitReportFunctions.GetParameterArry(ReportType::Purchase, IntVar, 2, "Purchase Header"."Language Code", "Purchase Line".RowID1, '', "Purchase Line"."No.", InfoCaptionArry, InfoValueArry);
                                LeBitReportFunctions.GetItemUnitArry(2, "Purchase Line".RowID1, '', "Purchase Header"."Language Code", ItemUnitCodeArry, ItemUnitDescriptionArry, ItemUnitQtyArry);
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
                            PurchLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.FIND('+');
                            while MoreLines and (PurchLine.Description = '') and (PurchLine."Description 2" = '') and
                                  (PurchLine."No." = '') and (PurchLine.Quantity = 0) and
                                  (PurchLine.Amount = 0)
                            do
                                MoreLines := PurchLine.NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK;
                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.COUNT);
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATPercentCaption; VATPercentCaptionLbl)
                        {
                        }
                        column(VATBaseCaption; VATBaseCaptionLbl)
                        {
                        }
                        column(VATAmtCaption; VATAmtCaptionLbl)
                        {
                        }
                        column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
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
                        column(InvDisAmtCaption; InvDisAmtCaptionLbl)
                        {
                        }
                        column(VATBaseCaption1; VATBaseCaption1Lbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmountLine.COUNT < 2 then
                                CurrReport.BREAK;
                            if VATAmount = 0 then
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHdr; VALSpecLCYHeader)
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
                        column(VATAmtLineVAT1; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier1; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Purchase Header"."Posting Date", "Purchase Header"."Currency Code",
                                  VATAmountLine."VAT Base", "Purchase Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Purchase Header"."Posting Date", "Purchase Header"."Currency Code",
                                  VATAmountLine."VAT Amount", "Purchase Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmountLine.COUNT < 2 then
                                CurrReport.BREAK;
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Purchase Header"."Currency Code" = '') or
                               (VATAmountLine.GetTotalVATAmount = 0)
                            then
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007 + Text008
                            else
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(SelltoCustNo_PurchHdr; "Purchase Header"."Sell-to Customer No.")
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
                        column(SelltoCustNo_PurchHdrCaption; "Purchase Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(LBFuss; "LBT PS Longtext Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE("Table ID" = CONST(38), Position = CONST(Footer));

                        trigger OnAfterGetRecord()
                        begin
                            CreateLBText(LBFuss);
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempLeBitPSLongtextLine.DELETEALL;
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
                                TempLeBitPSLongtextLine.FINDSET
                            else
                                TempLeBitPSLongtextLine.NEXT;

                            LBFuss_Description := '';

                            case TempLeBitPSLongtextLine.Type of
                                TempLeBitPSLongtextLine.Type::Text,
                                TempLeBitPSLongtextLine.Type::"Text + Line break":
                                    begin
                                        TempLeBitPSLongtextLine.CALCFIELDS(Text);
                                        if TempLeBitPSLongtextLine.Text.HASVALUE then begin
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
                            if TempLeBitPSLongtextLine.ISEMPTY then
                                CurrReport.BREAK;

                            TempLBFuss.SETRANGE(Number, 1, TempLeBitPSLongtextLine.COUNT);
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
                    PurchLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    PrepmtInvBuf.DELETEALL;
                    PurchPostPrepmt.GetPurchLines("Purchase Header", 0, PrepmtPurchLine);
                    if not PrepmtPurchLine.ISEMPTY then begin
                        PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        if not TempPurchLine.ISEMPTY then
                            PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, PrePmtVATAmountLineDeduct, 1);
                    end;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    PrepmtVATAmountLine.DeductVATAmountLine(PrePmtVATAmountLineDeduct);
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;

                    if Number > 1 then
                        CopyText := FormatDocument.GetCOPYText;
                    OutputNo := OutputNo + 1;

                    TotalSubTotal := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.PREVIEW then
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
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");
                PricesInclVATtxt := FORMAT("Prices Including VAT");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if not CurrReport.PREVIEW then begin
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    if LogInteraction then begin
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    end;
                end;

                Vendor.GET("Purchase Header"."Pay-to Vendor No.");
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
                    field(NoofCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies', Comment = 'DEU="Anzahl Kopien"';
                        ToolTip = 'Specifies how many copies of the document to print.', comment = 'DEU="Legt die Anzahl der Ausdrücke fest"';
                    }
                    field(ShowInternalInformation; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'DEU="Interne Informationen anzeigen"';
                        ToolTip = 'Specifies if the document shows internal information.', comment = 'DEU="Legt fest ob vorhandene Dimensionswerte mit ausgedruckt werden sollen"';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document', Comment = 'DEU="Beleg archivieren"';
                        ToolTip = 'Specifies if the document is archived after you preview or print it.', comment = 'DEU="Legt fest ob das Dokument nach dem Ausdruck oder Vorschau auch archiviert wird"';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction', Comment = 'DEU="Aktivität protokollieren"';
                        ToolTip = 'Specifies that interactions with the contact are logged.', comment = 'DEU="Legt fest, dass Aktivitäten mit dem Kontakt protokolliert werden."';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            if LogInteraction then
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(HideCompanyInfo; HideCompanyInfo)
                    {
                        Caption = 'Hide Company Info', Comment = 'DEU="Firmendaten ausblenden"';
                        ToolTip = 'Specifies that the company data is to be "hidden" for printing', comment = 'DEU="Hiermit können Sie die Firmendaten für den Druck ausblenden"';
                    }
                    field(ItemPicturePrint; ItemPicturePrint)
                    {
                        Caption = 'Print Item Picture', Comment = 'DEU="Artikelbilder drucken"';
                        ToolTip = 'Specifies that the article images are printed ', comment = 'DEU="Legt fest ob Artikelbilder mit ausgedruckt werden"';
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
            ArchiveDocument := PurchSetup."Archive Return Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        CompanyInfo.GET;
        PurchSetup.GET;
        FormatDocument.SetLogoPosition(PurchSetup."LBT Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    var
        Text004: Label 'Return Order %1', Comment = 'DEU="Reklamation %1"';
        Text005: Label 'Page %1', Comment = 'DEU="Seite Nr. %1"';
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
        Language: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        PurchPost: Codeunit "Purch.-Post";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        BuyFromAddr: array[8] of Text[50];
        PurchaserText: Text[30];
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
        DimText: Text[120];
        OldDimText: Text[75];
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
        Text007: Label 'VAT Amount Specification in ', Comment = 'DEU="MwSt.-Betrag Spezifikation in "';
        Text008: Label 'Local Currency', Comment = 'DEU="Landeswährung"';
        Text009: Label 'Exchange rate: %1/%2', Comment = 'DEU="Wechselkurs: %1/%2"';
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        PricesInclVATtxt: Text[30];
        AllowInvDisctxt: Text[30];
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.', Comment = 'DEU="Telefonnr."';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.', Comment = 'DEU="Faxnr."';
        CompanyInfo__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.', Comment = 'DEU="USt-IdNr."';
        CompanyInfo__Giro_No__CaptionLbl: Label 'Giro No.', Comment = 'DEU="Girokontonr."';
        CompanyInfo__Bank_Name_CaptionLbl: Label 'Bank', Comment = 'DEU="Bankkonto"';
        CompanyInfo__Bank_Account_No__CaptionLbl: Label 'Account No.', Comment = 'DEU="Kontonr."';
        ReturnOrderNoCaptionLbl: Label 'Return Order No.', Comment = 'DEU="Reklamationsnr."';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions', Comment = 'DEU="Kopfdimensionen"';
        Direct_Unit_CostCaptionLbl: Label 'Direct Unit Cost', Comment = 'DEU="EK-Preis"';
        Purchase_Line___Line_Discount___CaptionLbl: Label 'Disc. %', Comment = 'DEU="Rab. %"';
        AmountCaptionLbl: Label 'Amount', Comment = 'DEU="Betrag"';
        ContinuedCaptionLbl: Label 'Continued', Comment = 'DEU=""';
        ContinuedCaption_Control76Lbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        PurchLine__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount', Comment = 'DEU=""';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'DEU="Zw.summe"';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT', Comment = 'DEU="Skonto auf MwSt."';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions', Comment = 'DEU="Zeilendimensionen"';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms', Comment = 'DEU="Zahlungsbedingungen"';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method', Comment = 'DEU="Lieferbedingung"';
        Payment_DetailsCaptionLbl: Label 'Payment Details', Comment = 'DEU="Zahlungsdetails"';
        Vendor_No_CaptionLbl: Label 'Vendor No.', Comment = 'DEU="Kreditorennr."';
        Ship_to_AddressCaptionLbl: Label 'Ship-to Address', Comment = 'DEU="Lief. an Adresse"';
        PrepmtLineAmount_Control173CaptionLbl: Label 'Amount', Comment = 'DEU="Betrag"';
        PrepmtInvBuf_DescriptionCaptionLbl: Label 'Description', Comment = 'DEU="Beschreibung"';
        PrepmtInvBuf__G_L_Account_No__CaptionLbl: Label 'G/L Account No.', Comment = 'DEU="Sachkontonr."';
        Prepayment_SpecificationCaptionLbl: Label 'Prepayment Specification', Comment = 'DEU="Vorauszahlung - Spezifikation"';
        ContinuedCaption_Control176Lbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        ContinuedCaption_Control178Lbl: Label 'Continued', Comment = 'DEU="Fortsetzung"';
        Line_DimensionsCaption_Control180Lbl: Label 'Line Dimensions', Comment = 'DEU="Fortsetzung"';
        "### Lebit Correspondence Globals ###": Integer;
        CompanyAddressLine: Text;
        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
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
        Item: Record Item;
        TempBlob: Record TempBlob;
        ItemPictureExist: Boolean;
        ItemPicturePrint: Boolean;
        LBKopf_Description: Text;
        NewPageLBKopf: Integer;
        LBLang_Description: Text;
        NewPageLBLang: Integer;
        LBFuss_Description: Text;
        NewPageLBFuss: Integer;
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        TempLeBitPSLongtextLine: Record "LBT PS Longtext Line" temporary;
        ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report";
        Vendor: Record Vendor;
        VATPercentCaptionLbl: Label 'VAT %', Comment = 'DEU="MwSt. %"';
        VATBaseCaptionLbl: Label 'VAT Base', Comment = 'DEU="MwSt.-Bemessungsgrundlage"';
        VATAmtCaptionLbl: Label 'VAT Amount', Comment = 'DEU="MwSt.-Betrag"';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', Comment = 'DEU="MwSt.-Betrag Spezifikation in "';
        VATIdentifierCaptionLbl: Label 'VAT Identifier', Comment = 'DEU="MwSt.-Kennzeichen"';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', Comment = 'DEU="Rechnungsrab.-Bem.grundlage"';
        LineAmtCaptionLbl: Label 'Line Amount', Comment = 'DEU="Zeilenbetrag"';
        InvDisAmtCaptionLbl: Label 'Invoice Discount Amount', Comment = 'DEU="Rechnungsrab.-Bem.grundlage"';
        VATBaseCaption1Lbl: Label 'Total', Comment = 'DEU="Gesamt"';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address', Comment = 'DEU="Lief. an Adresse"';
        VATIdentifierCaption1Lbl: Label 'VAT Identifier', Comment = 'DEU="MwSt.-Kennzeichen"';
        VATPctCaptionLbl: Label 'VAT %', Comment = 'DEU="MwSt. %"';
        VATBaseCaption2Lbl: Label 'VAT Base', Comment = 'DEU="MwSt.-Bemessungsgrundlage"';
        VATAmountCaptionLbl: Label 'VAT Amount', Comment = 'DEU="MwSt.-Betrag"';
        TotalCaption1Lbl: Label 'Total', Comment = 'DEU="Gesamt"';
        DocCaptionLbl: Label 'Return Order %1', Comment = 'DEU="Reklamation %1"';
        PagefromPageCaptionLbl: Label 'Page %1 of %2', Comment = 'DEU="Seite %1 von %2"';
        PageCaptionLbl: Label 'Page %1', Comment = 'DEU="Seite %1"';
        NoCaptionLbl: Label 'No.', Comment = 'DEU="Nr."';
        FromCaptionLbl: Label 'from', Comment = 'DEU="vom"';
        Bill_to_Customer_No__CaptionLbl: Label 'Customer ID', Comment = 'DEU="Kunden-Nr."';
        DatumCaptionLbl: Label 'Date', Comment = 'DEU="Datum"';
        CompanyInfo__VAT_Registration_No__CaptionLbl2: Label 'VAT Reg. No.', Comment = 'DEU="USt-IdNr."';
        PosNo_CaptionLbl: Label 'Pos.', Comment = 'DEU="Pos."';
        UOM_CaptionLbl: Label 'Unit', Comment = 'DEU="Einheit"';
        CompanyInfo__LeBit_Trade_Register_Name_Caption_Lbl: Label 'Registered in:', Comment = 'DEU="Eingetragen im:"';
        CompanyInfo__LeBit_CEO_Caption_Lbl: Label 'Chief Executive Officer', Comment = 'DEU="Geschäftsführer"';
        CompanyInfo__Bank_Name_Caption_Lbl: Label 'Bank', Comment = 'DEU="Bankkonto"';
        CompanyInfo_IBAN_Caption_Lbl: Label 'IBAN', Comment = 'DEU="IBAN"';
        CompanyInfo__SWIFT_Code_Caption_Lbl: Label 'SWIFT-BIC', Comment = 'DEU="SWIFT-BIC"';
        PurchPersonText_Caption: Label 'Salesperson', Comment = 'DEU="Bearbeiter"';
        CompanyInfo_E_Mail_Caption_Lbl: Label 'Mail:', Comment = 'DEU="E-Mail"';
        CompanyInfo__Home_Page_Caption_Lbl: Label 'Homepage:', Comment = 'DEU="Homepage:"';
        FaxNoCaptionLbl: Label 'Telefax no.', Comment = 'DEU="Faxnr."';
        CarryForwardCaptionLbl: Label 'Carry-forward %1', Comment = 'DEU="Übertrag %1"';
        Alternativposition_CaptionLbl: Label 'Alternative position', Comment = 'DEU="Alternativposition"';
        Bedarfposition_CaptionLbl: Label 'Position requirements', Comment = 'DEU="Bedarfposition"';
        BitteAndern_CaptionLbl: Label 'please change!', Comment = 'DEU="bitte ändern!"';
        Purchase_Line___Vendor_Item_No__CaptionLbl: Label 'No.', Comment = 'DEU="Nr."';
        DirectUnitCost: Decimal;
        LeBitReportFunctions: Codeunit "LBT Report Functions";
        VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.', Comment = 'DEU="USt-IdNr."';

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
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
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

            ReferenceText := FormatDocument.SetText("Your Reference" <> '', FIELDCAPTION("Your Reference"));
            VATNoText := FormatDocument.SetText("VAT Registration No." <> '', FIELDCAPTION("VAT Registration No."));
            if PurchaserText <> '' then
                PurchaserText := PurchPersonText_Caption;
        end;
    end;

    local procedure "### Lebit Correspondence Functions ###"()
    begin
    end;

    local procedure CreateLBText(LeBitPSLongtextLine: Record "LBT PS Longtext Line")
    var
        NextLineNo: Integer;
        LBText: Text;
        Streamin: InStream;
        Streamout: OutStream;
        LastSign: Text[10];
        NewLine: Boolean;
    begin
        if TempLeBitPSLongtextLine.ISEMPTY then begin
            TempLeBitPSLongtextLine := LeBitPSLongtextLine;
            TempLeBitPSLongtextLine.Description := '';
            TempLeBitPSLongtextLine.INSERT;
        end;

        TempLeBitPSLongtextLine.FINDLAST;
        NewLine := false;

        TempLeBitPSLongtextLine.CALCFIELDS(Text);
        if TempLeBitPSLongtextLine.Text.HASVALUE then begin
            TempLeBitPSLongtextLine.Text.CREATEINSTREAM(Streamin);
            Streamin.READ(LBText);
        end;

        case LeBitPSLongtextLine.Type of
            LeBitPSLongtextLine.Type::"New Page":
                begin
                    TempLeBitPSLongtextLine := LeBitPSLongtextLine;
                    TempLeBitPSLongtextLine."Line No." := TempLeBitPSLongtextLine."Line No." + 10000;
                    TempLeBitPSLongtextLine.INSERT;
                    NewLine := true;
                    LBText := '';
                end;
            LeBitPSLongtextLine.Type::Text:
                begin
                    if LeBitPSLongtextLine.Description = '' then begin
                        if STRLEN(LBText) <> 0 then begin
                            LastSign := COPYSTR(LBText, STRLEN(LBText) - 3, 4);
                            if LastSign = '<br>' then
                                LBText := COPYSTR(LBText, 1, STRLEN(LBText) - 4);
                        end;
                        LBText += '<br>';
                        NewLine := true;
                    end else begin
                        if STRLEN(LBText) <> 0 then begin
                            LastSign := COPYSTR(LBText, STRLEN(LBText), 1);
                            if LastSign in ['>', ' '] then
                                LBText += LeBitPSLongtextLine.Description
                            else
                                LBText += (' ' + LeBitPSLongtextLine.Description);
                        end else
                            LBText += LeBitPSLongtextLine.Description;
                    end;
                end;
            LeBitPSLongtextLine.Type::"Text + Line break":
                begin
                    if LeBitPSLongtextLine.Description = '' then begin
                        if STRLEN(LBText) <> 0 then begin
                            LastSign := COPYSTR(LBText, STRLEN(LBText) - 3, 4);
                            if LastSign = '<br>' then
                                LBText := COPYSTR(LBText, 1, STRLEN(LBText) - 4);
                        end;
                        LBText += '<br>';
                        NewLine := true;
                    end else begin
                        if STRLEN(LBText) <> 0 then begin
                            LastSign := COPYSTR(LBText, STRLEN(LBText), 1);
                            if LastSign in ['>', ' '] then
                                LBText += LeBitPSLongtextLine.Description + '<br>'
                            else
                                LBText += (' ' + LeBitPSLongtextLine.Description) + '<br>';
                        end else
                            LBText += LeBitPSLongtextLine.Description + '<br>';
                    end;
                end;
        end;

        if LBText <> '' then begin
            TempLeBitPSLongtextLine.Text.CREATEOUTSTREAM(Streamout);
            Streamout.WRITE(LBText);
            TempLeBitPSLongtextLine.MODIFY;
        end;
        if NewLine then begin
            TempLeBitPSLongtextLine.INIT;
            TempLeBitPSLongtextLine."Line No." := TempLeBitPSLongtextLine."Line No." + 10000;
            TempLeBitPSLongtextLine.Type := TempLeBitPSLongtextLine.Type::Text;
            TempLeBitPSLongtextLine.INSERT;
        end;
    end;

    local procedure GetFirstMediaFromSet(MediaSetID: Guid; var TempBlob: Record TempBlob): Boolean
    var
        TenantMediaSet: Record "Tenant Media Set";
        OStream: OutStream;
    begin
        CLEAR(TempBlob);
        TenantMediaSet.SETRANGE(ID, MediaSetID);

        if TenantMediaSet.FINDFIRST then begin
            TempBlob.Blob.CREATEOUTSTREAM(OStream);
            TenantMediaSet."Media ID".EXPORTSTREAM(OStream);

            exit(true);
        end;

        exit(false);
    end;
}

