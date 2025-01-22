tableextension 5272735 "lbt Return Receipt Line" extends "Return Receipt Line"
{
    fields
    {
        field(5272720; "lbt Long Text"; Boolean)
        {
            CalcFormula = exist("lbt Posted PS Longtext Line" where("Table ID" = const(6661),
                                                                       "Document No." = field("Document No."),
                                                                       Position = const(Longtext),
                                                                       "Document Line No." = field("Line No.")));
            Caption = 'Long Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5272721; "lbt Printoption"; Enum "lbt cl Printoption")
        {
            Caption = 'Printoption';
            DataClassification = CustomerContent;
        }
        field(5272722; "lbt Summation"; Text[250])
        {
            Caption = 'Summation';
            TableRelation = "Purch. Rcpt. Line"."Line No." where("Document No." = field("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(5272723; "lbt Balance"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
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
            ObsoleteState = Removed;
            ObsoleteReason = 'Removed';
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
        field(5272729; "lbt cl Delivery Date Type"; Enum "lbt cl DeliveryDateType")
        {
            Caption = 'Delivery Date Type';
            DataClassification = CustomerContent;
        }
    }
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtEditData()
    var

    begin
        EditorHelper.ShowData(Rec, Enum::"lbt Position"::EditorLine, 0);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, 0));
    end;

    procedure lbtHasEditorValue() Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(Rec, Enum::"lbt Position"::EditorLine, 0));
    end;
}
