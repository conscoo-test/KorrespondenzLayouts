page 5272728 "lbt Corr Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "lbt Corr Setup";
    Caption = 'LeBit Extended Layout Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Always print VAT"; Rec."Always print VAT")
                {
                    ToolTip = 'If selected VAT will be printed in reports even if it is 0.';
                }
                group(Sales)
                {
                    Caption = 'Sales';
                    field("Copy Quote Texts"; Rec."Copy Quote Texts")
                    {
                        ToolTip = 'This option affects the copying of header and footer texts from the quotation to the sales order.';
                    }
                    field("Copy Blanket Order Texts"; Rec."Copy Blanket Order Texts")
                    {
                        ToolTip = 'This option affects the copying of header and footer texts from the blanket order to the sales order.';
                    }
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end
    end;
}