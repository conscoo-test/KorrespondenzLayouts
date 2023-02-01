page 5272730 "lbt cl Longtext SysId"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "lbt clPSLongtextSystemId";
    Caption = '', Locked = true;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {

                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field(FilteredPositionField; PositionAsText)
                {
                    ApplicationArea = All;
                    Caption = 'Position';
                    LookupPageId = "Option Lookup List";
                    TableRelation = "Option Lookup Buffer"."Option Caption" where("Lookup Type" = const("lbt cl Longtext"));

                    trigger OnValidate()
                    begin
                        TempOptionLookupBuffer.SetCurrentType(Rec.Position.AsInteger());
                        if TempOptionLookupBuffer.AutoCompleteLookup(PositionAsText, TempOptionLookupBuffer."Lookup Type"::"lbt cl Longtext") then
                            Rec.Validate(Position, TempOptionLookupBuffer.ID);
                        TempOptionLookupBuffer.ValidateOption(PositionAsText);
                        UpdatePositionText();
                    end;
                }
                field("lbt Editor"; Rec."Editor Content".HasValue())
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Text';
                    Caption = 'Text';

                    trigger OnAssistEdit()
                    begin
                        Rec.EditData();
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if CaptionText = '' then
            CaptionText := GetCaptionFromSourceRec();
        CurrPage.Caption := CaptionText;
    end;

    local procedure UpdatePositionText()
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Rec);
        PositionAsText := TempOptionLookupBuffer.FormatOption(RecRef.Field(Rec.FieldNo(Position)));
    end;

    local procedure GetCaptionFromSourceRec() Caption: Text;
    var
        RecRef: RecordRef;
        FRef: FieldRef;
        HeadersAndFootersLbl: Label 'Headers and Footers';
        SeperatorLbl: Label ' - ', Locked = true;
        KeyRef: KeyRef;
        i: Integer;
        TableId: Integer;
    begin
        Evaluate(TableId, Rec.GetFilter("Table Id"));
        RecRef.Open(TableId);
        RecRef.GetBySystemId(Rec.GetFilter("Source System Id"));
        Caption := HeadersAndFootersLbl;
        Caption += SeperatorLbl + RecRef.Caption;
        KeyRef := RecRef.KeyIndex(1);
        for i := 1 to KeyRef.FieldCount do begin
            FRef := KeyRef.FieldIndex(i);
            Caption += SeperatorLbl + Format(FRef.Value());
        end;
    end;

    procedure SetCaptionText(CaptionText2: Text)
    begin
        CaptionText := CaptionText2;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdatePositionText();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdatePositionText();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Position := Rec.Position::EditorHeader;
        UpdatePositionText();
    end;

    var
        TempOptionLookupBuffer: Record "Option Lookup Buffer" temporary;
        PositionAsText: Text[30];
        CaptionText: Text;
}

