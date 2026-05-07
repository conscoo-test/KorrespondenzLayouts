tableextension 5272760 "lbt cl JobPlanningLine" extends "Job Planning Line"
{

    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                Validate("lbt Printoption", xRec."lbt Printoption");
                "lbt Pos. No." := xRec."lbt Pos. No.";
            end;
        }
        field(5272724; "lbt Pos. No."; Text[30])
        {
            Caption = 'Pos.No.';
            DataClassification = CustomerContent;
        }
        field(5272721; "lbt Printoption"; Enum "lbt cl Printoption")
        {
            Caption = 'Printoption';
            DataClassification = CustomerContent;
            ValuesAllowed = Standard, Title, "Price Invisible", "Line Invisible", Alternative, Optional, "New Page", "Begin Total", "End Total", Bold;

            trigger OnValidate()
            begin
                if "lbt Printoption" = "lbt Printoption"::"New Page" then begin
                    if "No." <> '' then
                        Error(NewPageErr);
                    Validate(Type, Type::Text);
                    Description := NewPageLbl;
                end;
            end;
        }

        field(5272725; "lbt Indentation"; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
    }
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";
        NewPageErr: Label 'New Pages can only be set in blank lines.';
        NewPageLbl: Label '--- New Page ---';

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongTextSysId(Rec);
    end;

    procedure lbtEditData()
    begin
        EditorHelper.editDataSysId(Rec, Enum::"lbt Position"::EditorLine, 0);
    end;

    procedure lbtGetPrintData(): Text
    begin
        exit(EditorHelper.getPrintDataSysId(Rec, Enum::"lbt Position"::EditorLine, 0));
    end;

    procedure lbtHasEditorValue() Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValueSysId(Rec, Enum::"lbt Position"::EditorLine, 0)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;
}
