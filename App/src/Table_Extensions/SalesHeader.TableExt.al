tableextension 5272728 "lbt Sales Header" extends "Sales Header"
{
    fields
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                CopyLongTextFromCustomer();
            end;
        }
    }

    trigger OnAfterInsert()
    begin
        CopyLongTextFromCustomer();
    end;

    var
        EditorHelper: Codeunit "lbt cl EditorHelper";

    trigger OnDelete()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.DelLongtext(Rec);
    end;

    procedure lbtTransferPSLongtextLineToTemp(var PSLongtextLine: Record "lbt PS Longtext Line"; var TempPSLongtextLine: Record "lbt PS Longtext Line" temporary)
    begin
        if PSLongtextLine.FindSet() then
            repeat
                TempPSLongtextLine.Init();
                TempPSLongtextLine := PSLongtextLine;
                TempPSLongtextLine.Insert();
            until PSLongtextLine.Next() = 0;
        PSLongtextLine.DeleteAll();
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
        exit(EditorHelper.editorVisible(database::"sales header"));
    end;

    local procedure CopyLongTextFromCustomer()
    var
        Customer: Record Customer;
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        if Rec."No." = '' then
            exit;
        if Rec."Sell-to Customer No." <> '' then
            if Customer.Get(Rec."Sell-to Customer No.") then
                LongtextMgt.CopyLongtext(Customer, Rec);
    end;

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(rec, Rec."Document Type".AsInteger());
    end;


}

