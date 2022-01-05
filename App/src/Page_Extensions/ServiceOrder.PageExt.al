pageextension 5272815 "lbt cl ServiceOrder" extends "Service Order"
{
    layout
    {
        addlast(General)
        {
            field("lbt Editor Header"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorHeader, Rec."Document Type".AsInteger()))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor Header';
                caption = 'Editor Header';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, Rec."Document Type".AsInteger());
                end;
            }
            field("lbt Editor Footer"; Rec.lbtHasEditorValue(Enum::"lbt Position"::EditorFooter, Rec."Document Type".AsInteger()))
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor Footer';
                caption = 'Editor Footer';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Enum::"lbt Position"::Editorfooter, Rec."Document Type".AsInteger());
                end;
            }
        }
    }
    actions
    {
        addafter("&Dimensions")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit365 Correspondence layout';
                action("lbt Header Text")
                {
                    ApplicationArea = All;
                    Caption = 'Header Text';
                    ToolTip = 'Here you can define the Header Text.';
                    Image = BeginningText;

                    trigger OnAction()

                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::EditorHeader, Rec."Document Type".AsInteger());
                    end;
                }
                action("lbt &Footer Text")
                {
                    ApplicationArea = All;
                    Caption = '&Footer Text';
                    ToolTip = 'Here you can define the Footer Text.';
                    Image = EndingText;

                    trigger OnAction()
                    begin
                        Rec.lbtEditData(Enum::"lbt Position"::Editorfooter, Rec."Document Type".AsInteger());
                    end;
                }
            }
        }
    }
}
