tableextension 5272726 "LBT Extended Text Header" extends "Extended Text Header"
{
    fields
    {
        field(5272720; "LBT Textchoice"; Option)
        {
            Caption = 'Textchoice', Comment = 'DEU="Textauswahl"';
            OptionCaption = 'Standard,Longtext', Comment = 'DEU="Standard, Langtext"';
            OptionMembers = standard,"long text";
        }
    }
    trigger OnRename()
    var
        ExtTextLineLongOld: Record "LBT Extended Text Line Long";
        ExtTextLineLongNew: Record "LBT Extended Text Line Long";
    begin
        ExtTextLineLongOld.SetRange(Table_ID, Rec."Table Name");
        ExtTextLineLongOld.SetRange("No.", Rec."No.");
        ExtTextLineLongOld.SetRange("Language Code", xRec."Language Code");
        ExtTextLineLongOld.SetRange("Text No.", xRec."Text No.");
        if ExtTextLineLongOld.FINDSET then
            repeat
                ExtTextLineLongNew := ExtTextLineLongOld;
                ExtTextLineLongNew."Text No." := Rec."Text No.";
                ExtTextLineLongNew."Language Code" := Rec."Language Code";
                ExtTextLineLongNew.INSERT;
            until ExtTextLineLongOld.NEXT = 0;

        ExtTextLineLongOld.DELETEALL;
    end;
}

