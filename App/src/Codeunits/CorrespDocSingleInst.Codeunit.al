codeunit 5272722 "lbt Corresp. Doc. SingleInst"
{
    // version LBCOR1.00

    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
        ProcessingPostCombineSalesOrderShipment: Boolean;
        ProcessingPostDropOrderShipment: Boolean;
        WithPurchHeader: Boolean;
        WithSalesHeader: Boolean;

    procedure CopyLongTextForPostCombineSalesOrderShipment(SalesShipmentHeader: Record "Sales Shipment Header"; SalesShipmentLine: Record "Sales Shipment Line"; EventType: Option OnBefore,Processing,OnAfter; Type: Option Header,Lines)
    var
        SalesOrderHeader: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        case EventType of
            EventType::OnBefore:
                ProcessingPostCombineSalesOrderShipment := true;
            EventType::Processing:
                if ProcessingPostCombineSalesOrderShipment then
                    case Type of
                        Type::Header:
                            begin
                                SalesOrderHeader.Get(SalesOrderHeader."Document Type"::Order, SalesShipmentHeader."Order No.");
                                SourceRecRef.GetTable(SalesOrderHeader);
                                TargetRecRef.GetTable(SalesShipmentHeader);
                                LongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
                            end;
                        Type::Lines:
                            begin
                                SalesOrderLine.Get(SalesOrderLine."Document Type"::Order, SalesShipmentLine."Order No.", SalesShipmentLine."Order Line No.");
                                SourceRecRef.GetTable(SalesOrderLine);
                                TargetRecRef.GetTable(SalesShipmentLine);
                                LongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
                            end;
                    end;

            EventType::OnAfter:
                ProcessingPostCombineSalesOrderShipment := false;
        end;
    end;

    procedure CopyLongTextForPostDropOrderShipment(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchRcptLine: Record "Purch. Rcpt. Line"; EventType: Option OnBefore,Processing,OnAfter; Type: Option Header,Lines)
    var
        PurchaseOrderHeader: Record "Purchase Header";
        PurchaseOrderLine: Record "Purchase Line";
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
    begin
        case EventType of
            EventType::OnBefore:
                ProcessingPostDropOrderShipment := true;
            EventType::Processing:
                if ProcessingPostDropOrderShipment then
                    case Type of
                        Type::Header:
                            begin
                                PurchaseOrderHeader.Get(PurchaseOrderHeader."Document Type"::Order, PurchRcptHeader."Order No.");
                                SourceRecRef.GetTable(PurchaseOrderHeader);
                                TargetRecRef.GetTable(PurchRcptHeader);
                                LongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
                            end;
                        Type::Lines:
                            begin
                                PurchaseOrderLine.Get(PurchaseOrderLine."Document Type"::Order, PurchRcptLine."Order No.", PurchRcptLine."Order Line No.");
                                SourceRecRef.GetTable(PurchaseOrderLine);
                                TargetRecRef.GetTable(PurchRcptLine);
                                LongtextMgt.CopyLongtext(SourceRecRef, TargetRecRef);
                            end;
                    end;

            EventType::OnAfter:
                ProcessingPostDropOrderShipment := false;
        end;
    end;

    procedure GetWithPurchHeader(): Boolean
    begin
        exit(WithPurchHeader);
    end;

    procedure GetWithSalesHeader(): Boolean
    begin
        exit(WithSalesHeader);
    end;

    procedure SetWithPurchHeader(WithPurchHeaderVar: Boolean)
    begin
        WithPurchHeader := WithPurchHeaderVar;
    end;

    procedure SetWithSalesHeader(WithSalesHeaderVar: Boolean)
    begin
        WithSalesHeader := WithSalesHeaderVar;
    end;
}
