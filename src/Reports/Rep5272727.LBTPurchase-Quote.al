report 5272727 "LBT Purchase - Quote"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Rep5272727.LBTPurchase-Quote.rdlc';
    Caption = 'Purchase - Quote';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING ("Document Type", "No.") WHERE ("Document Type" = CONST (Quote));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Quote';
            column(DocType_PurchHead; "Document Type")
            {
            }
            column(PurchHeadNo; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
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
                    column(VendAddr1; VendAddr[1])
                    {
                    }
                    column(VendAddr2; VendAddr[2])
                    {
                    }
                    column(VendAddr3; VendAddr[3])
                    {
                    }
                    column(VendAddr4; VendAddr[4])
                    {
                    }
                    column(VendAddr5; VendAddr[5])
                    {
                    }
                    column(VendAddr6; VendAddr[6])
                    {
                    }
                    column(VendAddr7; VendAddr[7])
                    {
                    }
                    column(VendAddr8; VendAddr[8])
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
                    column(DocDate_PurchHdr; FORMAT("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(ExpctRecpDt_PurchHdr; FORMAT("Purchase Header"."Expected Receipt Date", 0, 4))
                    {
                    }
                    column(VatTRegNo_PurchHdr; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(PaytoVendNo_PurchHdr; "Purchase Header"."Pay-to Vendor No.")
                    {
                    }
                    column(YourRef_PurchHdr; "Purchase Header"."Your Reference")
                    {
                    }
                    column(No1_PurchaseHdr; "Purchase Header"."No.")
                    {
                    }
                    column(VatNoText; VATNoText)
                    {
                    }
                    column(PurchaserText; PurchaserText)
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
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(PaytoVendNo_PurchHdrCaption; "Purchase Header".FIELDCAPTION("Pay-to Vendor No."))
                    {
                    }
                    column(Expected_DateCaption; Expected_DateCaptionLbl)
                    {
                    }
                    column(Quote_No_Caption; Quote_No_CaptionLbl)
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
                        DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1_Number; DimensionLoop1.Number)
                        {
                        }
                        column(DimText_Control58; DimText)
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
                                    DimText := STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1; %2 - %3', DimText,
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
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING ("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE ("Table ID" = CONST (38), Position = CONST (Header));

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
                        DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING ("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(ArchiveDocument; ArchiveDocument)
                        {
                        }
                        column(LogInteraction; LogInteraction)
                        {
                        }
                        column(PurchaseLineType; FORMAT("Purchase Line".Type, 0, 2))
                        {
                        }
                        column(LineNo_PurchaseLine; "Purchase Line"."Line No.")
                        {
                        }
                        column(Description_PurchaseLine; "Purchase Line".Description)
                        {
                        }
                        column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                        {
                        }
                        column(UnitOfMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(Purchase_Line___Expected_Receipt_Date_; FORMAT("Purchase Line"."Expected Receipt Date"))
                        {
                        }
                        column(No_PurchaseLine; "Purchase Line"."No.")
                        {
                        }
                        column(Purchase_Line___Vendor_Item_No__; "Purchase Line"."Vendor Item No.")
                        {
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(Purchase_Line___Expected_Receipt_Date__Caption; Purchase_Line___Expected_Receipt_Date__CaptionLbl)
                        {
                        }
                        column(Purchase_Line___Unit_of_Measure__Caption; "Purchase Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(Purchase_Line___No__Caption; Purchase_Line___No__CaptionLbl)
                        {
                        }
                        column(Purchase_Line___Vendor_Item_No__Caption; Purchase_Line___Vendor_Item_No__CaptionLbl)
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
                            DataItemLinkReference = "Purchase Line";
                            DataItemTableView = SORTING ("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE ("Table ID" = CONST (39), Position = CONST (Longtext));

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
                            column(DimText1; DimText)
                            {
                            }
                            column(DimensionLoop2_Number; DimensionLoop2.Number)
                            {
                            }
                            column(DimText_Control80; DimText)
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
                                        DimText := STRSUBSTNO('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1; %2 - %3', DimText,
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

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");

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
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                        column(ShipmentMethod_Description; ShipmentMethod.Description)
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }
                        column(ShipmentMethod_DescriptionCaption; ShipmentMethod_DescriptionCaptionLbl)
                        {
                        }
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                        column(Purchase_Header___Buy_from_Vendor_No__; "Purchase Header"."Buy-from Vendor No.")
                        {
                        }
                        column(Total2_Number; Number)
                        {
                        }
                        column(Purchase_Header___Buy_from_Vendor_No__Caption; "Purchase Header".FIELDCAPTION("Buy-from Vendor No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total3; "Integer")
                    {
                        DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
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
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(LBFuss; "LBT PS Longtext Line")
                    {
                        DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING ("Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.") ORDER(Ascending) WHERE ("Table ID" = CONST (38), Position = CONST (Footer));

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
                begin
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DELETEALL;
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);

                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText;
                        OutputNo += 1;
                    end;
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
                    OutputNo := 1;
                    NewPageGroup := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if not CurrReport.PREVIEW then begin
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    if LogInteraction then begin
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          11, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Pay-to Vendor No.",
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

                        trigger OnValidate()
                        begin
                            if LogInteraction then
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
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
            case PurchSetup."Archiving Purchase Quote" of
                PurchSetup."Archiving Purchase Quote"::Never:
                    ArchiveDocument := false;
                PurchSetup."Archiving Purchase Quote"::Always:
                    ArchiveDocument := true;
            end;
            LogInteraction := SegManagement.FindInteractTmplCode(11) <> '';

            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        PurchSetup.GET;
        FormatDocument.SetLogoPosition(PurchSetup."LBT Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    var
        Text002: Label 'Purchase - Quote %1', Comment = '%1 = Document No.';
        Text003: Label 'Page %1';
        ShipmentMethod: Record "Shipment Method";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        PurchLine: Record "Purchase Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        PurchSetup: Record "Purchases & Payables Setup";
        PurchPost: Codeunit "Purch.-Post";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        OutputNo: Integer;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        CompanyInfo__Giro_No__CaptionLbl: Label 'Giro No.';
        CompanyInfo__Bank_Name_CaptionLbl: Label 'Bank';
        CompanyInfo__Bank_Account_No__CaptionLbl: Label 'Account No.';
        Expected_DateCaptionLbl: Label 'Expected Date';
        Quote_No_CaptionLbl: Label 'Quote No.';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Purchase_Line___Expected_Receipt_Date__CaptionLbl: Label 'Expected Date';
        Purchase_Line___No__CaptionLbl: Label 'Our No.';
        Purchase_Line___Vendor_Item_No__CaptionLbl: Label 'No.';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method';
        Ship_to_AddressCaptionLbl: Label 'Ship-to Address';
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
        DocCaptionLbl: Label 'Quote %1', Comment = '%1 = Document No.';
        PagefromPageCaptionLbl: Label 'Page %1 of %2';
        PageCaptionLbl: Label 'Page %1';
        NoCaptionLbl: Label 'No.';
        FromCaptionLbl: Label 'from';
        Bill_to_Customer_No__CaptionLbl: Label 'Customer ID';
        DatumCaptionLbl: Label 'Date';
        CompanyInfo__VAT_Registration_No__CaptionLbl2: Label 'VAT Reg. No.';
        PosNo_CaptionLbl: Label 'Pos.';
        UOM_CaptionLbl: Label 'Unit';
        CompanyInfo__LeBit_Trade_Register_Name_Caption_Lbl: Label 'Registered in:';
        CompanyInfo__LeBit_CEO_Caption_Lbl: Label 'Chief Executive Officer';
        CompanyInfo__Bank_Name_Caption_Lbl: Label 'Bank';
        CompanyInfo_IBAN_Caption_Lbl: Label 'IBAN';
        CompanyInfo__SWIFT_Code_Caption_Lbl: Label 'SWIFT-BIC';
        PurchPersonText_Caption: Label 'Salesperson';
        CompanyInfo_E_Mail_Caption_Lbl: Label 'Mail:';
        CompanyInfo__Home_Page_Caption_Lbl: Label 'Homepage:';
        FaxNoCaptionLbl: Label 'Telefax no.';
        CarryForwardCaptionLbl: Label 'Carry-forward %1';
        GLSetup: Record "General Ledger Setup";
        SubtotalCaptionLbl: Label 'Subtotal';
        AmountCaptionLbl: Label 'Amount';
        Alternativposition_CaptionLbl: Label 'Alternative position';
        Bedarfposition_CaptionLbl: Label 'Position requirements';
        BitteAndern_CaptionLbl: Label 'please change!';
        TempLeBitPSLongtextLine: Record "LBT PS Longtext Line" temporary;
        ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report";
        Vendor: Record Vendor;
        LeBitReportFunctions: Codeunit "LBT Report Functions";
        VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        VendSource: Option Default,"Pay-to Vendor","Buy-from Vendor";

    procedure IntializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    local procedure FormatAddressFields(PurchaseHeader: Record "Purchase Header")
    var
        i: Integer;
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        GetVendSource;
        case VendSource of
            VendSource::Default, VendSource::"Pay-to Vendor":
                begin
                    FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
                    Vendor.GET("Purchase Header"."Pay-to Vendor No.");
                end;
            VendSource::"Buy-from Vendor":
                begin
                    FormatAddr.PurchHeaderBuyFrom(VendAddr, PurchaseHeader);
                    Vendor.GET("Purchase Header"."Buy-from Vendor No.");
                end;
        end;
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
            FormatDocument.SetPurchaser(SalesPurchPerson, "Purchaser Code", PurchaserText);
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

    local procedure GetVendSource()
    var
        TypeVar: Option Sales,Purchase;
        ReportType: Option " ","Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order","Purchase Quote","Purchase Order","Blanket Purchase Order";
    begin
        LeBitReportFunctions.GetSourceType(TypeVar::Purchase, ReportType::"Purchase Quote", VendSource);
    end;
}

