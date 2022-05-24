codeunit 5272730 "lbt cl EditorSubscriber"
{
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnAfterServShptItemLineInsert', '', true, true)]
    local procedure ServDocumentsMgt_OnAfterServShptItemLineInsert(ServiceItemLine: Record "Service Item Line"; var ServiceShptItemLine: Record "Service Shipment Item Line")
    begin
        LongtextMgt.CopyLongtext(ServiceItemLine, ServiceShptItemLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnAfterServInvLineInsert', '', true, true)]
    local procedure ServDocumentsMgt_OnAfterServInvLineInsert(ServiceLine: Record "Service Line"; var ServiceInvoiceLine: Record "Service Invoice Line")
    begin
        LongtextMgt.CopyLongtext(ServiceLine, ServiceInvoiceLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnAfterServShptLineInsert', '', true, true)]
    local procedure ServDocumentsMgt_OnAfterServShptLineInsert(ServiceLine: Record "Service Line"; var ServiceShipmentLine: Record "Service Shipment Line")
    begin
        LongtextMgt.CopyLongtext(ServiceLine, ServiceShipmentLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnAfterServCrMemoLineInsert', '', true, true)]
    local procedure ServDocumentsMgt_OnAfterServCrMemoLineInsert(ServiceLine: Record "Service Line"; var ServiceCrMemoLine: Record "Service Cr.Memo Line")
    begin
        LongtextMgt.CopyLongtext(ServiceLine, ServiceCrMemoLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service-Post", 'OnAfterPostServiceDoc', '', true, true)]
    local procedure ServicePost_OnAfterPostServiceDoc(ServCrMemoNo: Code[20]; ServShipmentNo: Code[20]; ServInvoiceNo: Code[20]; var ServiceHeader: Record "Service Header")
    var
        ServShptHdr: Record "Service Shipment Header";
        ServInvHdr: Record "Service Invoice Header";
        ServCrMemoHdr: Record "Service Cr.Memo Header";
    begin
        if ServShipmentNo <> '' then
            if ServShptHdr.Get(ServShipmentNo) then
                LongtextMgt.CopyLongtext(ServiceHeader, ServShptHdr);
        if ServInvoiceNo <> '' then
            if ServInvHdr.Get(ServInvoiceNo) then
                LongtextMgt.CopyLongtext(ServiceHeader, ServInvHdr);
        if ServCrMemoNo <> '' then
            if ServCrMemoHdr.Get(ServCrMemoNo) then
                LongtextMgt.CopyLongtext(ServiceHeader, ServCrMemoHdr);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServContractQuote-Tmpl. Upd.", 'OnAfterApplyTemplate', '', true, true)]
    local procedure ServContractQuoteTmplUpd_OnAfterApplyTemplate(ServiceContractTemplate: Record "Service Contract Template"; var ServiceContractHeader: Record "Service Contract Header")
    begin
        LongtextMgt.CopyLongtext(ServiceContractTemplate, ServiceContractHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::SignServContractDoc, 'OnAfterToServContractHeaderInsert', '', true, true)]
    local procedure SignServContractDoc_OnAfterToServContractHeaderInsert(FromServiceContractHeader: Record "Service Contract Header"; var ToServiceContractHeader: Record "Service Contract Header")
    begin
        LongtextMgt.CopyLongtext(FromServiceContractHeader, ToServiceContractHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::SignServContractDoc, 'OnAfterToServContractLineInsert', '', true, true)]
    local procedure SignServContractDoc_OnAfterToServContractLineInsert(FromServiceContractLine: Record "Service Contract Line"; var ToServiceContractLine: Record "Service Contract Line")
    begin
        LongtextMgt.CopyLongtext(FromServiceContractLine, ToServiceContractLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::SignServContractDoc, 'OnAfterCreateServiceLinesLedgerEntries', '', true, true)]
    local procedure SignServContractDoc_OnAfterCreateServiceLinesLedgerEntries(ServiceContractHeader: Record "Service Contract Header"; var ServiceHeader: Record "Service Header")
    begin
        LongtextMgt.CopyLongtext(ServiceContractHeader, ServiceHeader);
    end;


}
