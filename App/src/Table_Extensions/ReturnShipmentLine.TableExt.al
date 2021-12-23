tableextension 50734 "lbt Return Shipment Line" extends "Return Shipment Line"
{
    fields
    {
        field(50720; "lbt Long Text"; Boolean)
        {
            CalcFormula = Exist("lbt Posted PS Longtext Line" WHERE("Table ID" = CONST(6651),
                                                                       "Document No." = FIELD("Document No."),
                                                                       Position = CONST(Longtext),
                                                                       "Document Line No." = FIELD("Line No.")));
            Caption = 'Long Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50721; "lbt Printoption"; Option)
        {
            Caption = 'Printoption';
            OptionCaption = 'Standard,Title,,Price Invisible,Line Invisible,Alternative,Optional,New Page,Begin Total,End Total';
            OptionMembers = Standard,Title,,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total";
            DataClassification = CustomerContent;
        }
        field(50722; "lbt Summation"; Text[250])
        {
            Caption = 'Summation';
            TableRelation = "Purch. Rcpt. Line"."Line No." WHERE("Document No." = FIELD("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(50723; "lbt Balance"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50724; "lbt Pos. No."; Text[30])
        {
            Caption = 'Pos.No.';
            DataClassification = CustomerContent;
        }
        field(50725; "lbt Indentation"; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;
            DataClassification = CustomerContent;
        }

        field(50726; "lbt Source Document Line No."; Integer)
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Removed';
            Caption = 'Source Document Line No.';
            DataClassification = CustomerContent;
        }
        field(50727; "lbt Printoption StyleExpr"; Text[30])
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Removed';
            Caption = 'lbt Printoption StyleExpr';
            DataClassification = CustomerContent;
        }
    }
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue() Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(rec, enum::"lbt Position"::EditorLine, 0));
    end;

    procedure lbtEditData()
    var

    begin
        EditorHelper.editData(rec, enum::"lbt Position"::EditorLine, 0);
    end;
}

