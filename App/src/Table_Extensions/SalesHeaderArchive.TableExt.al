tableextension 5272739 "lbt Sales Header Archive" extends "Sales Header Archive"
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
    end;

    procedure lbtHasEditorValue(Position: enum "lbt Position"; docType: Integer) Result: Text
    begin
        exit(format(EditorHelper.hasEditorValue(rec, Position, doctype)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
    end;

    procedure lbtEditData(Position: enum "lbt Position"; docType: Integer)
    begin
        EditorHelper.editData(rec, Position, docType);
    end;

    procedure lbtGetPrintData(Position: enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintData(rec, Position, docType));
    end;

    procedure lbtEditorVisible(): Boolean
    begin
        exit(EditorHelper.editorVisible(database::"Sales Header Archive"));
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(rec, Rec."Document Type".AsInteger());
    end;


}