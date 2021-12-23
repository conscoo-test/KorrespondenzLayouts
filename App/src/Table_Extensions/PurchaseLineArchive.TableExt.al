tableextension 50733 "lbt Purchase Line Archive" extends "Purchase Line Archive"
{
    fields
    {
        field(5272720; "lbt Long Text"; Boolean)
        {
            CalcFormula = Exist("lbt Archive PS Longtext Line" WHERE("Table ID" = CONST(5110),
                                                                        "Document Type" = FIELD("Document Type"),
                                                                        "Document No." = FIELD("Document No."),
                                                                        Position = CONST(Longtext),
                                                                        "Document Line No." = FIELD("Line No."),
                                                                        "Version No." = FIELD("Version No."),
                                                                        "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence")));
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
            TableRelation = "Purchase Line Archive"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                                      "Document No." = FIELD("Document No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(5272723; "lbt Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line Archive"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                           "Document No." = FIELD("Document No."),
                                                                           "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                                                           "Version No." = FIELD("Version No."),
                                                                           "Line No." = FIELD(FILTER("lbt Summation"))));
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
    }
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnDelete()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(Rec);
    end;

    procedure lbtHasEditorValue(docType: integer) Result: Boolean
    var

    begin
        exit(EditorHelper.hasEditorValue(rec, enum::"lbt Position"::EditorLine, doctype));
    end;

    procedure lbtEditData(doctype: integer)
    var

    begin
        EditorHelper.editData(rec, enum::"lbt Position"::EditorLine, doctype);
    end;

    procedure lbtGetPrintData(Position: enum "lbt Position"; docType: integer): Text
    begin
        exit(EditorHelper.getPrintData(rec, Position, docType));
    end;
}

