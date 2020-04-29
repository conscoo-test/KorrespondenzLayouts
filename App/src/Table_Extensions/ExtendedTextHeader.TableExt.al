tableextension 5272726 "lbt Extended Text Header" extends "Extended Text Header"
{
    fields
    {
        field(5272720; "lbt Textchoice"; Option)
        {
            Caption = 'Textchoice';
            OptionCaption = 'Standard,Longtext';
            OptionMembers = standard,"long text";
            DataClassification = CustomerContent;
        }
    }
    trigger OnRename()
    var
        ExtTextLineLongOld: Record "lbt Extended Text Line Long";
        ExtTextLineLongNew: Record "lbt Extended Text Line Long";
    begin
        ExtTextLineLongOld.SetRange(Table_ID, Rec."Table Name");
        ExtTextLineLongOld.SetRange("No.", Rec."No.");
        ExtTextLineLongOld.SetRange("Language Code", xRec."Language Code");
        ExtTextLineLongOld.SetRange("Text No.", xRec."Text No.");
        if ExtTextLineLongOld.FindSet() then
            repeat
                ExtTextLineLongNew := ExtTextLineLongOld;
                ExtTextLineLongNew."Text No." := Rec."Text No.";
                ExtTextLineLongNew."Language Code" := Rec."Language Code";
                ExtTextLineLongNew.Insert();
            until ExtTextLineLongOld.Next() = 0;

        ExtTextLineLongOld.DeleteAll();
    end;
}

