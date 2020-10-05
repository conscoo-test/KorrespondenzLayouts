tableextension 5272720 "lbt Sales Shipment Line" extends "Sales Shipment Line"
{

    fields
    {
        field(5272720; "lbt Long Text"; Boolean)
        {
            CalcFormula = Exist("lbt Posted PS Longtext Line" WHERE("Table ID" = CONST(111),
                                                                       "Document No." = FIELD("Document No."),
                                                                       Position = CONST(Longtext),
                                                                       "Document Line No." = FIELD("Line No.")));
            Caption = 'Long Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5272721; "lbt Printoption"; Option)
        {
            Caption = 'Printoption';
            OptionCaption = 'Standard,Title,,Price Invisible,Line Invisible,Alternative,Optional,New Page,Begin Total,End Total';
            OptionMembers = Standard,Title,,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total";
            DataClassification = CustomerContent;
        }
        field(5272722; "lbt Summation"; Text[250])
        {
            Caption = 'Summation';
            TableRelation = "Sales Shipment Line"."Line No." WHERE("Document No." = FIELD("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(5272723; "lbt Balance"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5272724; "lbt Pos. No."; Text[30])
        {
            Caption = 'Pos.No.';
            DataClassification = CustomerContent;
        }
        field(5272725; "lbt Indentation"; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(5272726; "lbt Source Document Line No."; Integer)
        {
            Caption = 'Source Document Line No.';
            DataClassification = CustomerContent;
        }
        field(5272727; "lbt Printoption StyleExpr"; Text[30])
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Removed';
            Caption = 'lbt Printoption StyleExpr';
            DataClassification = CustomerContent;
        }
    }
    trigger OnInsert()
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        LeBitCorrespDocSingleInst: Codeunit "lbt Corresp. Doc. SingleInst";
    begin
        LeBitCorrespDocSingleInst.CopyLongTextForPostCombineSalesOrderShipment(SalesShipmentHeader, Rec, 1, 1);
    end;
}

