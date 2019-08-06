page 5272720 "LBT PS Longtext Lines"
{
    AutoSplitKey = true;
    Caption = 'PS Longtext Lines', Comment = 'DEU="EK/VK Langtext Zeilen"';
    PageType = List;
    SourceTable = "LBT PS Longtext Line";
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
                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
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
                Caption = 'Editor', Comment = 'DEU="Bearbeiten"';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
                begin
                    //RecRef.GETTABLE(Rec);
                    //LeBitCorrespDocMgt.EditorRef(RecRef,TRUE);
                    DBOpenMemo;

                    CurrPage.UPDATE(false);
                end;
            }
        }
    }

    var
        ExtTextHeadRec: Record "Extended Text Header";
        SalesHeaderRec: Record "Sales Header";
        PurchHeaderRec: Record "Purchase Header";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        SourceRecRef: RecordRef;
        SourceFieldRef: FieldRef;
        SourceDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        Belegdatum: Date;
        LanguageCode: Code[10];
        SourceDocumentNo: Code[20];
        SourceTableID: Integer;

    local procedure NoOnAfterValidate()
    var
        LeBitCorrespDocMgt: Codeunit "LBT Corresp. Doc. Mgt";
        LeBitLongtextMgt: Codeunit "LBT Longtext Mgt.";
    begin
        LanguageCode := '';
        Belegdatum := 0D;
        SourceRecRef.GETTABLE(Rec);
        SourceTableID := SourceRecRef.NUMBER;
        SourceFieldRef := SourceRecRef.FIELD(2);
        SourceDocumentType := SourceFieldRef.VALUE;
        SourceFieldRef := SourceRecRef.FIELD(3);
        SourceDocumentNo := SourceFieldRef.VALUE;

        if "Table ID" in [36, 37] then begin
            SalesHeaderRec.RESET;
            SalesHeaderRec.SETRANGE("Document Type", SourceDocumentType);
            SalesHeaderRec.SETRANGE("No.", SourceDocumentNo);
            if SalesHeaderRec.FINDFIRST then begin
                LanguageCode := SalesHeaderRec."Language Code";
                Belegdatum := SalesHeaderRec."Document Date";
            end;
        end;

        if "Table ID" in [38, 39] then begin
            PurchHeaderRec.RESET;
            PurchHeaderRec.SETRANGE("Document Type", SourceDocumentType);
            PurchHeaderRec.SETRANGE("No.", SourceDocumentNo);
            if PurchHeaderRec.FINDFIRST then begin
                LanguageCode := PurchHeaderRec."Language Code";
                Belegdatum := PurchHeaderRec."Document Date";
            end;
        end;

        ExtTextHeadRec.SETRANGE("Table Name", ExtTextHeadRec."Table Name"::"Standard Text");
        ExtTextHeadRec.SETRANGE("No.", "No.");

        CurrPage.SAVERECORD;

        if LeBitLongtextMgt.LongTextCheckIfAnyExtText(ExtTextHeadRec, LanguageCode, Belegdatum) then begin
            LeBitLongtextMgt.InsertLongTextExtText(Rec, "Document Type");
        end;

        CurrPage.UPDATE(false);
    end;
}

