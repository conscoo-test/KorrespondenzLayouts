pageextension 5272752 "lbt Blanket Sales Order" extends "Blanket Sales Order"
{
    layout
    {
        addafter(SalesLines)
        {
            group(lbtEditor)
            {
                caption = 'Longtext';
                field("lbt Editor Header"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorHeader, rec."Document Type".AsInteger()))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Header';
                    caption = 'Editor Header';
                    trigger OnAssistEdit()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::EditorHeader, rec."Document Type".AsInteger());
                    end;
                }
                field("lbt Editor Footer"; rec.lbtHasEditorValue(enum::"lbt Position"::EditorFooter, rec."Document Type".AsInteger()))
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Editor Footer';
                    caption = 'Editor Footer';
                    trigger OnAssistEdit()
                    begin
                        rec.lbtEditData(enum::"lbt Position"::Editorfooter, rec."Document Type".AsInteger());
                    end;
                }
            }
        }
    }
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
                    Caption = 'Tot&aling';
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
                    Caption = 'Num&bering';
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
            }
        }
    }
}

