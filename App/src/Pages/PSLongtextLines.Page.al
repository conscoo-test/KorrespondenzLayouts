page 5272720 "lbt PS Longtext Lines"
{
    AutoSplitKey = true;
    Caption = 'PS Longtext Lines';
    PageType = List;
    SourceTable = "lbt PS Longtext Line";
    // UsageCategory = Lists;
    // ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control5272723)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique number';
                    trigger OnValidate()
                    begin
                        NoOnAfterValidate();
                    end;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique description';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique description the type';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("E&ditor")
            {
                ApplicationArea = All;
                ToolTip = 'Here you can add a text that will be printed on the report.';
                Caption = 'Editor';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.DBOpenMemo();

                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        ExtendedTextHeader: Record "Extended Text Header";
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        SourceRecordRef: RecordRef;
        SourceFieldRef: FieldRef;
        SourceDocumentType: Enum "Sales Document Type";
        Belegdatum: Date;
        LanguageCode: Code[10];
        SourceDocumentNo: Code[20];

    local procedure NoOnAfterValidate()
    var
        LongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LanguageCode := '';
        Belegdatum := 0D;
        SourceRecordRef.GetTable(Rec);
        SourceFieldRef := SourceRecordRef.Field(2);
        SourceDocumentType := SourceFieldRef.Value();
        SourceFieldRef := SourceRecordRef.Field(3);
        SourceDocumentNo := SourceFieldRef.Value();

        if Rec."Table ID" in [36, 37] then begin
            SalesHeader.Reset();
            SalesHeader.SetRange("Document Type", SourceDocumentType);
            SalesHeader.SetRange("No.", SourceDocumentNo);
            if SalesHeader.FindFirst() then begin
                LanguageCode := SalesHeader."Language Code";
                Belegdatum := SalesHeader."Document Date";
            end;
        end;

        if Rec."Table ID" in [38, 39] then begin
            PurchaseHeader.Reset();
            PurchaseHeader.SetRange("Document Type", SourceDocumentType);
            PurchaseHeader.SetRange("No.", SourceDocumentNo);
            if PurchaseHeader.FindFirst() then begin
                LanguageCode := PurchaseHeader."Language Code";
                Belegdatum := PurchaseHeader."Document Date";
            end;
        end;

        ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
        ExtendedTextHeader.SetRange("No.", Rec."No.");

        CurrPage.SaveRecord();

        if LongtextMgt.LongTextCheckIfAnyExtText(ExtendedTextHeader, LanguageCode, Belegdatum) then
            LongtextMgt.InsertLongTextExtText(Rec, Rec."Document Type");

        CurrPage.Update(false);
    end;
}

