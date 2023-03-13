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
        modify("Ship-to Code")
        {
            trigger OnAfterValidate()
            begin
                CopyLongTextFromCustomer();
            end;
        }
        field(5272720; "lbt cl Delivery Date Type"; Enum "lbt cl DeliveryDateType")
        {
            Caption = 'Delivery Date Type';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if ("lbt cl Delivery Date Type" <> xRec."lbt cl Delivery Date Type") then
                    MessageIfSalesLinesExist(FieldCaption("lbt cl Delivery Date Type"));
            end;
        }
        field(5272722; "lbt cl Destination"; Code[10])
        {
            Caption = 'Destination';
            DataClassification = CustomerContent;
            TableRelation = "Entry/Exit Point";
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

    trigger OnAfterDelete()
    begin
        EditorHelper.deleteLongText(Rec, Rec."Document Type".AsInteger());
    end;

    procedure lbtclSetAdditionalFields()
    var
        Cust: Record Customer;
        ShiptoAddr: Record "Ship-to Address";
        destination: Code[10];
        DeliveryDateType: Enum "lbt cl DeliveryDateType";
    begin
        if Cust.Get("Sell-to Customer No.") then begin
            destination := Cust."lbt cl Destination";
            DeliveryDateType := Cust."lbt cl Delivery Date Type";
        end;
        if Rec."Ship-to Code" <> '' then
            if ShiptoAddr.Get("Sell-to Customer No.", "Ship-to Code") then begin
                if ShiptoAddr."lbt cl Destination" <> '' then
                    destination := ShiptoAddr."lbt cl Destination";
                DeliveryDateType := ShiptoAddr."lbt cl Delivery Date Type";
            end;
        if Rec."lbt cl Destination" <> destination then
            Rec.Validate("lbt cl Destination", destination);
        if Rec."lbt cl Delivery Date Type" <> DeliveryDateType then
            Rec.Validate("lbt cl Delivery Date Type", DeliveryDateType);
    end;

    procedure lbtEditData(Position: Enum "lbt Position"; docType: Integer)
    begin
        EditorHelper.editData(Rec, Position, docType);
    end;

    procedure lbtEditorVisible(): Boolean
    begin
        exit(EditorHelper.editorVisible(Database::"Sales Header"));
    end;

    procedure lbtGetPrintData(Position: Enum "lbt Position"; docType: Integer): Text
    begin
        exit(EditorHelper.getPrintData(Rec, Position, docType));
    end;

    procedure lbtHasEditorValue(Position: Enum "lbt Position"; docType: Integer) Result: Text
    begin
        exit(Format(EditorHelper.hasEditorValue(Rec, Position, docType)));
        //exit(EditorHelper.hasEditorValue(rec, Position));
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

    local procedure CopyLongTextFromCustomer()
    var
        Customer: Record Customer;
        ShiptoAddr: Record "Ship-to Address";
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        if Rec."No." = '' then
            exit;

        LongtextMgt.DelLongtext(Rec);
        if Rec."Sell-to Customer No." <> '' then
            if Customer.Get(Rec."Sell-to Customer No.") then
                LongtextMgt.CopyLongtext(Customer, Rec);
        if Rec."Ship-to Code" <> '' then
            if ShiptoAddr.Get(Rec."Sell-to Customer No.", "Ship-to Code") then
                LongtextMgt.CopyLongtext(ShiptoAddr, Rec);

    end;
}
