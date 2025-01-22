pageextension 5272768 "lbt Sales Return Order Archive" extends "Sales Return Order Archive"
{
    // version NAVW111.00.00.19846,LBCOR1.00

    layout
    {
        addafter(SalesLinesArchive)
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
        addafter("Ver&sion")
        {
            group("lbt correspondence documents")
            {
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'Old actions';
                ObsoleteTag = '2024-11-26';

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
                action("lbt &Footer Text")
                {
                    ToolTip = 'Here you can define the Footer Text.';
                    ApplicationArea = All;
                    Caption = '&Footer Text';
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
