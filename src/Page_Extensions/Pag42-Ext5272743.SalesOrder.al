pageextension 5272743 "LBT Sales Order" extends "Sales Order"
{
    // version NAVW111.00.00.19846,LBCOR1.00

    actions
    {
        addafter(ActionGroupCRM)
        {
            group("LBT correspondence documents")
            {
                Caption = 'correspondence documents';
                action("Tot&aling")
                {
                    ApplicationArea = All;
                    Caption = 'Tot&aling';
                    Image = Totals;
                    trigger OnAction()
                    var
                        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
                    begin
                        LeBitCorrespDocMgt.SalesLineIndentTotaling(Rec);
                    end;
                }
                action("LBT Num&bering")
                {
                    ApplicationArea = All;
                    Caption = 'Num&bering';
                    Image = NumberGroup;
                    trigger OnAction()
                    var
                        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
                    begin
                        LeBitCorrespDocMgt.SalesLinePosNumber(Rec);
                    end;
                }
                action("LBT Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
                    end;
                }
                action("LBT Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SourceRecRef.GETTABLE(Rec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Footer);
                    end;
                }
                action("LBT Invoice Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Header Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Shipment/Receipt";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := SalesHeaderLRec."Document Type"::Invoice;
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
                    end;
                }
                action("LBT Invoice Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Shipment/Receipt";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := SalesHeaderLRec."Document Type"::Invoice;
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Footer);
                    end;
                }
                action("LBT Shipment Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Header Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Shipment/Receipt";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := DocType::"Shipment/Receipt";
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Header);
                    end;
                }
                action("LBT Shipment Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Shipment/Receipt";
                        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := DocType::"Shipment/Receipt";
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LeBitLongtextMgt.ShowLongtextLines(SourceRecRef, Position::Footer);
                    end;
                }
            }
        }
    }
}

