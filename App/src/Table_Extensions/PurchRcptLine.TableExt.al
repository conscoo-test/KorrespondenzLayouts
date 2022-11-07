tableextension 5272723 "lbt Purch. Rcpt. Line" extends "Purch. Rcpt. Line"
{

    fields
    {
        field(5272720; "lbt Long Text"; Boolean)
        {
            CalcFormula = Exist("lbt Posted PS Longtext Line" where("Table ID" = const(121),
                                                                       "Document No." = field("Document No."),
                                                                       Position = const(Longtext),
                                                                       "Document Line No." = field("Line No.")));
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
            TableRelation = "Purch. Rcpt. Line"."Line No." where("Document No." = field("Document No."));
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
        field(5272730; "lbt cl Price Factor"; Enum "lbt cl Price Factor")
        {
            Caption = 'Price Factor';
            DataClassification = CustomerContent;
        }
        field(5272731; "lbt cl Price in Price Factor"; Decimal)
        {
            Caption = 'Unit Price in Price Factor';
            DataClassification = CustomerContent;
            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FieldNo("lbt cl Price in Price Factor"));
        }
    }
    trigger OnInsert()
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        LeBitCorrespDocSingleInst: Codeunit "lbt Corresp. Doc. SingleInst";
    begin
        LeBitCorrespDocSingleInst.CopyLongTextForPostDropOrderShipment(PurchRcptHeader, Rec, 1, 1);
    end;

    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    procedure lbtHasEditorValue() Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(rec, Enum::"lbt Position"::EditorLine, 0));
    end;

    procedure lbtEditData()
    var

    begin
        EditorHelper.ShowData(rec, Enum::"lbt Position"::EditorLine, 0);
    end;

}

