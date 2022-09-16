tableextension 5272757 "lbt cl Sales Cr.Memo Header" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(5272720; "lbt cl Delivery Date Type"; Enum "lbt cl DeliveryDateType")
        {
            Caption = 'Delivery Date Type';
            DataClassification = CustomerContent;
        }

        field(5272722; "lbt cl Destination"; Code[10])
        {
            Caption = 'Destination';
            DataClassification = CustomerContent;
            TableRelation = "Entry/Exit Point";
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
