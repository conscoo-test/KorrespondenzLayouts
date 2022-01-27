tableextension 5272732 "lbt Sales Line Archive" extends "Sales Line Archive"
{
    fields
    {
        field(5272720; "lbt Long Text"; Boolean)
        {
            CalcFormula = Exist("lbt Archive PS Longtext Line" where("Table ID" = const(5108),
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
            TableRelation = "Sales Line Archive"."Line No." where("Document Type" = field("Document Type"),
                                                                   "Document No." = field("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(5272723; "lbt Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line Archive"."Line Amount" where("Document Type" = field("Document Type"),
                                                                        "Document No." = field("Document No."),
                                                                        "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                                                        "Version No." = field("Version No."),
                                                                        "Line No." = field(filter("lbt Summation"))));
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
    }
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnDelete()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(Rec);
    end;

    procedure lbtHasEditorValue(docType: Integer) Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(rec, Enum::"lbt Position"::EditorLine, doctype));
    end;

    procedure lbtEditData(doctype: Integer)
    var

    begin
        EditorHelper.editData(rec, Enum::"lbt Position"::EditorLine, doctype);
    end;

    procedure lbtGetPrintData(Position: enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintData(rec, Position, docType));
    end;
}

