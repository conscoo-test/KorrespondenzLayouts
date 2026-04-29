tableextension 5272732 "lbt Sales Line Archive" extends "Sales Line Archive"
{
    fields
    {
        field(5272720; "lbt Long Text"; Boolean)
        {
            CalcFormula = exist("lbt Archive PS Longtext Line" where("Table ID" = const(5108),
                                                                        "Document Type" = field("Document Type"),
                                                                        "Document No." = field("Document No."),
                                                                        Position = const(Longtext),
                                                                        "Document Line No." = field("Line No."),
                                                                        "Version No." = field("Version No."),
                                                                        "Doc. No. Occurrence" = field("Doc. No. Occurrence")));
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
            TableRelation = "Sales Line Archive"."Line No." where("Document Type" = field("Document Type"),
                                                                   "Document No." = field("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(5272723; "lbt Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line Archive"."Line Amount" where("Document Type" = field("Document Type"),
                                                                        "Document No." = field("Document No."),
                                                                        "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                                                        "Version No." = field("Version No."),
                                                                        "Line No." = field(filter("lbt Summation")),
                                                                        "lbt Printoption" = filter(<> Alternative & <> Optional & <> "Price Invisible" & <> "Line Invisible")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Sales Line Archive"."Line No." where("Document Type" = field("Document Type"),
                                                                   "Document No." = field("Document No."));
        }
        field(5272724; "lbt Pos. No."; Text[30])
        {
            Caption = 'Pos.No.';
            DataClassification = CustomerContent;
        }
        field(5272725; "lbt Indentation"; Integer)
        {
            Caption = 'Indentation';
            DataClassification = CustomerContent;
            MinValue = 0;
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
        field(5272732; "lbt Special Qty"; Decimal)
        {
            Caption = 'Special Quantity';
            DataClassification = CustomerContent;
        }
    }
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnDelete()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(Rec);
    end;

    procedure lbtEditData(doctype: Integer)
    var

    begin
        EditorHelper.ShowData(Rec, Enum::"lbt Position"::EditorLine, doctype);
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, docType));
    end;

    procedure lbtHasEditorValue(docType: Integer) Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(Rec, Enum::"lbt Position"::EditorLine, docType));
    end;
}
