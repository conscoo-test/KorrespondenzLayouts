pageextension 5272743 "lbt Sales Order" extends "Sales Order"
{
    // version NAVW111.00.00.19846,LBCOR1.00

    actions
    {
        addafter("O&rder")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit365 Correspondence layout';
                action("lbt Tot&aling")
                {
                    ApplicationArea = All;
                    Caption = 'Totaling';
                    ToolTip = 'Creates a total of the line items "From total" / "To total"';
                    Image = Totals;
                    trigger OnAction()
                    var
                        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
                    begin
                        LeBitCorrespDocMgt.SalesLineIndentTotaling(Rec);
                    end;
                }
                action("lbt Num&bering")
                {
                    ApplicationArea = All;
                    Caption = 'Numbering';
                    ToolTip = 'Specified a numbering of the line positions"';
                    Image = NumberGroup;
                    trigger OnAction()
                    var
                        LeBitCorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";
                    begin
                        LeBitCorrespDocMgt.SalesLinePosNumber(Rec);
                    end;
                }
                action("lbt Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text';
                    ToolTip = 'Specified the Header Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        Position: Option Header,Footer,Longtext;
                    begin
                        LongtextMgt.ShowLongtextLines(Rec, Position::Header);
                    end;
                }
                action("lbt Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Footer Text';
                    ToolTip = 'Specified the Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        Position: Option Header,Footer,Longtext;
                    begin
                        LongtextMgt.ShowLongtextLines(Rec, Position::Footer);
                    end;
                }
                action("lbt Invoice Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Header Text';
                    ToolTip = 'Specified the Invoice Header Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := SalesHeaderLRec."Document Type"::Invoice;
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Header);
                    end;
                }
                action("lbt Invoice Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Footer Text';
                    ToolTip = 'Specified the Invoice Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := SalesHeaderLRec."Document Type"::Invoice;
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Footer);
                    end;
                }
                action("lbt Shipment Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Header Text';
                    ToolTip = 'Specified the Invoice Footer Text';
                    Image = BeginningText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Enum "Sales Document Type";
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := DocType::"Shipment/Receipt";
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Header);
                    end;
                }
                action("lbt Shipment Footer Text")
                {
                    ApplicationArea = All;
                    Caption = 'Shipment Footer Text';
                    ToolTip = 'Specified the Shipment Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        SalesHeaderLRec: Record "Sales Header";
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        SourceRecRef: RecordRef;
                        Position: Option Header,Footer,Longtext;
                        DocType: Enum "Sales Document Type";
                    begin
                        SalesHeaderLRec.TransferFields(Rec);
                        SalesHeaderLRec."Document Type" := DocType::"Shipment/Receipt";
                        SourceRecRef.GETTABLE(SalesHeaderLRec);
                        LongtextMgt.ShowLongtextLines(Rec, Position::Footer);
                    end;
                }
            }
        }
    }
}

