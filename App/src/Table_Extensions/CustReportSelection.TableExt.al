#if CLEAN1_8
tableextension 5272766 "lbt cl Cust. Report Selection" extends "Custom Report Selection"
{
    procedure lbtEditData(Position: Enum "lbt Position")
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";
        RecRef: RecordRef;
        DocType: Enum "Sales Document Type";
    begin
        RecRef := GetRecRef();
        DocType := GetDocType();
        EditorHelper.editData(RecRef, Position, DocType.AsInteger());
    end;

    procedure lbtHasEditorValue(Position: Enum "lbt Position") Result: Text
    var
        EditorHelper: Codeunit "lbt cl EditorHelper";
        RecRef: RecordRef;
        DocType: Enum "Sales Document Type";
    begin
        RecRef := GetRecRef();
        DocType := GetDocType();
        exit(Format(EditorHelper.hasEditorValue(RecRef, Position, DocType.AsInteger())));
    end;

    local procedure GetDocType() DocType: Enum "Sales Document Type"
    begin
        case Usage of
            Usage::"S.Quote":
                DocType := DocType::Quote;
            Usage::"S.Order":
                DocType := DocType::Order;
            Usage::"S.Invoice":
                DocType := DocType::Invoice;
            Usage::"S.Cr.Memo":
                DocType := DocType::"Credit Memo";
            Usage::"S.Shipment":
                DocType := DocType::"lbt cl Shipment/Receipt";
            else
                lbtclOnElseGetDocType(Rec, DocType);
        end;
    end;

    local procedure GetRecRef() RecordRef: RecordRef
    var
        Customer: Record Customer;
    begin
        case "Source Type" of
            Database::Customer:
                begin
                    Customer.Get("Source No.");
                    RecordRef.GetTable(Customer);
                end;
            else
                lbtclGetRecRef(Rec, RecordRef);
        end;
    end;

    [Obsolete('Moved Texts to Vendor/Customer', '1.8')]
    [IntegrationEvent(true, false)]
    local procedure lbtclGetRecRef(Rec: Record "Custom Report Selection"; var RecordRef: RecordRef)
    begin
    end;

    [Obsolete('Moved Texts to Vendor/Customer', '1.8')]
    [IntegrationEvent(true, false)]
    local procedure lbtclOnElseGetDocType(Rec: Record "Custom Report Selection"; var DocType: Enum "Sales Document Type")
    begin
    end;
}
#endif