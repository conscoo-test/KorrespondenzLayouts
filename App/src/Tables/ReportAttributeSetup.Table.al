table 5272725 "lbt Report - Attribute Setup"
{
    // version LBCOR1.00

    Caption = 'Report - Attribute Setup';
    LookupPageId = "lbt Report - Attribute Setup";
    DrillDownPageId = "lbt Report - Attribute Setup";
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
            TableRelation = if ("Report-Type" = const(Report)) AllObjWithCaption."Object ID" where("Object Type" = const(Report));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Report-Type" = "Report-Type"::Report) and ("Report-ID" = 0) then
                    Error(PosZeroErr);
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
                    ItemAttribute.Get(ID);
                    Description := ItemAttribute.Name;
                    "Control Unit of Measure Code" := ItemAttribute."Unit of Measure";
                end;
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
                ParamSetupRec.SetRange("Report-Type", "Report-Type");
                ParamSetupRec.SetRange("Report-ID", "Report-ID");
                if ParamSetupRec.FindSet(true) then
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
                    ItemAttribute.Get(ID);
                    if ItemAttribute.Type <> ItemAttribute.Type::Decimal then
                        Error(DecimalPlacesErr);
                    if StrPos("Decimal Places", ':') <> 0 then begin
                        if not Evaluate(Int, DelStr("Decimal Places", StrPos("Decimal Places", ':'), 1)) then
                            Error(TypingErr);
                    end else
                        if not Evaluate(Int, "Decimal Places") then
                            Error(TypingErr);
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
        DecimalPlacesErr: Label 'Decimal places only valid for parameters with decimal type.';
        PosZeroErr: Label 'Position 0 is not allowed!.';
        TypingErr: Label 'Typing is not correct. A correct entry would be for example\\1      A minimum of 1 and a maximum of 1 decimal place\1:4   A minimum of 1 and a maximum of 4 decimal places\2:     At least 2 decimal places\:2     No more than 2 decimal places.';
}
