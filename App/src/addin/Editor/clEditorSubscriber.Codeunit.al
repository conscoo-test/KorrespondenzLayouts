codeunit 5272730 "lbt cl EditorSubscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnAfterServShptItemLineInsert', '', true, true)]
    local procedure ServDocumentsMgt_OnAfterServShptItemLineInsert(ServiceItemLine: Record "Service Item Line"; var ServiceShptItemLine: Record "Service Shipment Item Line")
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.CopyLongtext(ServiceItemLine, ServiceShptItemLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnAfterServInvLineInsert', '', true, true)]
    local procedure ServDocumentsMgt_OnAfterServInvLineInsert(ServiceLine: Record "Service Line"; var ServiceInvoiceLine: Record "Service Invoice Line")
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.CopyLongtext(ServiceLine, ServiceInvoiceLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnAfterServShptLineInsert', '', true, true)]
    local procedure ServDocumentsMgt_OnAfterServShptLineInsert(ServiceLine: Record "Service Line"; var ServiceShipmentLine: Record "Service Shipment Line")
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.CopyLongtext(ServiceLine, ServiceShipmentLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnAfterServCrMemoLineInsert', '', true, true)]
    local procedure ServDocumentsMgt_OnAfterServCrMemoLineInsert(ServiceLine: Record "Service Line"; var ServiceCrMemoLine: Record "Service Cr.Memo Line")
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LongtextMgt.CopyLongtext(ServiceLine, ServiceCrMemoLine);
    end;

}
