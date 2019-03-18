codeunit 5272724 "LBT Report Functions"
{
    // version LBCOR1.00


    trigger OnRun()
    begin
    end;

    var
        "Object": Record "Object";
        UseFilter: Option SETRANGE,SETFILTER;

    procedure GetParameterArry(ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report";ReportID: Integer;ParaType: Integer;LanguageCode: Code[10];RowID: Text[250];LotNo: Code[20];ItemNo: Code[20];var Description: array [99] of Text;var Value: array [99] of Text)
    var
        ParameterTableExist: Boolean;
        ParamSetupRecRef: RecordRef;
        LeBiINSTSetupRecRef: RecordRef;
        Counter: Integer;
        IntVar: Integer;
    begin
        CLEAR(LeBiINSTSetupRecRef);
        Object.SETRANGE(Type,Object.Type::Table);
        Object.SETRANGE(ID,5102700);
        if Object.FINDSET then begin
          LeBiINSTSetupRecRef.OPEN(5102700);
          if LeBiINSTSetupRecRef.FINDFIRST then
            ParameterTableExist := true;
        end;

        CLEAR(ParamSetupRecRef);
        if ParameterTableExist then
          ParamSetupRecRef.OPEN(5077913)
        else
          ParamSetupRecRef.OPEN(5272725);

        SetFilterRecRef(ParamSetupRecRef,1,5,UseFilter::SETRANGE);
        SetFilterRecRef(ParamSetupRecRef,2,ReportID,UseFilter::SETRANGE);
        if not ParamSetupRecRef.FINDSET then begin
          ParamSetupRecRef.RESET;
          SetFilterRecRef(ParamSetupRecRef,1,ReportType,UseFilter::SETRANGE);
        end;

        if not ParamSetupRecRef.FINDFIRST then
          exit;

        repeat
          Counter += 1;
        until (Description[Counter] = '');
        Counter -= 1;

        repeat
          Counter += 1;
          EVALUATE(IntVar,GetValueRecRef(ParamSetupRecRef,3));
          Description[Counter] := GetParameterDescription(ReportType,ReportID,IntVar,ParaType,LanguageCode,RowID,LotNo);
          Value[Counter] := GetParameterValue(ReportType,ReportID,IntVar,ParaType,LanguageCode,RowID,LotNo,ItemNo);
          if Value[Counter]  = '' then begin
            Description[Counter] := '';
            Counter -= 1;
          end;
        until ParamSetupRecRef.NEXT = 0;
    end;

    procedure GetParameterDescription(ReportType: Option Purchase,Sales,QA,Production,Delivery,"Report";ReportID: Integer;Pos: Integer;ParaType: Integer;LanguageCode: Code[10];RowID: Text[250];LotNo: Code[20]) ParaDescriptionList: Text[1000]
    var
        StrArray: array [6] of Text[100];
        ParameterDescription: Text[50];
        ParaDocLineRecRef: RecordRef;
        ParaTranslationRecRef: RecordRef;
        ParaRecRef: RecordRef;
        ParaAssignRecRef: RecordRef;
        ParaEntryRecRef: RecordRef;
        ItemAttribute: Record "Item Attribute";
        ItemAttributeTranslation: Record "Item Attribute Translation";
        Counter: Integer;
        ParameterTableExist: Boolean;
        ParamSetupRecRef: RecordRef;
        LeBiINSTSetupRecRef: RecordRef;
    begin
        // Ermittlung der Beschreibung, der zu druckenenden Parameter
        // Return eines Strings (wenn Sprachcode hinterlegt, mit Übersetzung)

        CLEAR(LeBiINSTSetupRecRef);
        Object.SETRANGE(Type,Object.Type::Table);
        Object.SETRANGE(ID,5102700);
        if Object.FINDSET then begin
          LeBiINSTSetupRecRef.OPEN(5102700);
          if LeBiINSTSetupRecRef.FINDFIRST then
            ParameterTableExist := true;
        end;

        // Tabellen Filter wird definiert
        ParameterDescription := '';
        ParaDescriptionList := '';

        CLEAR(ParamSetupRecRef);
        if ParameterTableExist then
          ParamSetupRecRef.OPEN(5077913)
        else
          ParamSetupRecRef.OPEN(5272725);

        SetFilterRecRef(ParamSetupRecRef,1,5,UseFilter::SETRANGE);
        SetFilterRecRef(ParamSetupRecRef,2,ReportID,UseFilter::SETRANGE);
        if not ParamSetupRecRef.FINDSET then begin
          ParamSetupRecRef.RESET;
          SetFilterRecRef(ParamSetupRecRef,1,ReportType,UseFilter::SETRANGE);
        end;

        // Trennung der übergebenen ROWID in ein Array
        FragmentRowID(RowID,StrArray);

        // Die zu druckende Position filtern
        SetFilterRecRef(ParamSetupRecRef,3,Pos,UseFilter::SETRANGE);
        if not ParamSetupRecRef.FINDFIRST then
          exit('');

        // Gebuchter Beleg
        case ParaType of
          1:begin
              repeat
                if ParaDescriptionList <> '' then
                  ParaDescriptionList += ' ';
                Counter += 1;
                if not ParameterTableExist then begin
                  if ItemAttributeTranslation.GET(GetValueRecRef(ParamSetupRecRef,5),LanguageCode) then
                    ParameterDescription := ItemAttributeTranslation.Name
                  else
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef,5)) then
                      ParameterDescription := ItemAttribute.Name;
                end else begin
                  if Counter = 1 then begin
                    CLEAR(ParaDocLineRecRef);
                    ParaDocLineRecRef.OPEN(5078148);                                         //Posted Parameter Document Line
                    SetFilterRecRef(ParaDocLineRecRef,1,StrArray[1],UseFilter::SETFILTER);   //"Table ID"
                    SetFilterRecRef(ParaDocLineRecRef,2,StrArray[2],UseFilter::SETFILTER);   //"Document Type"
                    SetFilterRecRef(ParaDocLineRecRef,3,StrArray[3],UseFilter::SETRANGE);    //"Document No."
                    SetFilterRecRef(ParaDocLineRecRef,4,StrArray[4],UseFilter::SETRANGE);    //"Document No. 2"
                    SetFilterRecRef(ParaDocLineRecRef,5,StrArray[6],UseFilter::SETFILTER);   //"Document Line No."
                    SetFilterRecRef(ParaDocLineRecRef,6,LotNo,UseFilter::SETRANGE);          //"Lot No."
                  end;
                  SetFilterRecRef(ParaDocLineRecRef,7,GetValueRecRef(ParamSetupRecRef,5),UseFilter::SETRANGE); //Parameter
                  if ParaDocLineRecRef.FINDFIRST then begin
                    if (LanguageCode <> '') then begin
                      CLEAR(ParaTranslationRecRef);
                      ParaTranslationRecRef.OPEN(5077943);                                                              //Parameter Translation
                      SetFilterRecRef(ParaTranslationRecRef,1,GetValueRecRef(ParaDocLineRecRef,7),UseFilter::SETRANGE); //Parameter
                      SetFilterRecRef(ParaTranslationRecRef,2,LanguageCode,UseFilter::SETRANGE);                        //"Language Code"
                      if ParaTranslationRecRef.FINDFIRST then
                        ParameterDescription := GetValueRecRef(ParaTranslationRecRef,3)
                      else begin
                        CLEAR(ParaRecRef);
                        ParaRecRef.OPEN(5102726);                                                               //Parameter
                        SetFilterRecRef(ParaRecRef,1,GetValueRecRef(ParaDocLineRecRef,7),UseFilter::SETRANGE);  //Parameter
                        if ParaRecRef.FINDFIRST then
                          ParameterDescription := GetValueRecRef(ParaRecRef,3);
                      end;
                    end else begin
                      CLEAR(ParaRecRef);
                      ParaRecRef.OPEN(5102726);                                                               //Parameter
                      SetFilterRecRef(ParaRecRef,1,GetValueRecRef(ParaDocLineRecRef,7),UseFilter::SETRANGE);  //Parameter
                      if ParaRecRef.FINDFIRST then
                        ParameterDescription := GetValueRecRef(ParaRecRef,3);
                    end;
                  end;
                end;
                ParaDescriptionList += ParameterDescription;
                if GetValueRecRef(ParamSetupRecRef,8) <> '' then
                  ParaDescriptionList += ' ' + GetValueRecRef(ParamSetupRecRef,8);
              until ParamSetupRecRef.NEXT = 0;
            end;
          // Ungebuchter Beleg
          2:begin
              repeat
                if ParaDescriptionList <> '' then
                  ParaDescriptionList += ' ';
                Counter += 1;
                if not ParameterTableExist then begin
                  if ItemAttributeTranslation.GET(GetValueRecRef(ParamSetupRecRef,5),LanguageCode) then
                    ParameterDescription := ItemAttributeTranslation.Name
                  else
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef,5)) then
                      ParameterDescription := ItemAttribute.Name;
                end else begin
                  if Counter = 1 then begin
                    CLEAR(ParaDocLineRecRef);
                    ParaDocLineRecRef.OPEN(5078146);
                    SetFilterRecRef(ParaDocLineRecRef,1,StrArray[1],UseFilter::SETFILTER);  //"Table ID"
                    SetFilterRecRef(ParaDocLineRecRef,2,StrArray[2],UseFilter::SETFILTER);  //"Document Type"
                    SetFilterRecRef(ParaDocLineRecRef,3,StrArray[3],UseFilter::SETRANGE);   //"Document No."
                    SetFilterRecRef(ParaDocLineRecRef,4,StrArray[4],UseFilter::SETRANGE);   //"Document No. 2"
                    case StrArray[1] of
                      FORMAT(DATABASE::"Prod. Order Line"): SetFilterRecRef(ParaDocLineRecRef,5,StrArray[5],UseFilter::SETFILTER); //"Document Line No."
                      FORMAT(DATABASE::"Prod. Order Component"):
                        begin
                          SetFilterRecRef(ParaDocLineRecRef,4,StrArray[6],UseFilter::SETRANGE);  //"Document No. 2"
                          SetFilterRecRef(ParaDocLineRecRef,5,StrArray[5],UseFilter::SETFILTER); //"Document Line No."
                        end;
                      else
                        SetFilterRecRef(ParaDocLineRecRef,5,StrArray[6],UseFilter::SETFILTER); //"Document Line No."
                    end;
                    SetFilterRecRef(ParaDocLineRecRef,6,LotNo,UseFilter::SETRANGE);        //"Lot No."
                  end;

                  SetFilterRecRef(ParaDocLineRecRef,7,GetValueRecRef(ParamSetupRecRef,5),UseFilter::SETRANGE); //Parameter
                  if ParaDocLineRecRef.FINDFIRST then begin
                    if (LanguageCode <> '') then begin
                      CLEAR(ParaTranslationRecRef);
                      ParaTranslationRecRef.OPEN(5077943);                                                               //Parameter Translation
                      SetFilterRecRef(ParaTranslationRecRef,1,GetValueRecRef(ParaDocLineRecRef,7),UseFilter::SETRANGE);  //Parameter
                      SetFilterRecRef(ParaTranslationRecRef,2,LanguageCode,UseFilter::SETRANGE);                         //"Language Code"
                      if ParaTranslationRecRef.FINDFIRST then
                        ParameterDescription := GetValueRecRef(ParaTranslationRecRef,3)
                      else begin
                        CLEAR(ParaRecRef);
                        ParaRecRef.OPEN(5102726);                                                               //Parameter
                        SetFilterRecRef(ParaRecRef,1,GetValueRecRef(ParaDocLineRecRef,7),UseFilter::SETRANGE);  //Parameter
                        if ParaRecRef.FINDFIRST then
                          ParameterDescription := GetValueRecRef(ParaRecRef,3);
                      end;
                    end else begin
                      CLEAR(ParaRecRef);
                      ParaRecRef.OPEN(5102726);                                                               //Parameter
                      SetFilterRecRef(ParaRecRef,1,GetValueRecRef(ParaDocLineRecRef,7),UseFilter::SETRANGE);  //Parameter
                      if ParaRecRef.FINDFIRST then
                        ParameterDescription := GetValueRecRef(ParaRecRef,3);
                    end;
                  end;
                end;
                ParaDescriptionList += ParameterDescription;
                if GetValueRecRef(ParamSetupRecRef,8) <> '' then
                  ParaDescriptionList += ' ' + GetValueRecRef(ParamSetupRecRef,8);
              until ParamSetupRecRef.NEXT = 0;
            end;
          3:begin
              repeat
                if ParaDescriptionList <> '' then
                  ParaDescriptionList += ' ';
                Counter += 1;
                if not ParameterTableExist then begin
                  if ItemAttributeTranslation.GET(GetValueRecRef(ParamSetupRecRef,5),LanguageCode) then
                    ParameterDescription := ItemAttributeTranslation.Name
                  else
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef,5)) then
                      ParameterDescription := ItemAttribute.Name;
                end else begin
                  if Counter = 1 then begin
                    CLEAR(ParaAssignRecRef);
                    ParaAssignRecRef.OPEN(5102703);                                         //Parameter Assignment
                    SetFilterRecRef(ParaAssignRecRef, 1,StrArray[1],UseFilter::SETFILTER);  //"Table-ID"
                    SetFilterRecRef(ParaAssignRecRef, 2,StrArray[3],UseFilter::SETRANGE);   //Code
                    SetFilterRecRef(ParaAssignRecRef,12,StrArray[4],UseFilter::SETRANGE);   //"Code 2"
                  end;
                  SetFilterRecRef(ParaAssignRecRef,3,GetValueRecRef(ParamSetupRecRef,5),UseFilter::SETRANGE);
                  if ParaAssignRecRef.FINDFIRST then begin
                    if (LanguageCode <> '') then begin
                      CLEAR(ParaTranslationRecRef);
                      ParaTranslationRecRef.OPEN(5077943);                                                              //Parameter Translation
                      SetFilterRecRef(ParaTranslationRecRef,1,GetValueRecRef(ParaAssignRecRef,3),UseFilter::SETRANGE);  //Parameter
                      SetFilterRecRef(ParaTranslationRecRef,2,LanguageCode,UseFilter::SETRANGE);                        //"Language Code"
                      if ParaTranslationRecRef.FINDFIRST then
                        ParameterDescription := GetValueRecRef(ParaTranslationRecRef,3)
                      else begin
                        CLEAR(ParaRecRef);
                        ParaRecRef.OPEN(5102726);                                                               //Parameter
                        SetFilterRecRef(ParaRecRef,1,GetValueRecRef(ParaAssignRecRef,3),UseFilter::SETRANGE);   //Parameter
                        if ParaRecRef.FINDFIRST then
                          ParameterDescription := GetValueRecRef(ParaRecRef,3);
                      end;
                    end else begin
                      CLEAR(ParaRecRef);
                      ParaRecRef.OPEN(5102726);                                                              //Parameter
                      SetFilterRecRef(ParaRecRef,1,GetValueRecRef(ParaAssignRecRef,3),UseFilter::SETRANGE);  //Parameter
                      if ParaRecRef.FINDFIRST then
                        ParameterDescription := GetValueRecRef(ParaRecRef,3);
                    end;
                  end;
                end;
                ParaDescriptionList += ParameterDescription;
                if GetValueRecRef(ParamSetupRecRef,8) <> '' then
                  ParaDescriptionList += ' ' + GetValueRecRef(ParamSetupRecRef,8);
              until ParamSetupRecRef.NEXT = 0;
            end;
          4:begin
              repeat
                if ParaDescriptionList <> '' then
                  ParaDescriptionList += ' ';
                Counter += 1;
                if not ParameterTableExist then begin
                  if ItemAttributeTranslation.GET(GetValueRecRef(ParamSetupRecRef,5),LanguageCode) then
                    ParameterDescription := ItemAttributeTranslation.Name
                  else
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef,5)) then
                      ParameterDescription := ItemAttribute.Name;
                end else begin
                  if Counter = 1 then begin
                    CLEAR(ParaEntryRecRef);
                    ParaEntryRecRef.OPEN(5078149);                                        //Parameter Entry
                    SetFilterRecRef(ParaEntryRecRef,  6,StrArray[3],UseFilter::SETRANGE); //"Lot No."
                    SetFilterRecRef(ParaEntryRecRef,201,StrArray[4],UseFilter::SETRANGE); //"Item No."
                    SetFilterRecRef(ParaEntryRecRef, 50,false,UseFilter::SETRANGE);       //Canceled
                  end;
                  SetFilterRecRef(ParaEntryRecRef,7,GetValueRecRef(ParamSetupRecRef,5),UseFilter::SETRANGE);
                  if ParaEntryRecRef.FINDFIRST then begin
                    if (LanguageCode <> '') then begin
                      CLEAR(ParaTranslationRecRef);
                      ParaTranslationRecRef.OPEN(5077943);                                                              //Parameter Translation
                      SetFilterRecRef(ParaTranslationRecRef,1,GetValueRecRef(ParaEntryRecRef,7),UseFilter::SETRANGE);   //Parameter
                      SetFilterRecRef(ParaTranslationRecRef,2,LanguageCode,UseFilter::SETRANGE);                        //"Language Code"
                      if ParaTranslationRecRef.FINDFIRST then
                        ParameterDescription := GetValueRecRef(ParaTranslationRecRef,3)
                      else begin
                        CLEAR(ParaRecRef);
                        ParaRecRef.OPEN(5102726);                                                             //Parameter
                        SetFilterRecRef(ParaRecRef,1,GetValueRecRef(ParaEntryRecRef,7),UseFilter::SETRANGE);  //Parameter
                        if ParaRecRef.FINDFIRST then
                          ParameterDescription := GetValueRecRef(ParaRecRef,3);
                      end;
                    end else begin
                      CLEAR(ParaRecRef);
                      ParaRecRef.OPEN(5102726);                                                             //Parameter
                      SetFilterRecRef(ParaRecRef,1,GetValueRecRef(ParaEntryRecRef,7),UseFilter::SETRANGE);  //Parameter
                      if ParaRecRef.FINDFIRST then
                        ParameterDescription := GetValueRecRef(ParaRecRef,3);
                    end;
                  end;
                end;
                ParaDescriptionList += ParameterDescription;
                if GetValueRecRef(ParamSetupRecRef,8) <> '' then
                  ParaDescriptionList += ' ' + GetValueRecRef(ParamSetupRecRef,8);
              until ParamSetupRecRef.NEXT = 0;
            end;
          // Archivierter Beleg
          5:begin
              repeat
                if ParaDescriptionList <> '' then
                  ParaDescriptionList += ' ';
                Counter += 1;
                if not ParameterTableExist then begin
                  if ItemAttributeTranslation.GET(GetValueRecRef(ParamSetupRecRef,5),LanguageCode) then
                    ParameterDescription := ItemAttributeTranslation.Name
                  else
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef,5)) then
                      ParameterDescription := ItemAttribute.Name;
                end else begin
                  if Counter = 1 then begin
                    CLEAR(ParaDocLineRecRef);
                    ParaDocLineRecRef.OPEN(5078160);
                    SetFilterRecRef(ParaDocLineRecRef,1,StrArray[1],UseFilter::SETFILTER);
                    SetFilterRecRef(ParaDocLineRecRef,2,StrArray[2],UseFilter::SETFILTER);
                    SetFilterRecRef(ParaDocLineRecRef,3,StrArray[3],UseFilter::SETRANGE);
                    SetFilterRecRef(ParaDocLineRecRef,4,StrArray[4],UseFilter::SETRANGE);
                    case StrArray[1] of
                      FORMAT(DATABASE::"Prod. Order Line"):SetFilterRecRef(ParaDocLineRecRef,5,StrArray[5],UseFilter::SETFILTER);
                      FORMAT(DATABASE::"Prod. Order Component"):
                        begin
                          SetFilterRecRef(ParaDocLineRecRef,4,StrArray[6],UseFilter::SETRANGE);
                          SetFilterRecRef(ParaDocLineRecRef,5,StrArray[5],UseFilter::SETFILTER);
                        end;
                      else begin
                        SetFilterRecRef(ParaDocLineRecRef,5047,StrArray[5],UseFilter::SETFILTER);
                        SetFilterRecRef(ParaDocLineRecRef,5,StrArray[6],UseFilter::SETFILTER);
                      end;
                    end;
                    SetFilterRecRef(ParaDocLineRecRef,6,LotNo,UseFilter::SETRANGE);
                  end;

                  SetFilterRecRef(ParaDocLineRecRef,7,GetValueRecRef(ParamSetupRecRef,5),UseFilter::SETRANGE);
                  if ParaDocLineRecRef.FINDFIRST then begin
                    if (LanguageCode <> '') then begin
                      CLEAR(ParaTranslationRecRef);
                      ParaTranslationRecRef.OPEN(5077943);                                                              //Parameter Translation
                      SetFilterRecRef(ParaTranslationRecRef,1,GetValueRecRef(ParaDocLineRecRef,7),UseFilter::SETRANGE);   //Parameter
                      SetFilterRecRef(ParaTranslationRecRef,2,LanguageCode,UseFilter::SETRANGE);                        //"Language Code"
                      if ParaTranslationRecRef.FINDFIRST then
                        ParameterDescription := GetValueRecRef(ParaTranslationRecRef,3)
                      else begin
                        CLEAR(ParaRecRef);
                        ParaRecRef.OPEN(5102726);                                                             //Parameter
                        SetFilterRecRef(ParaRecRef,1,GetValueRecRef(ParaDocLineRecRef,7),UseFilter::SETRANGE);  //Parameter
                        if ParaRecRef.FINDFIRST then
                          ParameterDescription := GetValueRecRef(ParaRecRef,3);
                      end;
                    end else begin
                      CLEAR(ParaRecRef);
                      ParaRecRef.OPEN(5102726);                                                             //Parameter
                      SetFilterRecRef(ParaRecRef,1,GetValueRecRef(ParaDocLineRecRef,7),UseFilter::SETRANGE);  //Parameter
                      if ParaRecRef.FINDFIRST then
                        ParameterDescription := GetValueRecRef(ParaRecRef,3);
                    end;
                  end;
                end;
                ParaDescriptionList += ParameterDescription;
                if GetValueRecRef(ParamSetupRecRef,8) <> '' then
                  ParaDescriptionList += ' ' + GetValueRecRef(ParamSetupRecRef,8);
              until ParamSetupRecRef.NEXT = 0;
            end;
        end;
    end;

    procedure GetParameterValue(ReportType: Integer;ReportID: Integer;Pos: Integer;ParaType: Integer;LanguageCode: Code[10];RowID: Text[250];LotNo: Code[20];ItemNo: Code[20]) ParaValueList: Text[1000]
    var
        StrArray: array [6] of Text[100];
        ParameterValue: Text[50];
        UnitofMeasureDescription: Text[30];
        UnitofMeasureRec: Record "Unit of Measure";
        UnitofMeasureTranslationRec: Record "Unit of Measure Translation";
        PrintValueDec: Decimal;
        PrintValue: Text[250];
        UseFilter: Option SETRANGE,SETFILTER;
        ParaDocLineRecRef: RecordRef;
        ParaTranslationRecRef: RecordRef;
        ParaRecRef: RecordRef;
        ParaAssignRecRef: RecordRef;
        ParaEntryRecRef: RecordRef;
        Counter: Integer;
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemAttrValueTranslation: Record "Item Attr. Value Translation";
        ItemAttributeValue: Record "Item Attribute Value";
        ItemAttribute: Record "Item Attribute";
        ParamSetupRecRef: RecordRef;
        LeBiINSTSetupRecRef: RecordRef;
        ParameterTableExist: Boolean;
    begin
        // Ermittlung der Werte, der zu druckenden Parameter
        // Return eines Strings (wenn Sprachcode hinterlegt, mit Übersetzung)

        CLEAR(LeBiINSTSetupRecRef);
        Object.SETRANGE(Type,Object.Type::Table);
        Object.SETRANGE(ID,5102700);
        if Object.FINDSET then begin
          LeBiINSTSetupRecRef.OPEN(5102700);
          if LeBiINSTSetupRecRef.FINDFIRST then
            ParameterTableExist := true;
        end;

        ParaValueList := '';

        // Tabellen Filter wird definiert
        CLEAR(ParamSetupRecRef);
        if ParameterTableExist then
          ParamSetupRecRef.OPEN(5077913)
        else
          ParamSetupRecRef.OPEN(5272725);

        SetFilterRecRef(ParamSetupRecRef,1,5,UseFilter::SETRANGE);
        SetFilterRecRef(ParamSetupRecRef,2,ReportID,UseFilter::SETRANGE);
        if not ParamSetupRecRef.FINDSET then begin
          ParamSetupRecRef.RESET;
          SetFilterRecRef(ParamSetupRecRef,1,ReportType,UseFilter::SETRANGE);
        end;

        // Trennung der übergebenen ROWID in ein Array
        FragmentRowID(RowID,StrArray);

        // Die zu druckende Position filtern
        SetFilterRecRef(ParamSetupRecRef,3,Pos,UseFilter::SETRANGE);
        if not ParamSetupRecRef.FINDFIRST then
          exit('');

        // Gebuchter Beleg
        case ParaType of
          1:begin
              repeat
                if ParaValueList <> '' then
                  ParaValueList += ' ';
                Counter += 1;
                if not ParameterTableExist then begin
                  if ItemAttributeValueMapping.GET(DATABASE::Item,ItemNo,GetValueRecRef(ParamSetupRecRef,5)) then begin
                    if ItemAttrValueTranslation.GET(ItemAttributeValueMapping."Item Attribute ID",ItemAttributeValueMapping."Item Attribute Value ID",LanguageCode) then
                      ParaValueList += ItemAttrValueTranslation.Name
                    else begin
                      if ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID",ItemAttributeValueMapping."Item Attribute Value ID") then
                        ParaValueList += ItemAttributeValue.Value;
                    end;
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef,5)) then begin
                      if UnitofMeasureTranslationRec.GET(ItemAttribute."Unit of Measure",LanguageCode) then
                        UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                      else begin
                        if UnitofMeasureRec.GET(ItemAttribute."Unit of Measure") then
                          UnitofMeasureDescription := UnitofMeasureRec.Description;
                      end;
                    end;
                  end;
                end else begin
                  if Counter = 1 then begin
                    CLEAR(ParaDocLineRecRef);
                    ParaDocLineRecRef.OPEN(5078148);                                         //Posted Parameter Document Line
                    SetFilterRecRef(ParaDocLineRecRef,1,StrArray[1],UseFilter::SETFILTER);   //"Table ID"
                    SetFilterRecRef(ParaDocLineRecRef,2,StrArray[2],UseFilter::SETFILTER);   //"Document Type"
                    SetFilterRecRef(ParaDocLineRecRef,3,StrArray[3],UseFilter::SETRANGE);    //"Document No."
                    SetFilterRecRef(ParaDocLineRecRef,4,StrArray[4],UseFilter::SETRANGE);    //"Document No. 2"
                    SetFilterRecRef(ParaDocLineRecRef,5,StrArray[6],UseFilter::SETFILTER);   //"Document Line No."
                    SetFilterRecRef(ParaDocLineRecRef,6,LotNo,UseFilter::SETRANGE);          //"Lot No."
                  end;


                  SetFilterRecRef(ParaDocLineRecRef,7,GetValueRecRef(ParamSetupRecRef,5),UseFilter::SETRANGE); //Parameter
                  if ParaDocLineRecRef.FINDFIRST then begin
                    case GetValueRecRef(ParaDocLineRecRef,8) of
                      'Decimal':
                        begin
                          if not EVALUATE(PrintValueDec,GetValueRecRef(ParaDocLineRecRef,70)) then
                            PrintValue := GetValueRecRef(ParaDocLineRecRef,70)
                          else
                            if GetValueRecRef(ParamSetupRecRef,10)  <> '' then
                              PrintValue := FORMAT(PrintValueDec,0,'<Precision,' + GetValueRecRef(ParamSetupRecRef,10) +
                              '><Sign><Integer><Decimals>')
                            else
                              PrintValue := GetValueRecRef(ParaDocLineRecRef,70);
                          ParaValueList += PrintValue;
                        end;
                      'Boolean','Text':
                        begin
                          ParaValueList += IdentifyValueTranslation(GetValueRecRef(ParaDocLineRecRef,70),   //"Print Value"
                                                                    GetValueRecRef(ParaDocLineRecRef,300),  //Text
                                                                    GetValueRecRef(ParaDocLineRecRef,7),    //Parameter
                                                                    GetValueRecRef(ParaDocLineRecRef,305),  //"Parameter Domain"
                                                                    LanguageCode);                          //"Language Code"
                        end;
                    end;
                    UnitofMeasureDescription := '';
                    if UnitofMeasureTranslationRec.GET(GetValueRecRef(ParaDocLineRecRef,410),LanguageCode) then
                      UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                    else begin
                      if UnitofMeasureRec.GET(GetValueRecRef(ParaDocLineRecRef,410)) then
                        UnitofMeasureDescription := UnitofMeasureRec.Description;
                    end;
                  end;
                end;
                if UnitofMeasureDescription <> '' then
                  ParaValueList += ' ' + UnitofMeasureDescription;
                if GetValueRecRef(ParamSetupRecRef,8) <> '' then
                  ParaValueList += ' ' + GetValueRecRef(ParamSetupRecRef,8);
              until ParamSetupRecRef.NEXT = 0;
            end;
          2:begin
              // Ungebuchter Beleg
              repeat
                if ParaValueList <> '' then
                  ParaValueList += ' ';
                Counter += 1;
                if not ParameterTableExist then begin
                  if ItemAttributeValueMapping.GET(DATABASE::Item,ItemNo,GetValueRecRef(ParamSetupRecRef,5)) then begin
                    if ItemAttrValueTranslation.GET(ItemAttributeValueMapping."Item Attribute ID",ItemAttributeValueMapping."Item Attribute Value ID",LanguageCode) then
                      ParaValueList += ItemAttrValueTranslation.Name
                    else begin
                      if ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID",ItemAttributeValueMapping."Item Attribute Value ID") then
                        ParaValueList += ItemAttributeValue.Value;
                    end;
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef,5)) then begin
                      if UnitofMeasureTranslationRec.GET(ItemAttribute."Unit of Measure",LanguageCode) then
                        UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                      else begin
                        if UnitofMeasureRec.GET(ItemAttribute."Unit of Measure") then
                          UnitofMeasureDescription := UnitofMeasureRec.Description;
                      end;
                    end;
                  end;
                end else begin
                  if Counter = 1 then begin
                    CLEAR(ParaDocLineRecRef);
                    ParaDocLineRecRef.OPEN(5078146);
                    SetFilterRecRef(ParaDocLineRecRef,1,StrArray[1],UseFilter::SETFILTER);  //"Table ID"
                    SetFilterRecRef(ParaDocLineRecRef,2,StrArray[2],UseFilter::SETFILTER);  //"Document Type"
                    SetFilterRecRef(ParaDocLineRecRef,3,StrArray[3],UseFilter::SETRANGE);   //"Document No."
                    SetFilterRecRef(ParaDocLineRecRef,4,StrArray[4],UseFilter::SETRANGE);   //"Document No. 2"
                    case StrArray[1] of
                      FORMAT(DATABASE::"Prod. Order Line"): SetFilterRecRef(ParaDocLineRecRef,5,StrArray[5],UseFilter::SETFILTER); //"Document Line No."
                      FORMAT(DATABASE::"Prod. Order Component"):
                        begin
                          SetFilterRecRef(ParaDocLineRecRef,4,StrArray[6],UseFilter::SETRANGE);  //"Document No. 2"
                          SetFilterRecRef(ParaDocLineRecRef,5,StrArray[5],UseFilter::SETFILTER); //"Document Line No."
                        end;
                      else
                        SetFilterRecRef(ParaDocLineRecRef,5,StrArray[6],UseFilter::SETFILTER); //"Document Line No."
                    end;
                    SetFilterRecRef(ParaDocLineRecRef,6,LotNo,UseFilter::SETRANGE);        //"Lot No."
                  end;
                // Prüfung ob mehrere Parameter für die zu druckende Position vorhanden sind und Rückgabe String bilden
                  SetFilterRecRef(ParaDocLineRecRef,7,GetValueRecRef(ParamSetupRecRef,5),UseFilter::SETRANGE); //Parameter
                  if ParaDocLineRecRef.FINDFIRST then begin
                      case GetValueRecRef(ParaDocLineRecRef,8) of
                        'Decimal':
                        begin
                          if not EVALUATE(PrintValueDec,GetValueRecRef(ParaDocLineRecRef,70)) then
                            PrintValue := GetValueRecRef(ParaDocLineRecRef,70)
                          else
                            if GetValueRecRef(ParamSetupRecRef,10)  <> '' then
                              PrintValue := FORMAT(PrintValueDec,0,'<Precision,' + GetValueRecRef(ParamSetupRecRef,10) +
                              '><Sign><Integer><Decimals>')
                            else
                              PrintValue := GetValueRecRef(ParaDocLineRecRef,70);
                          ParaValueList += PrintValue;
                        end;
                      'Boolean','Text':
                        begin
                          ParaValueList += IdentifyValueTranslation(GetValueRecRef(ParaDocLineRecRef,70),   //"Print Value"
                                                                    GetValueRecRef(ParaDocLineRecRef,300),  //Text
                                                                    GetValueRecRef(ParaDocLineRecRef,7),    //Parameter
                                                                    GetValueRecRef(ParaDocLineRecRef,305),  //"Parameter Domain"
                                                                    LanguageCode);                          //"Language Code"
                        end;
                    end;
                    UnitofMeasureDescription := '';
                    if UnitofMeasureTranslationRec.GET(GetValueRecRef(ParaDocLineRecRef,410),LanguageCode) then
                      UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                    else begin
                      if UnitofMeasureRec.GET(GetValueRecRef(ParaDocLineRecRef,410)) then
                        UnitofMeasureDescription := UnitofMeasureRec.Description;
                    end;
                  end;
                end;
                if UnitofMeasureDescription <> '' then
                  ParaValueList += ' ' + UnitofMeasureDescription;
                if GetValueRecRef(ParamSetupRecRef,8) <> '' then
                  ParaValueList += ' ' + GetValueRecRef(ParamSetupRecRef,8);
              until ParamSetupRecRef.NEXT = 0;
            end;
          // Assign
          3:begin
              repeat
                if ParaValueList <> '' then
                  ParaValueList += ' ';
                Counter += 1;
                if not ParameterTableExist then begin
                  if ItemAttributeValueMapping.GET(DATABASE::Item,ItemNo,GetValueRecRef(ParamSetupRecRef,5)) then begin
                    if ItemAttrValueTranslation.GET(ItemAttributeValueMapping."Item Attribute ID",ItemAttributeValueMapping."Item Attribute Value ID",LanguageCode) then
                      ParaValueList += ItemAttrValueTranslation.Name
                    else begin
                      if ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID",ItemAttributeValueMapping."Item Attribute Value ID") then
                        ParaValueList += ItemAttributeValue.Value;
                    end;
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef,5)) then begin
                      if UnitofMeasureTranslationRec.GET(ItemAttribute."Unit of Measure",LanguageCode) then
                        UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                      else begin
                        if UnitofMeasureRec.GET(ItemAttribute."Unit of Measure") then
                          UnitofMeasureDescription := UnitofMeasureRec.Description;
                      end;
                    end;
                  end;
                end else begin
                  if Counter = 1 then begin
                    CLEAR(ParaAssignRecRef);
                    ParaAssignRecRef.OPEN(5102703);                                         //Parameter Assignment
                    SetFilterRecRef(ParaAssignRecRef, 1,StrArray[1],UseFilter::SETFILTER);  //"Table-ID"
                    SetFilterRecRef(ParaAssignRecRef, 2,StrArray[3],UseFilter::SETRANGE);   //Code
                    SetFilterRecRef(ParaAssignRecRef,12,StrArray[4],UseFilter::SETRANGE);   //"Code 2"
                  end;
                  SetFilterRecRef(ParaAssignRecRef,3,GetValueRecRef(ParamSetupRecRef,5),UseFilter::SETRANGE);
                  if ParaAssignRecRef.FINDFIRST then begin
                    case GetValueRecRef(ParaAssignRecRef,4) of
                        'Decimal':
                        begin
                          if not EVALUATE(PrintValueDec,GetValueRecRef(ParaAssignRecRef,5077904)) then
                            PrintValue := GetValueRecRef(ParaAssignRecRef,5077904)
                          else
                            if GetValueRecRef(ParamSetupRecRef,10)  <> '' then
                              PrintValue := FORMAT(PrintValueDec,0,'<Precision,' + GetValueRecRef(ParamSetupRecRef,10) +
                              '><Sign><Integer><Decimals>')
                            else
                              PrintValue := GetValueRecRef(ParaAssignRecRef,5077904);
                          ParaValueList += PrintValue;
                        end;
                      'Boolean','Text':
                        begin
                          ParaValueList += IdentifyValueTranslation(GetValueRecRef(ParaAssignRecRef,5077904),   //"Print Value"
                                                                    GetValueRecRef(ParaAssignRecRef,20),        //Text
                                                                    GetValueRecRef(ParaAssignRecRef,3),         //Parameter
                                                                    GetValueRecRef(ParaAssignRecRef,5077903),   //"Parameter Domain"
                                                                    LanguageCode);                              //"Language Code"
                        end;
                    end;
                    UnitofMeasureDescription := '';
                    if UnitofMeasureTranslationRec.GET(GetValueRecRef(ParaAssignRecRef,5078000),LanguageCode) then
                      UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                    else begin
                      if UnitofMeasureRec.GET(GetValueRecRef(ParaAssignRecRef,5078000)) then
                        UnitofMeasureDescription := UnitofMeasureRec.Description;
                    end;
                  end;
                end;
                if UnitofMeasureDescription <> '' then
                  ParaValueList += ' ' + UnitofMeasureDescription;
                if GetValueRecRef(ParamSetupRecRef,8) <> '' then
                  ParaValueList += ' ' + GetValueRecRef(ParamSetupRecRef,8);
              until ParamSetupRecRef.NEXT = 0;
            end;
          4:begin
              repeat
                if ParaValueList <> '' then
                  ParaValueList += ' ';
                Counter += 1;
                if not ParameterTableExist then begin
                  if ItemAttributeValueMapping.GET(DATABASE::Item,ItemNo,GetValueRecRef(ParamSetupRecRef,5)) then begin
                    if ItemAttrValueTranslation.GET(ItemAttributeValueMapping."Item Attribute ID",ItemAttributeValueMapping."Item Attribute Value ID",LanguageCode) then
                      ParaValueList += ItemAttrValueTranslation.Name
                    else begin
                      if ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID",ItemAttributeValueMapping."Item Attribute Value ID") then
                        ParaValueList += ItemAttributeValue.Value;
                    end;
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef,5)) then begin
                      if UnitofMeasureTranslationRec.GET(ItemAttribute."Unit of Measure",LanguageCode) then
                        UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                      else begin
                        if UnitofMeasureRec.GET(ItemAttribute."Unit of Measure") then
                          UnitofMeasureDescription := UnitofMeasureRec.Description;
                      end;
                    end;
                  end;
                end else begin
                  if Counter = 1 then begin
                    CLEAR(ParaEntryRecRef);
                    ParaEntryRecRef.OPEN(5078149);                                        //Parameter Entry
                    SetFilterRecRef(ParaEntryRecRef,  6,StrArray[3],UseFilter::SETRANGE); //"Lot No."
                    SetFilterRecRef(ParaEntryRecRef,201,StrArray[4],UseFilter::SETRANGE); //"Item No."
                    SetFilterRecRef(ParaEntryRecRef, 50,false,UseFilter::SETRANGE);       //Canceled
                  end;
                  SetFilterRecRef(ParaEntryRecRef,7,GetValueRecRef(ParamSetupRecRef,5),UseFilter::SETRANGE);
                  if ParaEntryRecRef.FINDFIRST then begin
                    case GetValueRecRef(ParaEntryRecRef,8) of
                        'Decimal':
                        begin
                          if not EVALUATE(PrintValueDec,GetValueRecRef(ParaEntryRecRef,70)) then
                            PrintValue := GetValueRecRef(ParaEntryRecRef,70)
                          else
                            if GetValueRecRef(ParamSetupRecRef,10)  <> '' then
                              PrintValue := FORMAT(PrintValueDec,0,'<Precision,' + GetValueRecRef(ParamSetupRecRef,10) +
                              '><Sign><Integer><Decimals>')
                            else
                              PrintValue := GetValueRecRef(ParaEntryRecRef,70);
                          ParaValueList += PrintValue;
                        end;
                      'Boolean','Text':
                        begin
                          ParaValueList += IdentifyValueTranslation(GetValueRecRef(ParaEntryRecRef,70),     //"Print Value"
                                                                    GetValueRecRef(ParaAssignRecRef,300),   //Text
                                                                    GetValueRecRef(ParaAssignRecRef,7),     //Parameter
                                                                    GetValueRecRef(ParaAssignRecRef,305),   //"Parameter Domain"
                                                                    LanguageCode);                          //"Language Code"
                        end;
                    end;
                    UnitofMeasureDescription := '';
                    if UnitofMeasureTranslationRec.GET(GetValueRecRef(ParaEntryRecRef,410),LanguageCode) then
                      UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                    else begin
                      if UnitofMeasureRec.GET(GetValueRecRef(ParaEntryRecRef,410)) then
                        UnitofMeasureDescription := UnitofMeasureRec.Description;
                    end;
                  end;
                end;
                if UnitofMeasureDescription <> '' then
                  ParaValueList += ' ' + UnitofMeasureDescription;
                if GetValueRecRef(ParamSetupRecRef,8) <> '' then
                  ParaValueList += ' ' + GetValueRecRef(ParamSetupRecRef,8);
              until ParamSetupRecRef.NEXT = 0;
          end;
          5:begin
              // Archivierter Beleg
              repeat
                if ParaValueList <> '' then
                  ParaValueList += ' ';
                Counter += 1;
                if not ParameterTableExist then begin
                  if ItemAttributeValueMapping.GET(DATABASE::Item,ItemNo,GetValueRecRef(ParamSetupRecRef,5)) then begin
                    if ItemAttrValueTranslation.GET(ItemAttributeValueMapping."Item Attribute ID",ItemAttributeValueMapping."Item Attribute Value ID",LanguageCode) then
                      ParaValueList += ItemAttrValueTranslation.Name
                    else begin
                      if ItemAttributeValue.GET(ItemAttributeValueMapping."Item Attribute ID",ItemAttributeValueMapping."Item Attribute Value ID") then
                        ParaValueList += ItemAttributeValue.Value;
                    end;
                    if ItemAttribute.GET(GetValueRecRef(ParamSetupRecRef,5)) then begin
                      if UnitofMeasureTranslationRec.GET(ItemAttribute."Unit of Measure",LanguageCode) then
                        UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                      else begin
                        if UnitofMeasureRec.GET(ItemAttribute."Unit of Measure") then
                          UnitofMeasureDescription := UnitofMeasureRec.Description;
                      end;
                    end;
                  end;
                end else begin
                  if Counter = 1 then begin
                    CLEAR(ParaDocLineRecRef);
                    ParaDocLineRecRef.OPEN(5078160);
                    SetFilterRecRef(ParaDocLineRecRef,1,StrArray[1],UseFilter::SETFILTER);
                    SetFilterRecRef(ParaDocLineRecRef,2,StrArray[2],UseFilter::SETFILTER);
                    SetFilterRecRef(ParaDocLineRecRef,3,StrArray[3],UseFilter::SETRANGE);
                    SetFilterRecRef(ParaDocLineRecRef,4,StrArray[4],UseFilter::SETRANGE);
                    case StrArray[1] of
                      FORMAT(DATABASE::"Prod. Order Line"):SetFilterRecRef(ParaDocLineRecRef,5,StrArray[5],UseFilter::SETFILTER);
                      FORMAT(DATABASE::"Prod. Order Component"):
                        begin
                          SetFilterRecRef(ParaDocLineRecRef,4,StrArray[6],UseFilter::SETRANGE);
                          SetFilterRecRef(ParaDocLineRecRef,5,StrArray[5],UseFilter::SETFILTER);
                        end;
                      else begin
                        SetFilterRecRef(ParaDocLineRecRef,5047,StrArray[5],UseFilter::SETFILTER);
                        SetFilterRecRef(ParaDocLineRecRef,5,StrArray[6],UseFilter::SETFILTER);
                      end;
                    end;
                    SetFilterRecRef(ParaDocLineRecRef,6,LotNo,UseFilter::SETRANGE);
                  end;
                  SetFilterRecRef(ParaDocLineRecRef,7,GetValueRecRef(ParamSetupRecRef,5),UseFilter::SETRANGE);
                  if ParaDocLineRecRef.FINDFIRST then begin
                    case GetValueRecRef(ParaDocLineRecRef,8) of
                        'Decimal':
                        begin
                          if not EVALUATE(PrintValueDec,GetValueRecRef(ParaDocLineRecRef,70)) then
                            PrintValue := GetValueRecRef(ParaDocLineRecRef,70)
                          else
                            if GetValueRecRef(ParamSetupRecRef,10)  <> '' then
                              PrintValue := FORMAT(PrintValueDec,0,'<Precision,' + GetValueRecRef(ParamSetupRecRef,10) +
                              '><Sign><Integer><Decimals>')
                            else
                              PrintValue := GetValueRecRef(ParaDocLineRecRef,70);
                          ParaValueList += PrintValue;
                        end;
                      'Boolean','Text':
                        begin
                          ParaValueList += IdentifyValueTranslation(GetValueRecRef(ParaDocLineRecRef,70),    //"Print Value"
                                                                    GetValueRecRef(ParaDocLineRecRef,300),   //Text
                                                                    GetValueRecRef(ParaDocLineRecRef,7),     //Parameter
                                                                    GetValueRecRef(ParaDocLineRecRef,305),   //"Parameter Domain"
                                                                    LanguageCode);                           //"Language Code"
                        end;
                    end;
                    UnitofMeasureDescription := '';
                    if UnitofMeasureTranslationRec.GET(GetValueRecRef(ParaDocLineRecRef,410),LanguageCode) then
                      UnitofMeasureDescription := UnitofMeasureTranslationRec.Description
                    else begin
                      if UnitofMeasureRec.GET(GetValueRecRef(ParaDocLineRecRef,410)) then
                        UnitofMeasureDescription := UnitofMeasureRec.Description;
                    end;
                  end;
                end;
                if UnitofMeasureDescription <> '' then
                  ParaValueList += ' ' + UnitofMeasureDescription;
                if GetValueRecRef(ParamSetupRecRef,8) <> '' then
                  ParaValueList += ' ' + GetValueRecRef(ParamSetupRecRef,8);
              until ParamSetupRecRef.NEXT = 0;
          end;
        end;
    end;

    procedure GetItemUnitArry(ItemUnitType: Integer;RowID: Text[250];LotNo: Code[20];LanguageCode: Code[10];var ItemUnitCode: array [50] of Code[20];var ItemUnitDescription: array [50] of Text;var ItemUnitQty: array [50] of Text)
    var
        RecordRef: RecordRef;
        Counter: Integer;
        UnitofMeasure: Record "Unit of Measure";
        UnitofMeasureTranslation: Record "Unit of Measure Translation";
        StrArray: array [6] of Text[100];
        DecVar: Decimal;
    begin
        // Trennung der übergebenen ROWID in ein Array
        FragmentRowID(RowID,StrArray);

        //Prüfung auf vorhandene Tabelle
        case ItemUnitType of
          // Gebuchter Beleg
          1:begin
              Object.SETRANGE(Type,Object.Type::Table);
              Object.SETRANGE(ID,5077965);
              if not Object.FINDSET then
                exit;
            end;
          // Ungebuchter Beleg
          2:begin
              Object.SETRANGE(Type,Object.Type::Table);
              Object.SETRANGE(ID,5077957);
              if not Object.FINDSET then
                exit;
            end;
        end;

        CLEAR(RecordRef);
        case ItemUnitType of
          1:RecordRef.OPEN(5077965);
          2:RecordRef.OPEN(5077957);
        end;
        SetFilterRecRef(RecordRef,1,StrArray[1],UseFilter::SETFILTER);   //"Table ID"
        SetFilterRecRef(RecordRef,2,StrArray[2],UseFilter::SETFILTER);   //"Document Type"
        SetFilterRecRef(RecordRef,3,StrArray[3],UseFilter::SETRANGE);    //"Document No."
        SetFilterRecRef(RecordRef,9,StrArray[4],UseFilter::SETFILTER);   //"Document No. 2"
        SetFilterRecRef(RecordRef,4,StrArray[6],UseFilter::SETFILTER);   //"Document Line No."
        SetFilterRecRef(RecordRef,12,LotNo,UseFilter::SETRANGE);         //"Lot No."
        SetFilterRecRef(RecordRef,20,true,UseFilter::SETRANGE);          //Print
        if RecordRef.FINDSET then begin
          repeat
            Counter += 1;
            ItemUnitCode[Counter] := GetValueRecRef(RecordRef,5);
            if UnitofMeasureTranslation.GET(ItemUnitCode[Counter],LanguageCode) then
              ItemUnitDescription[Counter] := UnitofMeasureTranslation.Description
            else begin
              if UnitofMeasure.GET(ItemUnitCode[Counter]) then
                ItemUnitDescription[Counter] := UnitofMeasure.Description;
            end;
            //EVALUATE(DecVar,GetValueRecRef(RecordRef,7));
            ItemUnitQty[Counter] := GetValueRecRef(RecordRef,7);
          until RecordRef.NEXT = 0;
        end;
    end;

    procedure SetFilterRecRef(var RecRef_L: RecordRef;FieldID: Integer;FieldFilter: Variant;UseFilter_L: Option SETRANGE,SETFILTER)
    var
        FieldRef_L: FieldRef;
    begin
        FieldRef_L := RecRef_L.FIELD(FieldID);
        case UseFilter_L of
          UseFilter_L::SETFILTER: FieldRef_L.SETFILTER(FieldFilter);
          UseFilter_L::SETRANGE: FieldRef_L.SETRANGE(FieldFilter);
        end;
    end;

    procedure GetValueRecRef(var RecRef_L: RecordRef;FieldID: Integer) TextVar: Text
    var
        FieldRef_L: FieldRef;
        IntVar: Integer;
    begin
        FieldRef_L := RecRef_L.FIELD(FieldID);
        TextVar := FORMAT(FieldRef_L.VALUE);
        exit(TextVar);
    end;

    procedure FragmentRowID(IDtext: Text[250];var StrArray: array [6] of Text[100])
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
          Char := COPYSTR(IDtext,Pos,1);
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

    procedure IdentifyValueTranslation(PrintValue: Text[50];Text: Text[50];Parameter: Code[20];ParameterDomain: Code[20];LanguageCode: Code[10]): Text[50]
    var
        ParaDomainTransRecRef: RecordRef;
        UseFilter: Option SETRANGE,SETFILTER;
    begin
        if PrintValue = Text then begin
          CLEAR(ParaDomainTransRecRef);
          ParaDomainTransRecRef.OPEN(5077944);
          SetFilterRecRef(ParaDomainTransRecRef,1,Parameter,UseFilter::SETRANGE);
          SetFilterRecRef(ParaDomainTransRecRef,2,ParameterDomain,UseFilter::SETRANGE);
          SetFilterRecRef(ParaDomainTransRecRef,3,LanguageCode,UseFilter::SETRANGE);
          if ParaDomainTransRecRef.FINDFIRST then
            exit(GetValueRecRef(ParaDomainTransRecRef,4))
          else
            exit(PrintValue);
        end else
          exit(PrintValue);
    end;

    procedure RowID1ForSalesShipmentLine(SalesShipmentLine: Record "Sales Shipment Line"): Text[250]
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        exit(ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Shipment Line",
          0,SalesShipmentLine."Document No.",'',0,SalesShipmentLine."Line No."));
    end;

    procedure GetSourceType(TypeVar: Option Sales,Purchase;ReportType: Option General,"Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order","Purchase Quote","Purchase Order","Blanket Purchase Order";var SourceType: Option)
    var
        LebitSourceSetup: Record "LBT Source Setup";
    begin
        LebitSourceSetup.SETRANGE(Type,TypeVar);
        LebitSourceSetup.SETRANGE("Report Type",ReportType);
        if LebitSourceSetup.ISEMPTY then
          LebitSourceSetup.SETRANGE("Report Type",LebitSourceSetup."Report Type"::General);
        if not LebitSourceSetup.FINDFIRST then begin
          SourceType := 0;
        end else begin
          case LebitSourceSetup.Type of
            LebitSourceSetup.Type::Sales:
              case LebitSourceSetup."Source Type" of
                LebitSourceSetup."Source Type"::Default: SourceType := 0;
                LebitSourceSetup."Source Type"::"Bill-to Customer": SourceType := 1;
                LebitSourceSetup."Source Type"::"Sell-to Customer": SourceType := 2;
              end;
            LebitSourceSetup.Type::Purchase:
              case LebitSourceSetup."Source Type" of
                LebitSourceSetup."Source Type"::Default: SourceType := 0;
                LebitSourceSetup."Source Type"::"Pay-to Vendor": SourceType := 1;
                LebitSourceSetup."Source Type"::"Buy-from Vendor": SourceType := 2;
              end;
          end;
        end;
    end;
}

