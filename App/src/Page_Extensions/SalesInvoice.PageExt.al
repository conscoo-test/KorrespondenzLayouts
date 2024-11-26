pageextension 5272744 "lbt Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("lbt cl Delivery Date Type"; Rec."lbt cl Delivery Date Type")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you define the Delivery Date Type';
            }
        }
        addlast("Shipping and Billing")
        {
            field("lbt cl Destination"; Rec."lbt cl Destination")
            {
                ApplicationArea = All;
                ToolTip = 'Here can you define the Destination.';
            }
        }
        addafter(SalesLines)
        {
            group(lbtEditor)
            {
                Caption = 'LeBit Extended Layout Options';
                field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, Rec."Document Type".AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Header';
                    Caption = 'Editor Header';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, Rec."Document Type".AsInteger());
                    end;
                }
                field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, Rec."Document Type".AsInteger()))
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Editor Footer';
                    Caption = 'Editor Footer';
                    trigger OnAssistEdit()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorFooter, Rec."Document Type".AsInteger());
                    end;
                }
            }
        }
    }
    actions
    {
        addafter("&Invoice")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit Extended Layout Options';
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
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Old action';
                    ObsoleteTag = '2024-11-26';

                    ApplicationArea = All;
                    Caption = 'Header Text';
                    ToolTip = 'Specifies the Header Text';
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
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Old action';
                    ObsoleteTag = '2024-11-26';

                    ApplicationArea = All;
                    Caption = 'Footer Text';
                    ToolTip = 'Specifies the Footer Text';
                    Image = EndingText;

                    trigger OnAction()
                    var
                        LongtextMgt: Codeunit "lbt Longtext Mgt.";
                        Position: Option Header,Footer,Longtext;
                    begin
                        LongtextMgt.ShowLongtextLines(Rec, Position::Footer);
                    end;
                }
            }
        }
    }
}
