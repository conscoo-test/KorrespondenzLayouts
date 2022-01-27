codeunit 5272724 "lbt Report Functions"
{
    procedure GetParameterArry(ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report"; ReportID: Integer; ParaType: Integer; LanguageCode: Code[10]; RowID: Text[250]; LotNo: Code[20]; ItemNo: Code[20]; var Description: array[99] of Text; var Value: array[99] of Text)
    var
        ReportAttributeSetup: Record "lbt Report - Attribute Setup";
        Counter: Integer;
    begin
        ReportAttributeSetup.SetRange("Report-Type", ReportAttributeSetup."Report-Type"::Report);
        ReportAttributeSetup.SetRange("Report-ID", ReportID);
        if ReportAttributeSetup.IsEmpty() then begin
            ReportAttributeSetup.Reset();
            ReportAttributeSetup.SetRange("Report-Type", ReportType);
        end;

        if not ReportAttributeSetup.FindSet() then
            exit;

        repeat
            Counter += 1;
        until (Description[Counter] = '');
        Counter -= 1;

        repeat
            Counter += 1;
            Description[Counter] := GetParameterDescription(ReportAttributeSetup, LanguageCode);
            Value[Counter] := GetParameterValue(ReportAttributeSetup, ItemNo, LanguageCode);
            if Value[Counter] = '' then begin
                Description[Counter] := '';
                Counter -= 1;
            end;
        until ReportAttributeSetup.Next() = 0;
    end;

    procedure GetItemUnitArry(ItemUnitType: Integer; RowID: Text[250]; LotNo: Code[20]; LanguageCode: Code[10]; var ItemUnitCode: array[50] of Code[20]; var ItemUnitDescription: array[50] of Text; var ItemUnitQty: array[50] of Text)
    var
        Handled: Boolean;
    begin

        OnBeforeGetItemUnitArray(ItemUnitType, RowID, LotNo, LanguageCode, ItemUnitCode, ItemUnitDescription, ItemUnitQty, Handled);
        if Handled then
            exit;
        GetItemUnitArryOld(ItemUnitType, RowID, LotNo, LanguageCode, ItemUnitCode, ItemUnitDescription, ItemUnitQty);
    end;
#pragma warning disable AA0137
    local procedure GetItemUnitArryOld(ItemUnitType: Integer; RowID: Text[250]; LotNo: Code[20]; LanguageCode: Code[10]; var ItemUnitCode: array[50] of Code[20]; var ItemUnitDescription: array[50] of Text; var ItemUnitQty: array[50] of Text)
#pragma warning restore AA0137
    var
    // UnitofMeasure: Record "Unit of Measure";
    // UnitofMeasureTranslation: Record "Unit of Measure Translation";
    // RecordRef: RecordRef;
    // Counter: Integer;
    // StrArray: array[6] of Text[100];
    begin
        // // Trennung der übergebenen ROWID in ein Array
        // FragmentRowID(RowID, StrArray);

        // //Prüfung auf vorhandene Tabelle
        // case ItemUnitType of
        //     // Gebuchter Beleg
        //     1:
        //         begin
        //             AllObj.SetRange("Object Type", AllObj."Object Type"::Table);
        //             AllObj.SetRange("Object ID", 5077965);
        //             if not AllObj.FindSet() then
        //                 exit;
        //         end;
        //     // Ungebuchter Beleg
        //     2:
        //         begin
        //             AllObj.SetRange("Object Type", AllObj."Object Type"::Table);
        //             AllObj.SetRange("Object ID", 5077957);
        //             if not AllObj.FindSet() then
        //                 exit;
        //         end;
        // end;

        // Clear(RecordRef);
        // case ItemUnitType of
        //     1:
        //         RecordRef.Open(5077965);
        //     2:
        //         RecordRef.Open(5077957);
        // end;
        // SetFilterRecRef(RecordRef, 1, StrArray[1], UseFilter::SETFILTER);   //"Table ID"
        // SetFilterRecRef(RecordRef, 2, StrArray[2], UseFilter::SETFILTER);   //"Document Type"
        // SetFilterRecRef(RecordRef, 3, StrArray[3], UseFilter::SETRANGE);    //"Document No."
        // SetFilterRecRef(RecordRef, 9, StrArray[4], UseFilter::SETFILTER);   //"Document No. 2"
        // SetFilterRecRef(RecordRef, 4, StrArray[6], UseFilter::SETFILTER);   //"Document Line No."
        // SetFilterRecRef(RecordRef, 12, LotNo, UseFilter::SETRANGE);         //"Lot No."
        // SetFilterRecRef(RecordRef, 20, true, UseFilter::SETRANGE);          //Print
        // if RecordRef.FindSet() then
        //     repeat
        //         Counter += 1;
        //         ItemUnitCode[Counter] := CopyStr(GetValueRecRef(RecordRef, 5), 1, 20);
        //         if UnitofMeasureTranslation.Get(ItemUnitCode[Counter], LanguageCode) then
        //             ItemUnitDescription[Counter] := UnitofMeasureTranslation.Description
        //         else
        //             if UnitofMeasure.Get(ItemUnitCode[Counter]) then
        //                 ItemUnitDescription[Counter] := UnitofMeasure.Description;

        //         //Evaluate(DecVar,GetValueRecRef(RecordRef,7));
        //         ItemUnitQty[Counter] := GetValueRecRef(RecordRef, 7);
        //     until RecordRef.Next() = 0;

    end;

    local procedure GetSourceTypeSales(var SourceType: Option; var SourceSetup: Record "lbt Source Setup")
    begin
        case SourceSetup."Source Type" of
            SourceSetup."Source Type"::Default:
                SourceType := 0;
            SourceSetup."Source Type"::"Bill-to Customer":
                SourceType := 1;
            SourceSetup."Source Type"::"Sell-to Customer":
                SourceType := 2;
        end;
    end;

    local procedure GetSourceTypePurchase(var SourceType: Option; var SourceSetup: Record "lbt Source Setup")
    begin
        case SourceSetup."Source Type" of
            SourceSetup."Source Type"::Default:
                SourceType := 0;
            SourceSetup."Source Type"::"Pay-to Vendor":
                SourceType := 1;
            SourceSetup."Source Type"::"Buy-from Vendor":
                SourceType := 2;
        end;
    end;

    local procedure AppendAdditionalCharacter(var ReportAttributeSetup: Record "lbt Report - Attribute Setup"; var ParaDescriptionList: Text)
    begin
        if ReportAttributeSetup."Additional Character" <> '' then
            ParaDescriptionList += ' ' + ReportAttributeSetup."Additional Character";
    end;

    local procedure GetUnitOfMeasureDescription(AttributeId: Integer; LanguageCode: Code[10]) UnitofMeasureDescription: Text
    var
        UnitofMeasure: Record "Unit of Measure";
        ItemAttribute: Record "Item Attribute";
        UnitofMeasureTranslation: Record "Unit of Measure Translation";
    begin
        if ItemAttribute.Get(AttributeId) then
            if UnitofMeasureTranslation.Get(ItemAttribute."Unit of Measure", LanguageCode) then
                UnitofMeasureDescription := UnitofMeasureTranslation.Description
            else
                if UnitofMeasure.Get(ItemAttribute."Unit of Measure") then
                    UnitofMeasureDescription := UnitofMeasure.Description;
    end;

    local procedure GetAttributeValueTranslation(AttributeId: Integer; AttributeValueId: Integer; LanguageCode: Code[10]): Text
    var
        ItemAttrValueTranslation: Record "Item Attr. Value Translation";
        ItemAttributeValue: Record "Item Attribute Value";
    begin
        if ItemAttrValueTranslation.Get(AttributeId, AttributeValueId, LanguageCode) then
            exit(ItemAttrValueTranslation.Name);
        if ItemAttributeValue.Get(AttributeId, AttributeValueId) then
            exit(ItemAttributeValue.Value);
    end;

    local procedure GetParameterDescription(var ReportAttributeSetup: Record "lbt Report - Attribute Setup"; LanguageCode: Code[10]) ParaDescriptionList: Text
    var
        ItemAttribute: Record "Item Attribute";
        Language: Codeunit Language;
        ParameterDescription: Text;
        LanguageId: Integer;
    begin
        LanguageId := Language.GetLanguageId(LanguageCode);
        if ItemAttribute.Get(ReportAttributeSetup.ID) then
            ParameterDescription := ItemAttribute.GetTranslatedName(LanguageId);

        ParaDescriptionList += ParameterDescription;
        AppendAdditionalCharacter(ReportAttributeSetup, ParaDescriptionList);
    end;

    local procedure GetParameterValue(ReportAttributeSetup: Record "lbt Report - Attribute Setup"; ItemNo: Code[20]; LanguageCode: Code[10]) ParaValueList: Text
    var
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        UnitofMeasureDescription: Text;
    begin
        if ItemAttributeValueMapping.Get(Database::Item, ItemNo, ReportAttributeSetup.ID) then begin
            ParaValueList += GetAttributeValueTranslation(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID", LanguageCode);
            UnitofMeasureDescription := GetUnitOfMeasureDescription(ReportAttributeSetup.ID, LanguageCode);
            if UnitofMeasureDescription <> '' then
                ParaValueList += ' ' + UnitofMeasureDescription;
        end;

        AppendAdditionalCharacter(ReportAttributeSetup, ParaValueList);
    end;

    procedure RowID1ForSalesShipmentLine(SalesShipmentLine: Record "Sales Shipment Line"): Text[250]
    var
        ItemTrackingManagement: Codeunit "Item Tracking Management";
    begin
        exit(ItemTrackingManagement.ComposeRowID(Database::"Sales Shipment Line",
          0, SalesShipmentLine."Document No.", '', 0, SalesShipmentLine."Line No."));
    end;

    procedure GetSourceType(TypeVar: Option Sales,Purchase; ReportType: Option General,"Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order","Purchase Quote","Purchase Order","Blanket Purchase Order"; var SourceType: Option)
    var
        SourceSetup: Record "lbt Source Setup";
    begin
        SourceSetup.SetRange(Type, TypeVar);
        SourceSetup.SetRange("Report Type", ReportType);
        if SourceSetup.IsEmpty() then
            SourceSetup.SetRange("Report Type", SourceSetup."Report Type"::General);
        if not SourceSetup.FindFirst() then begin
            SourceType := 0;
            exit;
        end;

        case SourceSetup.Type of
            SourceSetup.Type::Sales:
                GetSourceTypeSales(SourceType, SourceSetup);
            SourceSetup.Type::Purchase:
                GetSourceTypePurchase(SourceType, SourceSetup);
        end;

    end;

    procedure GetDimTextFromDimSetEntry(var DimSetEntry: Record "Dimension Set Entry"; var DimText: Text[120]; var Continue: Boolean)
    var
        DimensionCodeAndValueTok: Label '%1 - %2', Locked = true;
        DimensionAndDimensionCodeAndValueTok: Label '%1; %2 - %3', Locked = true;

        OldDimText: Text[75];
    begin
        Clear(DimText);
        Continue := false;
        repeat
            OldDimText := CopyStr(DimText, 1, MaxStrLen(OldDimText));
            if DimText = '' then
                DimText := StrSubstNo(DimensionCodeAndValueTok, DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
            else
                DimText :=
                  StrSubstNo(
                    DimensionAndDimensionCodeAndValueTok, DimText,
                    DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
            if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                DimText := OldDimText;
                Continue := true;
                exit;
            end;
        until DimSetEntry.Next() = 0;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetItemUnitArray(ItemUnitType: Integer; RowID: Text[250]; LotNo: Code[20]; LanguageCode: Code[10]; var ItemUnitCode: array[50] of Code[20]; var ItemUnitDescription: array[50] of Text; var ItemUnitQty: array[50] of Text; Handled: Boolean)
    begin
    end;
}

