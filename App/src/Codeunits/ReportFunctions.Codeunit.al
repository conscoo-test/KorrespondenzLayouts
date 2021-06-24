codeunit 5272724 "lbt Report Functions"
{
    // version LBCOR1.00


    trigger OnRun()
    begin
    end;

    var
        "Object": Record AllObj;
        UseFilter: Option SETRANGE,SETFILTER;

    procedure GetParameterArry(ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report"; ReportID: Integer; ParaType: Integer; LanguageCode: Code[10]; RowID: Text[250]; LotNo: Code[20]; ItemNo: Code[20]; var Description: array[99] of Text; var Value: array[99] of Text)
    var
        ParamSetupRecRef: RecordRef;
        Counter: Integer;
        IntVar: Integer;
    begin
        ParamSetupRecRef.OPEN(Database::"LBT Report - Attribute Setup");

        SetFilterRecRef(ParamSetupRecRef, 1, 5, UseFilter::SETRANGE);
        SetFilterRecRef(ParamSetupRecRef, 2, ReportID, UseFilter::SETRANGE);
        if not ParamSetupRecRef.FindSet() then begin
            ParamSetupRecRef.Reset();
            SetFilterRecRef(ParamSetupRecRef, 1, ReportType, UseFilter::SETRANGE);
        end;

        if not ParamSetupRecRef.FindFirst() then
            exit;

        repeat
            Counter += 1;
        until (Description[Counter] = '');
        Counter -= 1;

        repeat
            Counter += 1;
            EVALUATE(IntVar, GetValueRecRef(ParamSetupRecRef, 3));
            Description[Counter] := GetParameterDescription(ReportType, ReportID, IntVar, ParaType, LanguageCode, RowID, LotNo);
            Value[Counter] := GetParameterValue(ReportType, ReportID, IntVar, ParaType, LanguageCode, RowID, LotNo, ItemNo);
            if Value[Counter] = '' then begin
                Description[Counter] := '';
                Counter -= 1;
            end;
        until ParamSetupRecRef.Next() = 0;
    end;

    procedure GetParameterDescription(ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report"; ReportID: Integer; Pos: Integer; ParaType: Integer; LanguageCode: Code[10]; RowID: Text[250]; LotNo: Code[20]) ParaDescriptionList: Text[1000]
    var
        ItemAttribute: Record "Item Attribute";
        ItemAttributeTranslation: Record "Item Attribute Translation";
        ParamSetupRecRef: RecordRef;
        StrArray: array[6] of Text[100];
        ParameterDescription: Text;
        Counter: Integer;
    begin
        // Ermittlung der Beschreibung, der zu druckenenden Parameter
        // Return eines Strings (wenn Sprachcode hinterlegt, mit Übersetzung)


        // Tabellen Filter wird definiert
        ParameterDescription := '';
        ParaDescriptionList := '';

        CLEAR(ParamSetupRecRef);
        ParamSetupRecRef.OPEN(Database::"LBT Report - Attribute Setup");

        SetFilterRecRef(ParamSetupRecRef, 1, 5, UseFilter::SETRANGE);
        SetFilterRecRef(ParamSetupRecRef, 2, ReportID, UseFilter::SETRANGE);
        if not ParamSetupRecRef.FindSet() then begin
            ParamSetupRecRef.Reset();
            SetFilterRecRef(ParamSetupRecRef, 1, ReportType, UseFilter::SETRANGE);
        end;

        // Trennung der übergebenen ROWID in ein Array
        FragmentRowID(RowID, StrArray);

        // Die zu druckende Position filtern
        SetFilterRecRef(ParamSetupRecRef, 3, Pos, UseFilter::SETRANGE);
        if not ParamSetupRecRef.FindFirst() then
            exit('');

        // Gebuchter Beleg
        case ParaType of
            1:
            repeat
                if ParaDescriptionList <> '' then
                    ParaDescriptionList += ' ';
                Counter += 1;

                if ItemAttributeTranslation.GET(GetValueRecRef(ParamSetupRecRef, 5), LanguageCode) then
                    ParameterDescription := ItemAttributeTranslation.Name
                else
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef, 5)) then
                        ParameterDescription := ItemAttribute.Name;

                ParaDescriptionList += ParameterDescription;
                if GetValueRecRef(ParamSetupRecRef, 8) <> '' then
                    ParaDescriptionList += ' ' + GetValueRecRef(ParamSetupRecRef, 8);
            until ParamSetupRecRef.Next() = 0;

            // Ungebuchter Beleg
            2:

            repeat
                if ParaDescriptionList <> '' then
                    ParaDescriptionList += ' ';
                Counter += 1;
                if ItemAttributeTranslation.GET(GetValueRecRef(ParamSetupRecRef, 5), LanguageCode) then
                    ParameterDescription := ItemAttributeTranslation.Name
                else
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef, 5)) then
                        ParameterDescription := ItemAttribute.Name;
                ParaDescriptionList += ParameterDescription;
                if GetValueRecRef(ParamSetupRecRef, 8) <> '' then
                    ParaDescriptionList += ' ' + GetValueRecRef(ParamSetupRecRef, 8);
            until ParamSetupRecRef.Next() = 0;

            3:

            repeat
                if ParaDescriptionList <> '' then
                    ParaDescriptionList += ' ';
                Counter += 1;
                if ItemAttributeTranslation.GET(GetValueRecRef(ParamSetupRecRef, 5), LanguageCode) then
                    ParameterDescription := ItemAttributeTranslation.Name
                else
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef, 5)) then
                        ParameterDescription := ItemAttribute.Name;
                ParaDescriptionList += ParameterDescription;
                if GetValueRecRef(ParamSetupRecRef, 8) <> '' then
                    ParaDescriptionList += ' ' + GetValueRecRef(ParamSetupRecRef, 8);
            until ParamSetupRecRef.Next() = 0;

            4:

            repeat
                if ParaDescriptionList <> '' then
                    ParaDescriptionList += ' ';
                Counter += 1;
                if ItemAttributeTranslation.GET(GetValueRecRef(ParamSetupRecRef, 5), LanguageCode) then
                    ParameterDescription := ItemAttributeTranslation.Name
                else
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef, 5)) then
                        ParameterDescription := ItemAttribute.Name;
                ParaDescriptionList += ParameterDescription;
                if GetValueRecRef(ParamSetupRecRef, 8) <> '' then
                    ParaDescriptionList += ' ' + GetValueRecRef(ParamSetupRecRef, 8);
            until ParamSetupRecRef.Next() = 0;

            // Archivierter Beleg
            5:

            repeat
                if ParaDescriptionList <> '' then
                    ParaDescriptionList += ' ';
                Counter += 1;
                if ItemAttributeTranslation.GET(GetValueRecRef(ParamSetupRecRef, 5), LanguageCode) then
                    ParameterDescription := ItemAttributeTranslation.Name
                else
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef, 5)) then
                        ParameterDescription := ItemAttribute.Name;
                ParaDescriptionList += ParameterDescription;
                if GetValueRecRef(ParamSetupRecRef, 8) <> '' then
                    ParaDescriptionList += ' ' + GetValueRecRef(ParamSetupRecRef, 8);
            until ParamSetupRecRef.Next() = 0;

        end;
    end;

    procedure GetParameterValue(ReportType: Integer; ReportID: Integer; Pos: Integer; ParaType: Integer; LanguageCode: Code[10]; RowID: Text[250]; LotNo: Code[20]; ItemNo: Code[20]) ParaValueList: Text
    var
        UnitofMeasureRec: Record "Unit of Measure";
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemAttrValueTranslation: Record "Item Attr. Value Translation";
        ItemAttributeValue: Record "Item Attribute Value";
        ItemAttribute: Record "Item Attribute";
        UnitofMeasureTranslationRec: Record "Unit of Measure Translation";
        ParamSetupRecRef: RecordRef;
        StrArray: array[6] of Text[100];
        UnitofMeasureDescription: Text;
        localUseFilter: Option SETRANGE,SETFILTER;
        Counter: Integer;
    begin
        // Ermittlung der Werte, der zu druckenden Parameter
        // Return eines Strings (wenn Sprachcode hinterlegt, mit Übersetzung)


        ParaValueList := '';

        // Tabellen Filter wird definiert
        CLEAR(ParamSetupRecRef);
        ParamSetupRecRef.OPEN(Database::"LBT Report - Attribute Setup");

        SetFilterRecRef(ParamSetupRecRef, 1, 5, localUseFilter::SETRANGE);
        SetFilterRecRef(ParamSetupRecRef, 2, ReportID, localUseFilter::SETRANGE);
        if not ParamSetupRecRef.FindSet() then begin
            ParamSetupRecRef.Reset();
            SetFilterRecRef(ParamSetupRecRef, 1, ReportType, localUseFilter::SETRANGE);
        end;

        // Trennung der übergebenen ROWID in ein Array
        FragmentRowID(RowID, StrArray);

        // Die zu druckende Position filtern
        SetFilterRecRef(ParamSetupRecRef, 3, Pos, localUseFilter::SETRANGE);
        if not ParamSetupRecRef.FindFirst() then
            exit('');

        // Gebuchter Beleg
        case ParaType of
            1:

            repeat
                if ParaValueList <> '' then
                    ParaValueList += ' ';
                Counter += 1;
                if ItemAttributeValueMapping.GET(DATABASE::Item, ItemNo, GetValueRecRef(ParamSetupRecRef, 5)) then begin
                    if ItemAttrValueTranslation.GET(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID", LanguageCode) then
                        ParaValueList += ItemAttrValueTranslation.Name
                    else
                        if ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID") then
                            ParaValueList += ItemAttributeValue.Value;

                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef, 5)) then
                        if UnitofMeasureTranslationRec.GET(ItemAttribute."Unit of Measure", LanguageCode) then
                            UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                        else
                            if UnitofMeasureRec.GET(ItemAttribute."Unit of Measure") then
                                UnitofMeasureDescription := UnitofMeasureRec.Description;


                end;

                if UnitofMeasureDescription <> '' then
                    ParaValueList += ' ' + UnitofMeasureDescription;
                if GetValueRecRef(ParamSetupRecRef, 8) <> '' then
                    ParaValueList += ' ' + GetValueRecRef(ParamSetupRecRef, 8);
            until ParamSetupRecRef.Next() = 0;

            2:

            // Ungebuchter Beleg
            repeat
                if ParaValueList <> '' then
                    ParaValueList += ' ';
                Counter += 1;
                if ItemAttributeValueMapping.GET(DATABASE::Item, ItemNo, GetValueRecRef(ParamSetupRecRef, 5)) then begin
                    if ItemAttrValueTranslation.GET(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID", LanguageCode) then
                        ParaValueList += ItemAttrValueTranslation.Name
                    else
                        if ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID") then
                            ParaValueList += ItemAttributeValue.Value;

                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef, 5)) then
                        if UnitofMeasureTranslationRec.GET(ItemAttribute."Unit of Measure", LanguageCode) then
                            UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                        else
                            if UnitofMeasureRec.GET(ItemAttribute."Unit of Measure") then
                                UnitofMeasureDescription := UnitofMeasureRec.Description;


                end;

                if UnitofMeasureDescription <> '' then
                    ParaValueList += ' ' + UnitofMeasureDescription;
                if GetValueRecRef(ParamSetupRecRef, 8) <> '' then
                    ParaValueList += ' ' + GetValueRecRef(ParamSetupRecRef, 8);
            until ParamSetupRecRef.Next() = 0;

            // Assign
            3:

            repeat
                if ParaValueList <> '' then
                    ParaValueList += ' ';
                Counter += 1;
                if ItemAttributeValueMapping.GET(DATABASE::Item, ItemNo, GetValueRecRef(ParamSetupRecRef, 5)) then begin
                    if ItemAttrValueTranslation.GET(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID", LanguageCode) then
                        ParaValueList += ItemAttrValueTranslation.Name
                    else
                        if ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID") then
                            ParaValueList += ItemAttributeValue.Value;

                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef, 5)) then
                        if UnitofMeasureTranslationRec.GET(ItemAttribute."Unit of Measure", LanguageCode) then
                            UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                        else
                            if UnitofMeasureRec.GET(ItemAttribute."Unit of Measure") then
                                UnitofMeasureDescription := UnitofMeasureRec.Description;


                end;
                if UnitofMeasureDescription <> '' then
                    ParaValueList += ' ' + UnitofMeasureDescription;
                if GetValueRecRef(ParamSetupRecRef, 8) <> '' then
                    ParaValueList += ' ' + GetValueRecRef(ParamSetupRecRef, 8);
            until ParamSetupRecRef.Next() = 0;

            4:

            repeat
                if ParaValueList <> '' then
                    ParaValueList += ' ';
                Counter += 1;
                if ItemAttributeValueMapping.GET(DATABASE::Item, ItemNo, GetValueRecRef(ParamSetupRecRef, 5)) then begin
                    if ItemAttrValueTranslation.GET(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID", LanguageCode) then
                        ParaValueList += ItemAttrValueTranslation.Name
                    else
                        if ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID") then
                            ParaValueList += ItemAttributeValue.Value;

                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef, 5)) then
                        if UnitofMeasureTranslationRec.GET(ItemAttribute."Unit of Measure", LanguageCode) then
                            UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                        else
                            if UnitofMeasureRec.GET(ItemAttribute."Unit of Measure") then
                                UnitofMeasureDescription := UnitofMeasureRec.Description;

                end;
                if UnitofMeasureDescription <> '' then
                    ParaValueList += ' ' + UnitofMeasureDescription;
                if GetValueRecRef(ParamSetupRecRef, 8) <> '' then
                    ParaValueList += ' ' + GetValueRecRef(ParamSetupRecRef, 8);
            until ParamSetupRecRef.Next() = 0;

            5:

            // Archivierter Beleg
            repeat
                if ParaValueList <> '' then
                    ParaValueList += ' ';
                Counter += 1;
                if ItemAttributeValueMapping.GET(DATABASE::Item, ItemNo, GetValueRecRef(ParamSetupRecRef, 5)) then begin
                    if ItemAttrValueTranslation.GET(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID", LanguageCode) then
                        ParaValueList += ItemAttrValueTranslation.Name
                    else
                        if ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID") then
                            ParaValueList += ItemAttributeValue.Value;

                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef, 5)) then
                        if UnitofMeasureTranslationRec.GET(ItemAttribute."Unit of Measure", LanguageCode) then
                            UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                        else
                            if UnitofMeasureRec.GET(ItemAttribute."Unit of Measure") then
                                UnitofMeasureDescription := UnitofMeasureRec.Description;

                end;
                if UnitofMeasureDescription <> '' then
                    ParaValueList += ' ' + UnitofMeasureDescription;
                if GetValueRecRef(ParamSetupRecRef, 8) <> '' then
                    ParaValueList += ' ' + GetValueRecRef(ParamSetupRecRef, 8);
            until ParamSetupRecRef.Next() = 0;

        end;
    end;

    procedure GetItemUnitArry(ItemUnitType: Integer; RowID: Text[250]; LotNo: Code[20]; LanguageCode: Code[10]; var ItemUnitCode: array[50] of Code[20]; var ItemUnitDescription: array[50] of Text; var ItemUnitQty: array[50] of Text)
    var
        UnitofMeasure: Record "Unit of Measure";
        UnitofMeasureTranslation: Record "Unit of Measure Translation";
        RecordRef: RecordRef;
        Counter: Integer;
        StrArray: array[6] of Text[100];
    begin
        // Trennung der übergebenen ROWID in ein Array
        FragmentRowID(RowID, StrArray);

        //Prüfung auf vorhandene Tabelle
        case ItemUnitType of
            // Gebuchter Beleg
            1:
                begin
                    Object.SETRANGE("Object Type", Object."Object Type"::Table);
                    Object.SETRANGE("Object ID", 5077965);
                    if not Object.FindSet() then
                        exit;
                end;
            // Ungebuchter Beleg
            2:
                begin
                    Object.SETRANGE("Object Type", Object."Object Type"::Table);
                    Object.SETRANGE("Object ID", 5077957);
                    if not Object.FindSet() then
                        exit;
                end;
        end;

        CLEAR(RecordRef);
        case ItemUnitType of
            1:
                RecordRef.OPEN(5077965);
            2:
                RecordRef.OPEN(5077957);
        end;
        SetFilterRecRef(RecordRef, 1, StrArray[1], UseFilter::SETFILTER);   //"Table ID"
        SetFilterRecRef(RecordRef, 2, StrArray[2], UseFilter::SETFILTER);   //"Document Type"
        SetFilterRecRef(RecordRef, 3, StrArray[3], UseFilter::SETRANGE);    //"Document No."
        SetFilterRecRef(RecordRef, 9, StrArray[4], UseFilter::SETFILTER);   //"Document No. 2"
        SetFilterRecRef(RecordRef, 4, StrArray[6], UseFilter::SETFILTER);   //"Document Line No."
        SetFilterRecRef(RecordRef, 12, LotNo, UseFilter::SETRANGE);         //"Lot No."
        SetFilterRecRef(RecordRef, 20, true, UseFilter::SETRANGE);          //Print
        if RecordRef.FindSet() then
            repeat
                Counter += 1;
                ItemUnitCode[Counter] := CopyStr(GetValueRecRef(RecordRef, 5), 1, 20);
                if UnitofMeasureTranslation.GET(ItemUnitCode[Counter], LanguageCode) then
                    ItemUnitDescription[Counter] := UnitofMeasureTranslation.Description
                else
                    if UnitofMeasure.GET(ItemUnitCode[Counter]) then
                        ItemUnitDescription[Counter] := UnitofMeasure.Description;

                //EVALUATE(DecVar,GetValueRecRef(RecordRef,7));
                ItemUnitQty[Counter] := GetValueRecRef(RecordRef, 7);
            until RecordRef.Next() = 0;

    end;

    procedure SetFilterRecRef(var RecRef_L: RecordRef; FieldID: Integer; FieldFilter: Variant; UseFilter_L: Option SETRANGE,SETFILTER)
    var
        FieldRef_L: FieldRef;
    begin
        FieldRef_L := RecRef_L.FIELD(FieldID);
        case UseFilter_L of
            UseFilter_L::SETFILTER:
                FieldRef_L.SETFILTER(FieldFilter);
            UseFilter_L::SETRANGE:
                FieldRef_L.SETRANGE(FieldFilter);
        end;
    end;

    procedure GetValueRecRef(var RecRef_L: RecordRef; FieldID: Integer) TextVar: Text
    var
        FieldRef_L: FieldRef;
    begin
        FieldRef_L := RecRef_L.FIELD(FieldID);
        TextVar := FORMAT(FieldRef_L.Value());
        exit(TextVar);
    end;

    procedure FragmentRowID(IDtext: Text[250]; var StrArray: array[6] of Text[100])
    var
        Len: Integer;
        Pos: Integer;
        ArrayIndex: Integer;
        "Count": Integer;
        Char: Text[1];
        NoWriteSinceLastNext: Boolean;
        Write: Boolean;
        Next: Boolean;
    begin
        // Funktion zum Splitten der Rowid

        for ArrayIndex := 1 to 6 do
            StrArray[ArrayIndex] := '';
        Len := STRLEN(IDtext);
        Pos := 1;
        ArrayIndex := 1;

        while not (Pos > Len) do begin
            Char := COPYSTR(IDtext, Pos, 1);
            if (Char = '"') then begin
                Write := false;
                Count += 1;
            end else begin
                if Count = 0 then
                    Write := true
                else begin
                    if Count mod 2 = 1 then begin
                        Next := (Char = ';');
                        Count -= 1;
                    end else
                        if NoWriteSinceLastNext and (Char = ';') then begin
                            Count -= 2;
                            Next := true;
                        end;
                    Count /= 2;
                    while Count > 0 do begin
                        StrArray[ArrayIndex] += '"';
                        Count -= 1;
                    end;
                    Write := not Next;
                end;
                NoWriteSinceLastNext := Next;
            end;

            if Next then begin
                ArrayIndex += 1;
                Next := false
            end;

            if Write then
                StrArray[ArrayIndex] += Char;
            Pos += 1;
        end;
    end;


    procedure RowID1ForSalesShipmentLine(SalesShipmentLine: Record "Sales Shipment Line"): Text[250]
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        exit(ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Shipment Line",
          0, SalesShipmentLine."Document No.", '', 0, SalesShipmentLine."Line No."));
    end;

    procedure GetSourceType(TypeVar: Option Sales,Purchase; ReportType: Option General,"Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order","Purchase Quote","Purchase Order","Blanket Purchase Order"; var SourceType: Option)
    var
        LebitSourceSetup: Record "lbt Source Setup";
    begin
        LebitSourceSetup.SETRANGE(Type, TypeVar);
        LebitSourceSetup.SETRANGE("Report Type", ReportType);
        if LebitSourceSetup.IsEmpty() then
            LebitSourceSetup.SETRANGE("Report Type", LebitSourceSetup."Report Type"::General);
        if not LebitSourceSetup.FindFirst() then
            SourceType := 0
        else
            case LebitSourceSetup.Type of
                LebitSourceSetup.Type::Sales:
                    case LebitSourceSetup."Source Type" of
                        LebitSourceSetup."Source Type"::Default:
                            SourceType := 0;
                        LebitSourceSetup."Source Type"::"Bill-to Customer":
                            SourceType := 1;
                        LebitSourceSetup."Source Type"::"Sell-to Customer":
                            SourceType := 2;
                    end;
                LebitSourceSetup.Type::Purchase:
                    case LebitSourceSetup."Source Type" of
                        LebitSourceSetup."Source Type"::Default:
                            SourceType := 0;
                        LebitSourceSetup."Source Type"::"Pay-to Vendor":
                            SourceType := 1;
                        LebitSourceSetup."Source Type"::"Buy-from Vendor":
                            SourceType := 2;
                    end;
            end;

    end;

    procedure GetDimTextFromDimSetEntry(var DimSetEntry: Record "Dimension Set Entry"; var DimText: Text[120]; var Continue: Boolean)
    var
        DimensionCodeAndValueTok: Label '%1 - %2', Locked = true;
        DimensionAndDimensionCodeAndValueTok: Label '%1; %2 - %3', Locked = true;

        OldDimText: Text[75];
    begin
        CLEAR(DimText);
        Continue := false;
        repeat
            OldDimText := DimText;
            if DimText = '' then
                DimText := STRSUBSTNO(DimensionCodeAndValueTok, DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
            else
                DimText :=
                  STRSUBSTNO(
                    DimensionAndDimensionCodeAndValueTok, DimText,
                    DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
            if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                DimText := OldDimText;
                Continue := true;
                exit;
            end;
        until DimSetEntry.Next() = 0;
    end;
}

