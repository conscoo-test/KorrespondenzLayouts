page 5272720 "lbt PS Longtext Lines"
{
    AutoSplitKey = true;
    Caption = 'PS Longtext Lines', Comment = 'DEU="EK/VK Langtext Zeilen"';
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

                field("No."; "No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique number', comment = 'DEU="Legt eine eindeutige Nr. fest"';
                    trigger OnValidate()
                    begin
                        NoOnAfterValidate();
                    end;
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique description', comment = 'DEU="Legt eine eindeutige Beschreibung fest"';
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique description the type', comment = 'DEU="Legt den Typ fest"';
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
                ToolTip = 'Here you can add a text that will be printed on the report.', comment = 'DEU="Hier können Sie einen Text verfassen, der auf dem Report angedruckt wird."';
                Caption = 'Editor', Comment = 'DEU="Editor"';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    DBOpenMemo();

                    CurrPage.UPDATE(false);
                end;
            }
        }
    }

    var
        ExtTextHeadRec: Record "Extended Text Header";
        SalesHeaderRec: Record "Sales Header";
        PurchHeaderRec: Record "Purchase Header";
        SourceRecRef: RecordRef;
        SourceFieldRef: FieldRef;
        SourceDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        Belegdatum: Date;
        LanguageCode: Code[10];
        SourceDocumentNo: Code[20];
        SourceTableID: Integer;

    local procedure NoOnAfterValidate()
    var
        LeBitLongtextMgt: Codeunit "lbt Longtext Mgt.";
    begin
        LanguageCode := '';
        Belegdatum := 0D;
        SourceRecRef.GETTABLE(Rec);
        SourceTableID := SourceRecRef.Number();
        SourceFieldRef := SourceRecRef.Field(2);
        SourceDocumentType := SourceFieldRef.Value();
        SourceFieldRef := SourceRecRef.Field(3);
        SourceDocumentNo := SourceFieldRef.Value();

        if "Table ID" in [36, 37] then begin
            SalesHeaderRec.Reset();
            SalesHeaderRec.SetRange("Document Type", SourceDocumentType);
            SalesHeaderRec.SetRange("No.", SourceDocumentNo);
            if SalesHeaderRec.FindFirst() then begin
                LanguageCode := SalesHeaderRec."Language Code";
                Belegdatum := SalesHeaderRec."Document Date";
            end;
        end;

        if "Table ID" in [38, 39] then begin
            PurchHeaderRec.Reset();
            PurchHeaderRec.SetRange("Document Type", SourceDocumentType);
            PurchHeaderRec.SetRange("No.", SourceDocumentNo);
            if PurchHeaderRec.FindFirst() then begin
                LanguageCode := PurchHeaderRec."Language Code";
                Belegdatum := PurchHeaderRec."Document Date";
            end;
        end;

        ExtTextHeadRec.SetRange("Table Name", ExtTextHeadRec."Table Name"::"Standard Text");
        ExtTextHeadRec.SetRange("No.", "No.");

        CurrPage.SaveRecord();

        if LeBitLongtextMgt.LongTextCheckIfAnyExtText(ExtTextHeadRec, LanguageCode, Belegdatum) then
            LeBitLongtextMgt.InsertLongTextExtText(Rec, "Document Type");

        CurrPage.UPDATE(false);
    end;
}

