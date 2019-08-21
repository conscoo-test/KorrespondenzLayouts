report 5272725 "LBT Blanket Sales Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Rep5272725.LBTBlanketSalesOrder.rdlc';
    Caption = 'Blanket Sales Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING ("Document Type", "No.") WHERE ("Document Type" = CONST ("Blanket Order"));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Blanket Sales Order';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                    column(CompanyInfo2_Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo1_Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(DocumentConfirmCopyCaption; STRSUBSTNO(Text004, CopyText))
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
                    column(Sales_Header___Shipment_Date_; FORMAT("Sales Header"."Shipment Date"))
                    {
                    }
                    column(Sales_Header___Document_Date; FORMAT("Sales Header"."Document Date", 0, 4))
                    {
                    }
                    column(Sales_Header___No__; "Sales Header"."No.")
                    {
                    }
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(VATRegNo_SalesHeader; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(SalesOrderReference_SalesHeader; "Sales Header"."Your Reference")
                    {
                    }
                    column(Sales_Header___Prices_Including_VAT_; "Sales Header"."Prices Including VAT")
                    {
                    }
                    column(PricesInclVATYesNo_SalesHeader; FORMAT("Sales Header"."Prices Including VAT"))
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
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(HideCompanyInfo; HideCompanyInfo)
                    {
                    }
                    column(DimensionLoop1Number; Number)
                    {
                    }
                    column(Sales_Header___Bill_to_Customer_No__Caption; "Sales Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(Sales_Header___Shipment_Date_Caption; Sales_Header___Shipment_Date_CaptionLbl)
                    {
                    }
                    column(Sales_Header___No__Caption; Order_No_CaptionLbl)
                    {
                    }
                    column(Sales_Header___Prices_Including_VAT_Caption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(Order_No_Caption; Order_No_CaptionLbl)
                    {
                    }
                    column(PagefromPageCaption; PagefromPageCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
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
                    column(CompanyInfo__Bank_Name_Caption; CompanyInfo__Bank_Name_CaptionLbl)
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
                    column(VAT_Registration_No__Caption; VAT_Registration_No__CaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1_Number; DimensionLoop1.Number)
                        {
                        }
                        column(DimText_Control80; DimText)
                        {
                        }
                        column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FIND('-') then
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
                        DataItemLink = "Document No." = FIELD ("No."), "Document Type" = FIELD ("Document Type");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING ("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE ("Table ID" = CONST (36), Position = CONST (Header));

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
                        DataItemTableView = SORTING (Number);
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
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING ("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(TotalSalesInvDiscAmount; TotalSalesInvDiscAmount)
                        {
                        }
                        column(TotalSalesLineAmount; TotalSalesLineAmount)
                        {
                        }
                        column(Item_Picture; TempBlob.Blob)
                        {
                        }
                        column(ItemPictureExist; ItemPictureExist)
                        {
                        }
                        column(SalesLineAmt; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesLine; "Sales Line".Description)
                        {
                        }
                        column(VATBaseDisc_SalesHeader; "Sales Header"."VAT Base Discount %")
                        {
                        }
                        column(No2_SalesLine; "Sales Line"."No.")
                        {
                        }
                        column(Sales_Line__Description_Control63; "Sales Line".Description)
                        {
                        }
                        column(Qty_SalesLine; "Sales Line".Quantity)
                        {
                        }
                        column(UOM_SalesLine; "Sales Line"."Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesLine; UnitPrice)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDisc_SalesLine; "Sales Line"."Line Discount %")
                        {
                        }
                        column(LineAmt_SalesLine; "Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_SalesLine; "Sales Line"."Allow Invoice Disc.")
                        {
                        }
                        column(VATIdentifier_SalesLine; "Sales Line"."VAT Identifier")
                        {
                        }
                        column(SalesLineType; FORMAT("Sales Line".Type, 0, 2))
                        {
                        }
                        column(No_SalesLine; "Sales Line"."Line No.")
                        {
                        }
                        column(AllowInvDiscountYesNo_SalesLine; FORMAT("Sales Line"."Allow Invoice Disc."))
                        {
                        }
                        column(SalesLine__Line_Amount__Control84; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Inv__Discount_Amount_; SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Line_Amount__Control70; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalsLinAmtExclLineDiscAmt; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATAmtLineVATAmtText3; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(SalesLine__Line_Amount__SalesLine__Inv__Discount_Amount__Control88; SalesLine."Line Amount" - VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineAmtExclLineDisc; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control131; TotalExclVATText)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText_Control133; VATAmountLine.VATAmountText)
                        {
                        }
                        column(VATAmount_Control134; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control135; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(Sales_Line___Line_Discount___Caption; Sales_Line___Line_Discount___CaptionLbl)
                        {
                        }
                        column(VATIdentifier_SalesLineCaption; "Sales Line".FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(Sales_Line___Allow_Invoice_Disc__Caption; "Sales Line".FIELDCAPTION("Allow Invoice Disc."))
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control83; ContinuedCaption_Control83Lbl)
                        {
                        }
                        column(SalesLine__Inv__Discount_Amount_Caption; SalesLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(SalesLineLeBitPrintoption; FORMAT("Sales Line"."LBT Printoption", 0, 2))
                        {
                        }
                        column(SalesLine__LeBit_Balance; SalesLine."LBT Balance")
                        {
                        }
                        column(Sales_Line___LeBit_Pos_No; "Sales Line"."LBT Pos. No.")
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
                        column(SalesHeader__VAT_Base_Disc___; "Sales Header"."VAT Base Discount %")
                        {
                        }
                        dataitem(ParameterAndUnits; "Integer")
                        {
                            DataItemTableView = SORTING (Number);
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
                            DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("Document No."), "Document Line No." = FIELD ("Line No.");
                            DataItemLinkReference = "Sales Line";
                            DataItemTableView = SORTING ("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE ("Table ID" = CONST (37), Position = CONST (Longtext));

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
                            DataItemTableView = SORTING (Number);
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
                            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 ..));
                            column(DimText_Control82; DimText)
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
                                SalesLine.FIND('-')
                            else
                                SalesLine.NEXT;
                            "Sales Line" := SalesLine;

                            if not "Sales Header"."Prices Including VAT" and
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            then
                                SalesLine."Line Amount" := 0;

                            if (SalesLine.Type = SalesLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Sales Line"."No." := '';

                            SalesLineTypeInt := SalesLine.Type;
                            TotalSalesLineAmount += SalesLine."Line Amount";
                            TotalSalesInvDiscAmount += SalesLine."Inv. Discount Amount";

                            if ((SalesLine."LBT Printoption" = SalesLine."LBT Printoption"::Alternative) or
                                (SalesLine."LBT Printoption" = SalesLine."LBT Printoption"::Optional))
                            then
                                MESSAGE(Text5272768);

                            if SalesLine."LBT Printoption" = SalesLine."LBT Printoption"::"New Page" then
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

                            if SalesLine.Quantity <> 0 then
                                UnitPrice := SalesLine."Unit Price" - SalesLine."Line Discount Amount" / SalesLine.Quantity
                            else
                                UnitPrice := 0;

                            SalesLine.CALCFIELDS("LBT Balance");
                            if SalesLine.Type = SalesLine.Type::Item then begin
                                Item.GET("Sales Line"."No.");
                                ItemPictureExist := GetFirstMediaFromSet(Item.Picture.MEDIAID, TempBlob);
                                if not ItemPicturePrint then
                                    ItemPictureExist := false;
                                TxtVar := CurrReport.OBJECTID(false);
                                TxtVar := COPYSTR(TxtVar, STRPOS(TxtVar, ' '));
                                EVALUATE(IntVar, TxtVar);
                                LeBitReportFunctions.GetParameterArry(ReportType::Sales, IntVar, 5, "Sales Header"."Language Code", "Sales Line".RowID1, '', "Sales Line"."No.", InfoCaptionArry, InfoValueArry);
                                LeBitReportFunctions.GetItemUnitArry(2, "Sales Line".RowID1, '', "Sales Header"."Language Code", ItemUnitCodeArry, ItemUnitDescriptionArry, ItemUnitQtyArry);
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
                                if SalesLine."Description 2" <> '' then begin
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
                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.FIND('+');
                            while MoreLines and (SalesLine.Description = '') and (SalesLine."Description 2" = '') and
                                  (SalesLine."No." = '') and (SalesLine.Quantity = 0) and
                                  (SalesLine.Amount = 0)
                            do
                                MoreLines := SalesLine.NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK;
                            SalesLine.SETRANGE("Line No.", 0, SalesLine."Line No.");
                            SETRANGE(Number, 1, SalesLine.COUNT);

                            TotalSalesLineAmount := 0;
                            TotalSalesInvDiscAmount := 0;
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(VATAmountLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Base__Control106; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control107; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control72; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control73; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control74; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control110; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control111; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control100; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control104; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control108; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control114; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control115; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control112; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control116; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control130; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounter_Number; Number)
                        {
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control106Caption; VATAmountLine__VAT_Base__Control106CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control107Caption; VATAmountLine__VAT_Amount__Control107CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control73Caption; VATAmountLine__Inv__Disc__Base_Amount__Control73CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control72Caption; VATAmountLine__Line_Amount__Control72CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control74Caption; VATAmountLine__Invoice_Discount_Amount__Control74CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control110Caption; VATAmountLine__VAT_Base__Control110CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control114Caption; VATAmountLine__VAT_Base__Control114CaptionLbl)
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
                        DataItemTableView = SORTING (Number);
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
                        column(VALVATAmountLCY_Control149; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control150; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT____Control151; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier__Control152; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATAmountLCY_Control156; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control157; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control159; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control160; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATCounterLCY_Number; Number)
                        {
                        }
                        column(VALVATAmountLCY_Control149Caption; VALVATAmountLCY_Control149CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control150Caption; VALVATBaseLCY_Control150CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT____Control151Caption; VATAmountLine__VAT____Control151CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier__Control152Caption; VATAmountLine__VAT_Identifier__Control152CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control157Caption; VALVATBaseLCY_Control157CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control160Caption; VALVATBaseLCY_Control160CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmountLine.COUNT < 2 then
                                CurrReport.BREAK;
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Header"."Currency Code" = '') or
                               (VATAmountLine.GetTotalVATAmount = 0)
                            then
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007 + Text008
                            else
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Posting Date", "Sales Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                        column(PmntTermsDesc; PaymentTerms.Description)
                        {
                        }
                        column(ShptMethodDesc; ShipmentMethod.Description)
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
                        DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                        column(SelltoCustNo_SalesHeader; "Sales Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(Total2_Number; Number)
                        {
                        }
                        column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(LBFuss; "LBT PS Longtext Line")
                    {
                        DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING ("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE ("Table ID" = CONST (36), Position = CONST (Footer));

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
                        DataItemTableView = SORTING (Number);
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
                    PrepmtSalesLine: Record "Sales Line" temporary;
                    TempSalesLine: Record "Sales Line" temporary;
                    SalesPost: Codeunit "Sales-Post";
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    SalesLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, "Sales Header", SalesLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText;
                        OutputNo += 1;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.PREVIEW then
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
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                FormatAddressFields("Sales Header");
                FormatDocumentFields("Sales Header");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if not CurrReport.PREVIEW then begin
                    if ArchiveDocument then
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    if LogInteraction then begin
                        CALCFIELDS("No. of Archived Versions");
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(
                              2, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        else
                            SegManagement.LogDocument(
                              2, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
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
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(HideCompanyInfo; HideCompanyInfo)
                    {
                        Caption = 'Hide Company Info';
                    }
                    field(ItemPicturePrint; ItemPicturePrint)
                    {
                        Caption = 'Print Item Picture';
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
            ArchiveDocument := SalesSetup."Archive Blanket Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(3) <> '';

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
        SalesSetup.GET;

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                end;
        end;
    end;

    var
        Text004: Label 'Blanket Sales Order %1', Comment = '%1 = Document No.';
        PageCaptionCap: Label 'Page %1 of %2';
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        CompanyInfo__Giro_No__CaptionLbl: Label 'Giro No.';
        CompanyInfo__Bank_Name_CaptionLbl: Label 'Bank';
        CompanyInfo__Bank_Account_No__CaptionLbl: Label 'Account No.';
        Sales_Header___Shipment_Date_CaptionLbl: Label 'Shipment Date';
        Order_No_CaptionLbl: Label 'Order No.';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        Sales_Line___Line_Discount___CaptionLbl: Label 'Disc. %';
        AmountCaptionLbl: Label 'Amount';
        ContinuedCaptionLbl: Label 'Continued';
        ContinuedCaption_Control83Lbl: Label 'Continued';
        SalesLine__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT_Base__Control106CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT_Amount__Control107CaptionLbl: Label 'VAT Amount';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmountLine__Inv__Disc__Base_Amount__Control73CaptionLbl: Label 'Inv. Disc. Base Amount';
        VATAmountLine__Line_Amount__Control72CaptionLbl: Label 'Line Amount';
        VATAmountLine__Invoice_Discount_Amount__Control74CaptionLbl: Label 'Invoice Discount Amount';
        VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Base__Control110CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Base__Control114CaptionLbl: Label 'Total';
        VALVATAmountLCY_Control149CaptionLbl: Label 'VAT Amount';
        VALVATBaseLCY_Control150CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT____Control151CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT_Identifier__Control152CaptionLbl: Label 'VAT Identifier';
        VALVATBaseLCYCaptionLbl: Label 'Continued';
        VALVATBaseLCY_Control157CaptionLbl: Label 'Continued';
        VALVATBaseLCY_Control160CaptionLbl: Label 'Total';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method';
        Ship_to_AddressCaptionLbl: Label 'Ship-to Address';
        PrepmtLineAmount_Control166CaptionLbl: Label 'Amount';
        PrepmtInvBuf_DescriptionCaptionLbl: Label 'Description';
        PrepmtInvBuf__G_L_Account_No__CaptionLbl: Label 'G/L Account No.';
        Prepayment_SpecificationCaptionLbl: Label 'Prepayment Specification';
        ContinuedCaption_Control170Lbl: Label 'Continued';
        ContinuedCaption_Control171Lbl: Label 'Continued';
        Line_DimensionsCaption_Control174Lbl: Label 'Line Dimensions';
        PrepmtVATAmountLine__VAT_Amount__Control194CaptionLbl: Label 'VAT Amount';
        PrepmtVATAmountLine__VAT_Base__Control195CaptionLbl: Label 'VAT Base';
        PrepmtVATAmountLine__Line_Amount__Control196CaptionLbl: Label 'Line Amount';
        PrepmtVATAmountLine__VAT____Control197CaptionLbl: Label 'VAT %';
        Prepayment_VAT_Amount_SpecificationCaptionLbl: Label 'Prepayment VAT Amount Specification';
        PrepmtVATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
        ContinuedCaption_Control202Lbl: Label 'Continued';
        ContinuedCaption_Control207Lbl: Label 'Continued';
        PrepmtVATAmountLine__VAT_Base__Control208CaptionLbl: Label 'Total';
        PrepmtPaymentTerms_DescriptionCaptionLbl: Label 'Prepmt. Payment Terms';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        VATAmountLine: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        Language: Record Language;
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        SalesLineTypeInt: Integer;
        OutputNo: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        TotalSalesLineAmount: Decimal;
        TotalSalesInvDiscAmount: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        SalesSetup: Record "Sales & Receivables Setup";
        ArchiveManagement: Codeunit ArchiveManagement;
        ArchiveDocument: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
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
        TempLeBitPSLongtextLine: Record "LBT PS Longtext Line" temporary;
        NewPageLBKopf: Integer;
        LBLang_Description: Text;
        NewPageLBLang: Integer;
        LBFuss_Description: Text;
        NewPageLBFuss: Integer;
        DocCaptionLbl: Label 'Blanket Sales Order %1', Comment = '%1 = Document No.';
        PagefromPageCaptionLbl: Label 'Page %1 of %2';
        PageCaptionLbl: Label 'Page %1';
        NoCaptionLbl: Label 'No.';
        FromCaptionLbl: Label 'from';
        Sales_Header___Bill_to_Customer_No__CaptionLbl: Label 'Customer ID';
        DatumCaptionLbl: Label 'Date';
        CompanyInfo__VAT_Registration_No__CaptionLbl2: Label 'VAT Reg. No.';
        Alternativposition_CaptionLbl: Label 'Alternative position';
        Bedarfposition_CaptionLbl: Label 'Position requirements';
        BitteAndern_CaptionLbl: Label 'please change!';
        PosNo_SalesLineCaptionLbl: Label 'Pos.';
        UOM_SalesLineCaptionLbl: Label 'Unit';
        CarryForwardCaptionLbl: Label 'Carry-forward %1';
        CompanyInfo__LeBit_Trade_Register_Name_Caption_Lbl: Label 'Registered in:';
        CompanyInfo__LeBit_CEO_Caption_Lbl: Label 'Chief Executive Officer';
        CompanyInfo__Bank_Name_Caption_Lbl: Label 'Bank';
        CompanyInfo_IBAN_Caption_Lbl: Label 'IBAN';
        CompanyInfo__SWIFT_Code_Caption_Lbl: Label 'SWIFT-BIC';
        SalesPersonText_Caption: Label 'Salesperson';
        CompanyInfo_E_Mail_Caption_Lbl: Label 'Mail:';
        CompanyInfo__Home_Page_Caption_Lbl: Label 'Homepage:';
        Text5272768: Label 'At orders no alternative positions and demand positions are allowed!';
        ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report";
        UnitPrice: Decimal;
        LeBitReportFunctions: Codeunit "LBT Report Functions";
        VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        CustSource: Option Default,"Bill-to Customer","Sell-to Customer";

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    local procedure FormatAddressFields(var SalesHeader: Record "Sales Header")
    var
        i: Integer;
    begin
        FormatAddr.GetCompanyAddr(SalesHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        GetCustSource;
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

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        with SalesHeader do begin
            FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalesPurchPerson, "Salesperson Code", SalesPersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");

            ReferenceText := FormatDocument.SetText("Your Reference" <> '', FIELDCAPTION("Your Reference"));
            VATNoText := FormatDocument.SetText("VAT Registration No." <> '', FIELDCAPTION("VAT Registration No."));
            if SalesPersonText <> '' then
                SalesPersonText := SalesPersonText_Caption;
        end;
    end;

    local procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.GET(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PADSTR('', 2, ' '));
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

    local procedure GetCustSource()
    var
        TypeVar: Option Sales,Purchase;
        ReportType: Option " ","Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order","Purchase Quote","Purchase Order","Blanket Purchase Order";
    begin
        LeBitReportFunctions.GetSourceType(TypeVar::Sales, ReportType::"Blanket Sales Order", CustSource);
    end;
}

