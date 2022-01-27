pageextension 5272778 "lbt Purch Ret. Order Arc Sub." extends "Purch Return Order Arc Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field("lbt Pos. No."; Rec."lbt Pos. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can fill in position numbers.';
            }
        }
        addafter(Type)
        {

            field("lbt Printoption"; Rec."lbt Printoption")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can choose the Printoptions.';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("lbt Long Text"; Rec."lbt Long Text")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can insert long texts. ';
            }
            field("Lbt Editor"; Rec.lbtHasEditorValue(Rec."Document Type".AsInteger()))
            {
                Caption = ' ', Locked = true;
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Editor';
                trigger OnAssistEdit()
                begin
                    Rec.lbtEditData(Rec."Document Type".AsInteger());
                end;
            }
        }
    }
    actions
    {
        addafter(DeferralSchedule)
        {
            action("lbt LongText")
            {
                ApplicationArea = Suite;
                Caption = 'Long Text';
                ToolTip = 'Here you can insert the long text for the line.';
                Image = Import;
                trigger OnAction()
                var
                    LongtextMgt: Codeunit "lbt Longtext Mgt.";
                    SourceRecRef: RecordRef;
                    Position: Option Header,Footer,Longtext;
                begin
                    SourceRecRef.GetTable(Rec);
                    LongtextMgt.ShowLongtextLines(Rec, Position::Longtext);
                end;
            }
        }
    }
}

