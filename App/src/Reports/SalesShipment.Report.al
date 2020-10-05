report 5272724 "lbt Sales - Shipment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/SalesShipment.Report.rdlc';

    Caption = 'Sales - Shipment';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Shipment';
            column(Footer; Footer) { }
            column(No_SalesShptHeader; "No.")
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
                    column(DocumentConfirmCopyCaption; STRSUBSTNO(TitleLbl, CopyText))
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
                    column(DocDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Document Date", 0, 4))
                    {
                    }
                    column(YourRef_SalesShptHeader; "Sales Shipment Header"."Your Reference")
                    {
                    }
                    column(SelltoCustNo_SalesShptHeader; "Sales Shipment Header"."Sell-to Customer No.")
                    {
                    }
                    column(OrderNo_SalesShptHeader; "Sales Shipment Header"."Order No.")
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
                    column(ShipmentNoCaption; ShipmentNoCaptionLbl)
                    {
                    }
                    column(SelltoCustNo_SalesShptHeaderCaption; "Sales Shipment Header".FIELDCAPTION("Sell-to Customer No."))
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
                    column(Description_SalesShptLineCaption; "Sales Shipment Line".FIELDCAPTION(Description))
                    {
                    }
                    column(Quantity_SalesShptLineCaption; "Sales Shipment Line".FIELDCAPTION(Quantity))
                    {
                    }
                    column(UOM_Caption; UOM_CaptionLbl)
                    {
                    }
                    column(CompanyAddressLine; CompanyAddressLine)
                    {
                    }
                    column(HideCompanyInfo; HideCompanyInfo)
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(VAT_Registration_No__Caption; VAT_Registration_No__CaptionLbl)
                    {
                    }
                    column(VATRegNo_SalesShptHeader; "Sales Shipment Header"."VAT Registration No.")
                    {
                    }
                    dataitem(LBKopf; "lbt Posted PS Longtext Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Table ID", "Document No.", Position, "Document Line No.", "Line No.") WHERE("Table ID" = CONST(110), Position = FILTER(Header));

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
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }
                        column(DimLoop1_Number; DimensionLoop1.Number)
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
                                        CombinedDimLbl, DimText,
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
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Description_SalesShptLine; Description)
                        {
                        }
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(SalesLineType; FORMAT(Type, 0, 2))
                        {
                        }
                        column(AsmHeaderExists; AsmHeaderExists)
                        {
                        }
                        column(LinNo; LinNo)
                        {
                        }
                        column(Qty_SalesShptLine; Quantity)
                        {
                        }
                        column(UOM_SalesShptLine; "Unit of Measure")
                        {
                        }
                        column(LineNo_SalesShptLine; "Line No.")
                        {
                        }
                        column(Item_Picture; Item.Picture)
                        {
                        }
                        column(ItemPictureExist; ItemPictureExist)
                        {
                        }
                        column(SalesLineLeBitPrintoption; FORMAT("lbt Printoption", 0, 2))
                        {
                        }
                        column(LeBitPosNo_SalesShptLine; "lbt Pos. No.")
                        {
                        }
                        column(Description2_SalesShptLine; "Description 2")
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
                        dataitem(LBLang; "lbt Posted PS Longtext Line")
                        {
                            DataItemLink = "Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                            DataItemLinkReference = "Sales Shipment Line";
                            DataItemTableView = SORTING("Table ID", "Document No.", Position, "Document Line No.", "Line No.") WHERE("Table ID" = CONST(111), Position = FILTER(Longtext));

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
                            end;
                        }
                        dataitem(DisplayAsmInfo; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(PostedAsmLineItemNo; BlanksForIndent() + PostedAsmLine."No.")
                            {
                            }
                            column(PostedAsmLineDescription; BlanksForIndent() + PostedAsmLine.Description)
                            {
                            }
                            column(PostedAsmLineQuantity; PostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(PostedAsmLineUOMCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record "Item Translation";
                            begin
                                if Number = 1 then
                                    PostedAsmLine.FindSet()
                                else
                                    PostedAsmLine.Next();

                                if ItemTranslation.Get(PostedAsmLine."No.",
                                     PostedAsmLine."Variant Code",
                                     "Sales Shipment Header"."Language Code")
                                then
                                    PostedAsmLine.Description := ItemTranslation.Description;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not DisplayAssemblyInformation then
                                    CurrReport.Break();
                                if not AsmHeaderExists then
                                    CurrReport.Break();

                                PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                                SETRANGE(Number, 1, PostedAsmLine.Count());
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            IntVar: Integer;
                            TxtVar: Text;
                            Counter: Integer;
                        begin
                            LinNo := "Line No.";
                            if not ShowCorrectionLines and Correction then
                                CurrReport.Skip();

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                            if DisplayAssemblyInformation then
                                AsmHeaderExists := AsmToShipmentExists(PostedAsmHeader);

                            if "lbt Printoption" = "lbt Printoption"::"New Page" then
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

                            if Type = Type::Item then begin
                                Item.Get("No.");
                                ItemPictureExist := Item.Picture.Count() > 0;
                                if not ItemPicturePrint then
                                    ItemPictureExist := false;
                                TxtVar := CurrReport.OBJECTID(false);
                                TxtVar := COPYSTR(TxtVar, STRPOS(TxtVar, ' '));
                                EVALUATE(IntVar, TxtVar);
                                LeBitReportFunctions.GetParameterArry(ReportType::Sales, IntVar, 1, "Sales Shipment Header"."Language Code", LeBitReportFunctions.RowID1ForSalesShipmentLine("Sales Shipment Line"), '', "Sales Shipment Line"."No.", InfoCaptionArry, InfoValueArry);
                                LeBitReportFunctions.GetItemUnitArry(1, LeBitReportFunctions.RowID1ForSalesShipmentLine("Sales Shipment Line"), '', "Sales Shipment Header"."Language Code", ItemUnitCodeArry, ItemUnitDescriptionArry, ItemUnitQtyArry);
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
                                    ItemUnitDescription := ItemUnitDescriptionArry[1];
                                    ItemUnitQty := ItemUnitQtyArry[1];
                                    ItemUnitCodeArry[1] := '';
                                    ItemUnitDescriptionArry[1] := '';
                                    ItemUnitQtyArry[1] := '';
                                    COMPRESSARRAY(ItemUnitCodeArry);
                                    COMPRESSARRAY(ItemUnitDescriptionArry);
                                    COMPRESSARRAY(ItemUnitQtyArry);
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

                        trigger OnPostDataItem()
                        begin
                            if ShowLotSN then begin
                                ItemTrackingDocMgt.SetRetrieveAsmItemTracking(true);
                                TrackingSpecCount :=
                                  ItemTrackingDocMgt.RetrieveDocumentItemTracking(TempTrackingSpecBuffer,
                                    "Sales Shipment Header"."No.", DATABASE::"Sales Shipment Header", 0);
                                ItemTrackingDocMgt.SetRetrieveAsmItemTracking(false);
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := FIND('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) do
                                MoreLines := Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            SETRANGE("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(BilltoCustNo_SalesShptHeader; "Sales Shipment Header"."Bill-to Customer No.")
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
                        column(BilltoAddressCaption; BilltoAddressCaptionLbl)
                        {
                        }
                        column(BilltoCustNo_SalesShptHeaderCaption; "Sales Shipment Header".FIELDCAPTION("Bill-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not ShowCustAddr then
                                CurrReport.Break();
                        end;
                    }
                    dataitem(ItemTrackingLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(TrackingSpecBufferNo; TempTrackingSpecBuffer."Item No.")
                        {
                        }
                        column(TrackingSpecBufferDesc; TempTrackingSpecBuffer.Description)
                        {
                        }
                        column(TrackingSpecBufferLotNo; TempTrackingSpecBuffer."Lot No.")
                        {
                        }
                        column(TrackingSpecBufferSerNo; TempTrackingSpecBuffer."Serial No.")
                        {
                        }
                        column(TrackingSpecBufferQty; TempTrackingSpecBuffer."Quantity (Base)")
                        {
                        }
                        column(ShowTotal; ShowTotal)
                        {
                        }
                        column(ShowGroup; ShowGroup)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(SerialNoCaption; SerialNoCaptionLbl)
                        {
                        }
                        column(LotNoCaption; LotNoCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        dataitem(TotalItemTracking; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                            column(Quantity1; TotalQty)
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                TempTrackingSpecBuffer.FindSet()
                            else
                                TempTrackingSpecBuffer.Next();

                            if not ShowCorrectionLines and TempTrackingSpecBuffer.Correction then
                                CurrReport.Skip();
                            if TempTrackingSpecBuffer.Correction then
                                TempTrackingSpecBuffer."Quantity (Base)" := -TempTrackingSpecBuffer."Quantity (Base)";

                            ShowTotal := false;
                            if ItemTrackingAppendix.IsStartNewGroup(TempTrackingSpecBuffer) then
                                ShowTotal := true;

                            ShowGroup := false;
                            if (TempTrackingSpecBuffer."Source Ref. No." <> OldRefNo) or
                               (TempTrackingSpecBuffer."Item No." <> OldNo)
                            then begin
                                OldRefNo := TempTrackingSpecBuffer."Source Ref. No.";
                                OldNo := TempTrackingSpecBuffer."Item No.";
                                TotalQty := 0;
                            end else
                                ShowGroup := true;
                            TotalQty += TempTrackingSpecBuffer."Quantity (Base)";
                        end;

                        trigger OnPreDataItem()
                        begin
                            if TrackingSpecCount = 0 then
                                CurrReport.Break();
                            SETRANGE(Number, 1, TrackingSpecCount);
                            TempTrackingSpecBuffer.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                              "Source Prod. Order Line", "Source Ref. No.");
                        end;
                    }
                    dataitem(LBFuss; "lbt Posted PS Longtext Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Table ID", "Document No.", Position, "Document Line No.", "Line No.") WHERE("Table ID" = CONST(110), Position = FILTER(Footer));

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

                    trigger OnPreDataItem()
                    begin
                        // Item Tracking:
                        if ShowLotSN then begin
                            TrackingSpecCount := 0;
                            OldRefNo := 0;
                            ShowGroup := false;
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    end;
                    TotalQty := 0;           // Item Tracking
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.PREVIEW() then
                        CODEUNIT.RUN(CODEUNIT::"Sales Shpt.-Printed", "Sales Shipment Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 1 + ABS(NoOfCopies);
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                FormatAddressFields("Sales Shipment Header");
                FormatDocumentFields("Sales Shipment Header");
                CompanyInfo."lbt SetReportFooter"(Footer);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if LogInteraction then
                    if not CurrReport.PREVIEW() then
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
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
                    field("No OfCopies"; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field("Show InternalInfo"; ShowInternalInfo)
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
                    field("Show Correction Lines"; ShowCorrectionLines)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Correction Lines';
                        ToolTip = 'Specifies that correction lines are displayed';
                    }
                    field("Show LotSN"; ShowLotSN)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Serial/Lot Number Appendix';
                        ToolTip = 'Specifies the Lot number /serial number to be displayed.';
                    }
                    field("Display AsmInfo"; DisplayAssemblyInformation)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies that you want to display the assembly components';
                    }
                    field("Hide CompanyInfo"; HideCompanyInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Hide Company Info';
                        ToolTip = 'Specifies that the company data is to be "hidden" for printing';
                    }
                    field("Item PicturePrint"; ItemPicturePrint)
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
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        SalesSetup.Get();
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage() then
            InitLogInteraction();
        AsmHeaderExists := false;
    end;

    var
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        Item: Record Item;
        TempTrackingSpecBuffer: Record "Tracking Specification" temporary;
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        RespCenter: Record "Responsibility Center";
        TempLeBitPostedPSLongtextLine: Record "lbt Posted PS Longtext Line" temporary;
        ItemTrackingAppendix: Report "Item Tracking Appendix";
        Language: Codeunit Language;
        LeBitReportFunctions: Codeunit "lbt Report Functions";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[50];
        ReferenceText: Text[80];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        OutputNo: Integer;
        NoOfLoops: Integer;
        TrackingSpecCount: Integer;
        OldRefNo: Integer;
        OldNo: Code[20];
        CopyText: Text[30];
        ShowCustAddr: Boolean;
        DimText: Text;
        OldDimText: Text;
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        ShowCorrectionLines: Boolean;
        ShowLotSN: Boolean;
        ShowTotal: Boolean;
        ShowGroup: Boolean;
        TotalQty: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmHeaderExists: Boolean;
        LinNo: Integer;
        TitleLbl: Label 'Sales - Shipment %1', Comment = '%1 - Document No.';
        ShipmentNoCaptionLbl: Label 'Shipment No.';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        BilltoAddressCaptionLbl: Label 'Bill-to Address';
        QuantityCaptionLbl: Label 'Quantity';
        SerialNoCaptionLbl: Label 'Serial No.';
        LotNoCaptionLbl: Label 'Lot No.';
        DescriptionCaptionLbl: Label 'Description';
        NoCaptionLbl: Label 'No.';
        PageFromPageCaptionLbl: Label 'Page %1 of %2', Comment = '%1 - Current Page, %2 - Total Pages';
        FromCaptionLbl: Label 'from';
        DatumCaptionLbl: Label 'Date';
        PosNo_CaptionLbl: Label 'Pos.';
        UOM_CaptionLbl: Label 'Unit';
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
        ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report";
        OrderNoText: Text;
        Footer: Text;
        VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        DimLbl: Label '%1 - %2', Locked = true;
        CombinedDimLbl: Label '%1; %2 - %3', Locked = true;

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(5) <> '';
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean; NewShowLotSN: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        ShowCorrectionLines := NewShowCorrectionLines;
        ShowLotSN := NewShowLotSN;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure FormatAddressFields(SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        FormatAddr.GetCompanyAddr(SalesShipmentHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesShptShipTo(ShipToAddr, SalesShipmentHeader);
        ShowCustAddr := FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, SalesShipmentHeader);
    end;

    local procedure FormatDocumentFields(SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        FormatDocument.SetSalesPerson(SalesPurchPerson, SalesShipmentHeader."Salesperson Code", SalesPersonText);
        ReferenceText := FormatDocument.SetText(SalesShipmentHeader."Your Reference" <> '', CopyStr(SalesShipmentHeader.FIELDCAPTION("Your Reference"), 1, 80));
        OrderNoText := FormatDocument.SetText(SalesShipmentHeader."Order No." <> '', CopyStr(SalesShipmentHeader.FIELDCAPTION("Order No."), 1, 80));
    end;

    local procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PADSTR('', 2, ' '));
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
}


