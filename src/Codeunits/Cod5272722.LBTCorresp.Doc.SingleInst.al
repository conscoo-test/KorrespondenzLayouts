codeunit 5272722 "LBT Corresp. Doc. SingleInst"
{
    // version LBCOR1.00

    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
        ProcessingPostDropOrderShipment: Boolean;
        ProcessingPostCombineSalesOrderShipment: Boolean;
        WithSalesHeader: Boolean;
        WithPurchHeader: Boolean;
        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
        FromSalesReturnOrder: Boolean;

    procedure CopyLongTextForPostDropOrderShipment(var PurchRcptHeader: Record "Purch. Rcpt. Header";var PurchRcptLine: Record "Purch. Rcpt. Line";EventType: Option OnBefore,Processing,OnAfter;Type: Option Header,Lines)
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
        PurchaseOrderHeader: Record "Purchase Header";
        PurchaseOrderLine: Record "Purchase Line";
    begin
        case EventType of
          EventType::OnBefore: ProcessingPostDropOrderShipment := true;
          EventType::Processing:
            if ProcessingPostDropOrderShipment then begin
              case Type of
                Type::Header:
                  begin
                    PurchaseOrderHeader.GET(PurchaseOrderHeader."Document Type"::Order,PurchRcptHeader."Order No.");
                    SourceRecRef.GETTABLE(PurchaseOrderHeader);
                    TargetRecRef.GETTABLE(PurchRcptHeader);
                    LeBitLongtextMgt.CopyLongtext(SourceRecRef,TargetRecRef);
                  end;
                Type::Lines:
                  begin
                    PurchaseOrderLine.GET(PurchaseOrderLine."Document Type"::Order,PurchRcptLine."Order No.",PurchRcptLine."Order Line No.");
                    SourceRecRef.GETTABLE(PurchaseOrderLine);
                    TargetRecRef.GETTABLE(PurchRcptLine);
                    LeBitLongtextMgt.CopyLongtext(SourceRecRef,TargetRecRef);
                  end;
              end;
            end;
          EventType::OnAfter: ProcessingPostDropOrderShipment := false;
        end;
    end;

    procedure CopyLongTextForPostCombineSalesOrderShipment(SalesShipmentHeader: Record "Sales Shipment Header";SalesShipmentLine: Record "Sales Shipment Line";EventType: Option OnBefore,Processing,OnAfter;Type: Option Header,Lines)
    var
        SourceRecRef: RecordRef;
        TargetRecRef: RecordRef;
        SalesOrderHeader: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
    begin
        case EventType of
          EventType::OnBefore: ProcessingPostCombineSalesOrderShipment := true;
          EventType::Processing:
            if ProcessingPostCombineSalesOrderShipment then begin
              case Type of
                Type::Header:
                  begin
                    SalesOrderHeader.GET(SalesOrderHeader."Document Type"::Order,SalesShipmentHeader."Order No.");
                    SourceRecRef.GETTABLE(SalesOrderHeader);
                    TargetRecRef.GETTABLE(SalesShipmentHeader);
                    LeBitLongtextMgt.CopyLongtext(SourceRecRef,TargetRecRef);
                  end;
                Type::Lines:
                  begin
                    SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,SalesShipmentLine."Order No.",SalesShipmentLine."Order Line No.");
                    SourceRecRef.GETTABLE(SalesOrderLine);
                    TargetRecRef.GETTABLE(SalesShipmentLine);
                    LeBitLongtextMgt.CopyLongtext(SourceRecRef,TargetRecRef);
                  end;
              end;
            end;
          EventType::OnAfter: ProcessingPostCombineSalesOrderShipment := false;
        end;
    end;

    procedure SetWithSalesHeader(WithSalesHeaderVar: Boolean)
    begin
        WithSalesHeader := WithSalesHeaderVar;
    end;

    procedure GetWithSalesHeader(): Boolean
    begin
        exit(WithSalesHeader);
    end;

    procedure SetWithPurchHeader(WithPurchHeaderVar: Boolean)
    begin
        WithPurchHeader := WithPurchHeaderVar;
    end;

    procedure GetWithPurchHeader(): Boolean
    begin
        exit(WithPurchHeader);
    end;
}

