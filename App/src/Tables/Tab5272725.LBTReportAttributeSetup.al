table 5272725 "LBT Report - Attribute Setup"
{
    // version LBCOR1.00

    Caption = 'Report - Attribute Setup', Comment = 'DEU="Bericht - Attribute Einrichtung"';

    fields
    {
        field(1; "Report-Type"; Option)
        {
            Caption = 'Report-Type', Comment = 'DEU="Bericht-Art"';
            OptionCaption = 'Purchase,Sales,QA,Production,Delivery,Report', Comment = 'DEU="Einkauf,Verkauf,QS,Produktion,Versand,Report"';
            OptionMembers = Purchase,Sales,QA,Production,Delivery,"Report";
        }
        field(2; "Report-ID"; Integer)
        {
            Caption = 'Report-ID', Comment = 'DEU="Bericht-Nr"';
            TableRelation = IF ("Report-Type" = CONST (Report)) AllObjWithCaption."Object ID" WHERE ("Object Type" = CONST (Report));

            trigger OnValidate()
            begin
                if ("Report-Type" = "Report-Type"::Report) and ("Report-ID" = 0) then
                    ERROR(Text5272724);
            end;
        }
        field(3; Position; Integer)
        {
            Caption = 'Position', Comment = 'DEU="Position"';
            MinValue = 1;
            NotBlank = true;
        }
        field(4; Priority; Integer)
        {
            Caption = 'Priority', Comment = 'DEU="Priorität"';
        }
        field(5; ID; Integer)
        {
            Caption = 'Parameter', Comment = 'DEU="ID"';
            TableRelation = "Item Attribute";

            trigger OnValidate()
            var
                ParaRecRef: RecordRef;
                ItemAttribute: Record "Item Attribute";
            begin
                if ID <> 0 then begin
                    ItemAttribute.GET(ID);
                    Description := ItemAttribute.Name;
                    "Control Unit of Measure Code" := ItemAttribute."Unit of Measure";
                end;
                /*
                Type::Parameter:
                  BEGIN
                    CLEAR(ParaRecRef);
                    ParaRecRef.OPEN(5102726);
                    LeBitCorrespDocMgt.SetFilterRecRef(ParaRecRef,1,Code,UseFilter::SETRANGE);
                    ParaRecRef.FINDFIRST;
                    Description := LeBitCorrespDocMgt.GetValueRecRef(ParaRecRef,3);
                    "Control Unit of Measure Code" := LeBitCorrespDocMgt.GetValueRecRef(ParaRecRef,5078000);
                  END;
                */

            end;
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description', Comment = 'DEU="Beschreibung"';
            Editable = false;
        }
        field(7; "Control Unit of Measure Code"; Code[10])
        {
            Caption = 'Control Unit of Measure Code', Comment = 'DEU="Prüfeinheitencode"';
            Editable = false;
        }
        field(8; "Additional Character"; Text[30])
        {
            Caption = 'Additional Character', Comment = 'DEU="Zusatzzeichen"';
        }
        field(9; "Permit Description"; Boolean)
        {
            Caption = 'Permit Description', Comment = 'DEU="Beschreibung zulassen"';

            trigger OnValidate()
            begin
                ParamSetupRec.RESET;
                ParamSetupRec.SETRANGE("Report-Type", "Report-Type");
                ParamSetupRec.SETRANGE("Report-ID", "Report-ID");
                if ParamSetupRec.FINDSET(true) then
                    repeat
                        if not ((ParamSetupRec.Position = Position) and (ParamSetupRec.Priority = Priority)) then begin
                            ParamSetupRec."Permit Description" := "Permit Description";
                            ParamSetupRec.MODIFY;
                        end;
                    until ParamSetupRec.NEXT = 0;
            end;
        }
        field(10; "Decimal Places"; Text[30])
        {
            Caption = 'Decimal Places', Comment = 'DEU="Decimalstellen"';

            trigger OnValidate()
            var
                Int: Integer;
                ItemAttribute: Record "Item Attribute";
            begin
                if ("Decimal Places" <> '') and
                   (ID <> 0)
                then begin
                    ItemAttribute.GET(ID);
                    if ItemAttribute.Type <> ItemAttribute.Type::Decimal then
                        ERROR(Text5272722);
                    if STRPOS("Decimal Places", ':') <> 0 then begin
                        if not EVALUATE(Int, DELSTR("Decimal Places", STRPOS("Decimal Places", ':'), 1)) then
                            ERROR(Text5272723);
                    end else begin
                        if not EVALUATE(Int, "Decimal Places") then
                            ERROR(Text5272723);
                    end;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Report-Type", "Report-ID", Position, Priority)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text5272725: Label 'In this Report-Type is no Report-ID allowed.', Comment = 'DEU="Für die Berichtsart ist keine Berichts-Nummer zulässig."';
        Text5272724: Label 'Position 0 is not allowed!.', Comment = 'DEU="Für diese Berichtsart ist Berichts-Nr. 0 nicht zulässig."';
        Text5272723: Label 'Typing is not correct. A correct entry would be for example\\1      A minimum of 1 and a maximum of 1 decimal place\1:4   A minimum of 1 and a maximum of 4 decimal places\2:     At least 2 decimal places\:2     No more than 2 decimal places.', Comment = 'DEU="Eingabe ist nicht korrekt. Eine korrekte Eingabe wäre z.B.\\1      mindestens 1 und maximal 1 Dezimalstelle\1:4   Ein Minimum von 1 und einem Maximum von 4 Dezimalstellen\2:"';
        Text5272722: Label 'Decimal places only valid for parameters with decimal type.', Comment = 'DEU=""';
        Text5272728: Label '%1 are not part of your solution.', Comment = 'DEU="Decimal Stellen nur bei Parametern vom Typ Decimal einstellbar."';
        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
        UseFilter: Option SETRANGE,SETFILTER;
        ParamSetupRec: Record "LBT Report - Attribute Setup";
}

