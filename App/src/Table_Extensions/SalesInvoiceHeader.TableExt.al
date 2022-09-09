tableextension 5272756 "lbt cl Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(5272720; "lbt cl Delivery Date Type"; Enum "lbt cl DeliveryDateTime")
        {
            Caption = 'Delivery Date Type';
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
        EditorHelper.deleteLongText(Rec);
    end;

    procedure lbtHasEditorValue(Position: Enum "lbt Position") Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValue(Rec, Position)));
    end;

    procedure lbtEditData(Position: Enum "lbt Position")
    begin
        EditorHelper.editData(Rec, Position);
    end;
}

