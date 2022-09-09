pageextension 5272759 "lbt Sales Quote Archive" extends "Sales Quote Archive"
{
    layout
    {
        addafter(General)
        {

            field("lbt cl Delivery Date Type"; Rec."lbt cl Delivery Date Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Delivery Date Type field.';
            }
            field("lbt cl Destination"; Rec."lbt cl Destination")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Destination field.';
            }
        }
        addafter(SalesLinesArchive)
        {
            group(lbtEditor)
            {
                caption = 'Longtext';
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
    }
    actions
    {
        addafter("Ver&sion")
        {
            group("lbt correspondence documents")
            {
                Caption = 'LeBit Extended Layout Options';
                action("lbt Header Text")
                {
                    ToolTip = 'Here you can define the Header Text.';
                    ApplicationArea = All;
                    Caption = 'Header Text';
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
                    ToolTip = 'Here you can define the Footer Text.';
                    ApplicationArea = All;
                    Caption = 'Footer Text';
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

