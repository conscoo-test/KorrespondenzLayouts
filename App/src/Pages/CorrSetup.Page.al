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

    actions
    {
        area(Processing)
        {
            action("Delete Empty Textheaders")
            {
                Caption = 'Delete Empty Textheaders';
                Image = Delete;

                trigger OnAction()
                var
                    ExtendedTextHeader: Record "Extended Text Header";
                    cnt: Integer;
                    DeleteQst: Label 'Are you sure you want to delete all empty textheaders?';
                    SuccessMsg: Label 'Deleted %1 empty textheaders.', Comment = '%1=Count';
                begin
                    if not Confirm(DeleteQst) then
                        exit;
                    ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                    ExtendedTextHeader.SetRange("No.", '');
                    cnt := ExtendedTextHeader.Count;
                    ExtendedTextHeader.DeleteAll(true);
                    Message(SuccessMsg, cnt);
                end;
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