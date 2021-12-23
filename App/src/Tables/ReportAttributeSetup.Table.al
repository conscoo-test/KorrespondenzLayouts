table 50725 "lbt Report - Attribute Setup"
{
    // version LBCOR1.00

    Caption = 'Report - Attribute Setup';

    fields
    {
        field(1; "Report-Type"; Option)
        {
            Caption = 'Report-Type';
            OptionCaption = 'Purchase,Sales,QA,Production,Delivery,Report';
            OptionMembers = Purchase,Sales,QA,Production,Delivery,"Report";
            DataClassification = CustomerContent;
        }
        field(2; "Report-ID"; Integer)
        {
            Caption = 'Report-ID';
            TableRelation = IF ("Report-Type" = CONST(Report)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Report-Type" = "Report-Type"::Report) and ("Report-ID" = 0) then
                    ERROR(PosZeroErr);
            end;
        }
        field(3; Position; Integer)
        {
            Caption = 'Position';
            MinValue = 1;
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(4; Priority; Integer)
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
        }
        field(5; ID; Integer)
        {
            Caption = 'Parameter';
            TableRelation = "Item Attribute";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
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
            Caption = 'Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Control Unit of Measure Code"; Code[30])
        {
            Caption = 'Control Unit of Measure Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "Additional Character"; Text[30])
        {
            Caption = 'Additional Character';
            DataClassification = CustomerContent;
        }
        field(9; "Permit Description"; Boolean)
        {
            Caption = 'Permit Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ParamSetupRec.Reset();
                ParamSetupRec.SETRANGE("Report-Type", "Report-Type");
                ParamSetupRec.SETRANGE("Report-ID", "Report-ID");
                if ParamSetupRec.FINDSET(true) then
                    repeat
                        if not ((ParamSetupRec.Position = Position) and (ParamSetupRec.Priority = Priority)) then begin
                            ParamSetupRec."Permit Description" := "Permit Description";
                            ParamSetupRec.Modify();
                        end;
                    until ParamSetupRec.Next() = 0;
            end;
        }
        field(10; "Decimal Places"; Text[30])
        {
            Caption = 'Decimal Places';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ItemAttribute: Record "Item Attribute";
                Int: Integer;
            begin
                if ("Decimal Places" <> '') and
                   (ID <> 0)
                then begin
                    ItemAttribute.GET(ID);
                    if ItemAttribute.Type <> ItemAttribute.Type::Decimal then
                        ERROR(DecimalPlacesErr);
                    if STRPOS("Decimal Places", ':') <> 0 then begin
                        if not EVALUATE(Int, DELSTR("Decimal Places", STRPOS("Decimal Places", ':'), 1)) then
                            ERROR(TypingErr);
                    end else
                        if not EVALUATE(Int, "Decimal Places") then
                            ERROR(TypingErr);

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
        ParamSetupRec: Record "lbt Report - Attribute Setup";
        PosZeroErr: Label 'Position 0 is not allowed!.';
        TypingErr: Label 'Typing is not correct. A correct entry would be for example\\1      A minimum of 1 and a maximum of 1 decimal place\1:4   A minimum of 1 and a maximum of 4 decimal places\2:     At least 2 decimal places\:2     No more than 2 decimal places.';
        DecimalPlacesErr: Label 'Decimal places only valid for parameters with decimal type.';
}

