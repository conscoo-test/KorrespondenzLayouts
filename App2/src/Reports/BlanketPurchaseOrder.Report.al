report 5272729 "lbt Blanket Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/BlanketPurchaseOrder.Report.rdlc';
    Caption = 'Blanket Purchase Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const("Blanket Order"));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Blanket Purchase Order';
            column(Footer; Footer) { }
            column(DocType_PurchHead; "Document Type")
            {
            }
            column(PurchHeadNo; "No.")
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
                    column(DocDate_PurchHdr; Format("Purchase Header"."Document Date", 0, 4))
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
                    column(PaytoVendNo_PurchHdrCaption; "Purchase Header".FieldCaption("Pay-to Vendor No."))
                    {
                    }
                    column(Blanket_Purchase_Order_No_Caption; Blanket_Purchase_Order_No_CaptionLbl)
                    {
                    }
                    column(DatumCaption; DatumCaptionLbl)
                    {
                    }
                    column(FromCaption; FromCaptionLbl)
                    {
                    }
                    column(NoCaption; NoCaptionLbl)
                    {
                    }
                    column(PagefromPageCaption; PagefromPageCaptionLbl)
                    {
                    }
                    column(PosNo_Caption; PosNo_CaptionLbl)
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
                    column(Purchase_Line__Quantity_Caption; "Purchase Line".FieldCaption(Quantity))
                    {
                    }
                    column(Purchase_Line__Description_Caption; "Purchase Line".FieldCaption(Description))
                    {
                    }
                    column(OurAccountNo_Vendor; Vendor."Our Account No.")
                    {
                    }
                    column(OurAccountNo_Vendor_Caption; Vendor.FieldCaption("Our Account No."))
                    {
                    }
                    column(VAT_Registration_No__Caption; VAT_Registration_No__CaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1_Number; DimensionLoop1.Number)
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

                            LeBitReportFunctions.GetDimTextFromDimSetEntry(DimSetEntry1, DimText, Continue);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.Break();
                        end;
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
                            PrintLongText.GetPrintText("Purchase Header", Enum::"lbt Position"::Header, TempBlobList);
                            if TempBlobList.IsEmpty() then
                                CurrReport.Break();
                            LBKopf.SetRange(Number, 1, TempBlobList.Count());
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break();
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(PurchaseLineType; Format("Purchase Line".Type, 0, 2))
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
                        column(Purchase_Line___Expected_Receipt_Date_; Format("Purchase Line"."Expected Receipt Date"))
                        {
                        }
                        column(Purchase_Line___Expected_Receipt_Date__Caption; Purchase_Line___Expected_Receipt_Date__CaptionLbl)
                        {
                        }
                        column(NewPageGroup; NewPageGroup)
                        {
                        }
                        column(PurchaseLineLeBitPrintoption; Format("Purchase Line"."lbt Printoption", 0, 2))
                        {
                        }
                        column(LeBitPosNo_PurchaseLine; "Purchase Line"."lbt Pos. No.")
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
                                PrintLongText.GetPrintText("Purchase Line", Enum::"lbt Position"::Longtext, TempBlobList);
                                if TempBlobList.IsEmpty() then
                                    CurrReport.Break();
                                LBLang.SetRange(Number, 1, TempBlobList.Count());
                            end;
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(DimensionLoop2_Number; DimensionLoop2.Number)
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

                                LeBitReportFunctions.GetDimTextFromDimSetEntry(DimSetEntry2, DimText, Continue);
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.Break();
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            IntVar: Integer;
                            TxtVar: Text;
                            Counter: Integer;
                        begin
                            if Number = 1 then
                                TempPurchLine.Find('-')
                            else
                                TempPurchLine.Next();
                            "Purchase Line" := TempPurchLine;

                            DimSetEntry2.SetRange("Dimension Set ID", "Purchase Line"."Dimension Set ID");

                            if TempPurchLine."lbt Printoption" = TempPurchLine."lbt Printoption"::"New Page" then
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

                            TempPurchLine.CalcFields("lbt Balance");
                            if TempPurchLine.Type = TempPurchLine.Type::Item then begin
                                Item.Get(TempPurchLine."No.");
                                ItemPictureExist := Item.Picture.Count() > 0;
                                if not ItemPicturePrint then
                                    ItemPictureExist := false;
                                TxtVar := CurrReport.ObjectId(false);
                                TxtVar := CopyStr(TxtVar, StrPos(TxtVar, ' '));
                                Evaluate(IntVar, TxtVar);
                                LeBitReportFunctions.GetParameterArry(ReportType::Purchase, IntVar, 2, "Purchase Header"."Language Code", "Purchase Line".RowID1(), '', "Purchase Line"."No.", InfoCaptionArry, InfoValueArry);
                                LeBitReportFunctions.GetItemUnitArry(2, "Purchase Line".RowID1(), '', "Purchase Header"."Language Code", ItemUnitCodeArry, ItemUnitDescriptionArry, ItemUnitQtyArry);
                                Counter := 0;
                                repeat
                                    Counter += 1;
                                until (ItemUnitCodeArry[Counter] = TempPurchLine."Unit of Measure Code") or
                                  (ItemUnitCodeArry[Counter] = '');
                                if ItemUnitCodeArry[Counter] <> '' then begin
                                    ItemUnitCodeArry[Counter] := '';
                                    ItemUnitDescriptionArry[Counter] := '';
                                    ItemUnitQtyArry[Counter] := '';
                                    CompressArray(ItemUnitCodeArry);
                                    CompressArray(ItemUnitDescriptionArry);
                                    CompressArray(ItemUnitQtyArry);
                                end;
                                if TempPurchLine."Description 2" <> '' then begin
                                    ItemUnitDescription := ItemUnitDescriptionArry[1];
                                    ItemUnitQty := ItemUnitQtyArry[1];
                                    ItemUnitCodeArry[1] := '';
                                    ItemUnitDescriptionArry[1] := '';
                                    ItemUnitQtyArry[1] := '';
                                    CompressArray(ItemUnitCodeArry);
                                    CompressArray(ItemUnitDescriptionArry);
                                    CompressArray(ItemUnitQtyArry);
                                end;
                                //zus?tzliche Infos
                                Counter := 0;
                                repeat
                                    Counter += 1;
                                until InfoCaptionArry[Counter] = '';
                                Counter -= 1;
                                if TempPurchLine."Vendor Item No." <> '' then begin
                                    Counter += 1;
                                    InfoCaptionArry[Counter] := Purchase_Line___Vendor_Item_No__CaptionLbl;
                                    InfoValueArry[Counter] := TempPurchLine."Vendor Item No.";
                                end;
                                /*
                                IF PurchLine."Expected Receipt Date" <> 0D THEN BEGIN
                                  Counter += 1;
                                  InfoCaptionArry[Counter] := Expected_DateCaptionLbl;
                                  InfoValueArry[Counter] := Format(PurchLine."Expected Receipt Date",0,4);
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
                            TempPurchLine.DeleteAll();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempPurchLine.Find('+');
                            while MoreLines and (TempPurchLine.Description = '') and (TempPurchLine."Description 2" = '') and
                                  (TempPurchLine."No." = '') and (TempPurchLine.Quantity = 0) and
                                  (TempPurchLine.Amount = 0)
                            do
                                MoreLines := TempPurchLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            TempPurchLine.SetRange("Line No.", 0, TempPurchLine."Line No.");
                            SetRange(Number, 1, TempPurchLine.Count());
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                        column(ShipmentMethod_Description; ShipmentMethod.Description)
                        {
                        }
                        column(ShipmentMethod_DescriptionCaption; ShipmentMethod_DescriptionCaptionLbl)
                        {
                        }
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                        column(Purchase_Header___Buy_from_Vendor_No__; "Purchase Header"."Buy-from Vendor No.")
                        {
                        }
                        column(Purchase_Header___Buy_from_Vendor_No__Caption; "Purchase Header".FieldCaption("Buy-from Vendor No."))
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
                        DataItemTableView = sorting(Number) where(Number = const(1));
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
                        column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
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
                            PrintLongText.GetPrintText("Purchase Header", Enum::"lbt Position"::Footer, TempBlobList);
                            if TempBlobList.IsEmpty() then
                                CurrReport.Break();
                            LBFuss.SetRange(Number, 1, TempBlobList.Count());
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(TempPurchLine);
                    Clear(PurchPost);
                    TempPurchLine.DeleteAll();
                    PurchPost.GetPurchLines("Purchase Header", TempPurchLine, 0);

                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    end;

                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview() then
                        Codeunit.Run(Codeunit::"Purch.Header-Printed", "Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                    NewPageGroup := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := LanguageCU.GetLanguageIdOrDefault("Language Code");
                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");
                CompanyInfo."lbt SetReportFooter"(Footer);

                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");

                if not CurrReport.Preview() then begin
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        SegManagement.LogDocument(
                          11, "No.", "Doc. No. Occurrence", "No. of Archived Versions", Database::Vendor, "Pay-to Vendor No.",
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
                    field("No Of Copies"; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field("Show Internal Info"; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if the document shows internal information.';
                    }
                    field("Archive Document"; ArchiveDocument)
                    {
                        ApplicationArea = All;
                        Caption = 'Archive Document';
                        ToolTip = 'Specifies if the document is archived after you preview or print it.';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field("Log Interaction"; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                        Enabled = LogInteractionEnable;
                    }
                    field("Hide Company Info"; HideCompanyInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Hide Company Info';
                        ToolTip = ' Specifies that the company data is to be "hidden" for printing';
                    }
                    field("Item Picture Print"; ItemPicturePrint)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Item Picture';
                        ToolTip = 'Specifies that the article images are printed ';
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
            ArchiveDocument := PurchSetup."Archive Blanket Orders";
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Purch. Blnkt. Ord.") <> '';

            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        PurchSetup.Get();
        FormatDocument.SetLogoPosition(PurchSetup."lbt Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    var
        ShipmentMethod: Record "Shipment Method";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        TempPurchLine: Record "Purchase Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        PurchSetup: Record "Purchases & Payables Setup";
        Item: Record Item;
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        Vendor: Record Vendor;
        LanguageCU: Codeunit Language;
        PurchPost: Codeunit "Purch.-Post";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        LeBitReportFunctions: Codeunit "lbt Report Functions";
        PrintLongText: Codeunit "lbt cl Print Longtext";
        TempBlobList: Codeunit "Temp Blob List";
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        PurchaserText: Text[50];
        VATNoText: Text;
        ReferenceText: Text;
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text;
        DimText: Text[120];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        OutputNo: Integer;
        [InDataSet]
        LogInteractionEnable: Boolean;
        Blanket_Purchase_Order_No_CaptionLbl: Label 'Blanket Order No.';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Purchase_Line___Expected_Receipt_Date__CaptionLbl: Label 'Expected Date';
        Purchase_Line___Vendor_Item_No__CaptionLbl: Label 'No.';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method';
        Ship_to_AddressCaptionLbl: Label 'Ship-to Address';
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
        DocCaptionLbl: Label 'Blanket Purchase Order %1', Comment = '%1 - Document No.';
        PagefromPageCaptionLbl: Label 'Page %1 of %2', Comment = '%1 - Current Page, %2 - Total Pages';
        FromCaptionLbl: Label 'from';
        DatumCaptionLbl: Label 'Date';
        NoCaptionLbl: Label 'No.';
        PosNo_CaptionLbl: Label 'Pos.';
        UOM_CaptionLbl: Label 'Unit';
        PurchPersonText_CaptionLbl: Label 'Salesperson';
        Alternativposition_CaptionLbl: Label 'Alternative position';
        Bedarfposition_CaptionLbl: Label 'Position requirements';
        BitteAndern_CaptionLbl: Label 'please change!';
        ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report";
        VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        VendSource: Option Default,"Pay-to Vendor","Buy-from Vendor";
        Footer: Text;

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
        GetVendSource();
        case VendSource of
            VendSource::Default, VendSource::"Pay-to Vendor":
                begin
                    FormatAddr.PurchHeaderPayTo(VendAddr, PurchaseHeader);
                    Vendor.Get("Purchase Header"."Pay-to Vendor No.");
                end;
            VendSource::"Buy-from Vendor":
                begin
                    FormatAddr.PurchHeaderBuyFrom(VendAddr, PurchaseHeader);
                    Vendor.Get("Purchase Header"."Buy-from Vendor No.");
                end;
        end;
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
        Clear(CompanyAddressLine);

        for i := 1 to 6 do
            if CompanyAddr[i] <> '' then begin
                if CompanyAddressLine <> '' then
                    CompanyAddressLine := CompanyAddressLine + ', ';
                CompanyAddressLine := CompanyAddressLine + CompanyAddr[i];
            end;
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchaseHeader."Purchaser Code", PurchaserText);
        FormatDocument.SetShipmentMethod(ShipmentMethod, PurchaseHeader."Shipment Method Code", PurchaseHeader."Language Code");
        ReferenceText := FormatDocument.SetText(PurchaseHeader."Your Reference" <> '', CopyStr(PurchaseHeader.FieldCaption("Your Reference"), 1, 80));
        VATNoText := FormatDocument.SetText(PurchaseHeader."VAT Registration No." <> '', CopyStr(PurchaseHeader.FieldCaption("VAT Registration No."), 1, 80));
        if PurchaserText <> '' then
            PurchaserText := PurchPersonText_CaptionLbl;
    end;

    local procedure GetVendSource()
    var
        TypeVar: Option Sales,Purchase;
        RepType: Option " ","Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order","Purchase Quote","Purchase Order","Blanket Purchase Order";
    begin
        LeBitReportFunctions.GetSourceType(TypeVar::Purchase, RepType::"Blanket Purchase Order", VendSource);
    end;

    local procedure DocumentCaption(): Text
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption("Purchase Header", DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);
        exit(DocCaptionLbl);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(PurchaseHeader: Record "Purchase Header"; var DocCaption: Text);
    begin
    end;
}



