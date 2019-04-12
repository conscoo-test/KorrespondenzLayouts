table 5272720 "LBT PS Longtext Line"
{
    // version LBCOR1.00

    Caption = 'Purch/Sales Longtext Line';
    DrillDownPageID = "LBT PS Longtext Lines";
    LookupPageID = "LBT PS Longtext Lines";
    PasteIsValid = false;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            TableRelation = AllObj."Object ID" WHERE ("Object Type" = CONST (Table));
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Shipment/Receipt';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Shipment/Receipt";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            NotBlank = true;
            TableRelation = IF ("Table ID" = CONST (36)) "Sales Header"."No." WHERE ("Document Type" = FIELD ("Document Type"))
            ELSE
            IF ("Table ID" = CONST (37)) "Sales Line"."Document No." WHERE ("Document Type" = FIELD ("Document Type"))
            ELSE
            IF ("Table ID" = CONST (38)) "Purchase Header"."No." WHERE ("Document Type" = FIELD ("Document Type"))
            ELSE
            IF ("Table ID" = CONST (39)) "Purchase Line"."Document No." WHERE ("Document Type" = FIELD ("Document Type"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(4; Position; Option)
        {
            Caption = 'Position';
            OptionCaption = 'Header,Footer,Longtext';
            OptionMembers = Header,Footer,Longtext;
        }
        field(5; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            TableRelation = IF ("Table ID" = CONST (37)) "Sales Line"."Line No." WHERE ("Document Type" = FIELD ("Document Type"),
                                                                                     "Document No." = FIELD ("Document No."))
            ELSE
            IF ("Table ID" = CONST (39)) "Purchase Line"."Line No." WHERE ("Document Type" = FIELD ("Document Type"),
                                                                                                                                                      "Document No." = FIELD ("Document No."));
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Text,New Page,Text + Line break';
            OptionMembers = Text,"New Page","Text + Line break";

            trigger OnValidate()
            begin
                case Type of
                    Type::Text,
                  Type::"Text + Line break":
                        if xRec.Type = xRec.Type::"New Page" then begin
                            "No." := '';
                            Description := '';
                        end;
                    Type::"New Page":
                        begin
                            "No." := '';
                            Description := Text001;
                        end;
                end;
            end;
        }
        field(11; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST (Text)) "Standard Text";

            trigger OnValidate()
            begin
                case Type of
                    Type::Text,
                    Type::"Text + Line break":
                        begin
                            StandardTextRec.GET("No.");
                            Description := StandardTextRec.Description;
                        end;
                end;
            end;
        }
        field(12; Description; Text[120])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                if Type = Type::"New Page" then
                    ERROR(Text002);
                if Description = '' then
                    Type := Type::Text;
            end;
        }
        field(13; Text; BLOB)
        {
            Caption = 'Text';
        }
    }

    keys
    {
        key(Key1; "Table ID", "Document Type", "Document No.", Position, "Document Line No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        if Description = '' then
            Type := Type::Text;
    end;

    var
        StandardTextRec: Record "Standard Text";
        Text001: Label '--- New Page ---';
        Text002: Label 'You can not change this text.';
        Text003: Label 'You cannot rename a %1.';

    procedure DBOpenMemo()
    var
        TempPSLongtextLine: Record "LBT PS Longtext Line" temporary;
        RecRef: RecordRef;
        i: Integer;
        PSLongtextLine: Record "LBT PS Longtext Line";
        text: Text;
        DBTextEdit: Page DBTextEdit;
        c: Integer;
        tempMemo: Record "LBT PS Longtext Line" temporary;
        delimiter: Text;
        LineNo: Integer;
        filled: Boolean;
    begin
        if "Document No." = '' then begin
            PSLongtextLine.SETFILTER("Table ID", Rec.GETFILTER("Table ID"));
            PSLongtextLine.SETFILTER("Document Type", Rec.GETFILTER("Document Type"));
            PSLongtextLine.SETFILTER("Document No.", Rec.GETFILTER("Document No."));
            PSLongtextLine.SETFILTER(Position, Rec.GETFILTER(Position));
            PSLongtextLine.SETFILTER("Document Line No.", Rec.GETFILTER("Document Line No."));
        end else begin
            PSLongtextLine.SETRANGE("Table ID", "Table ID");
            PSLongtextLine.SETRANGE("Document Type", "Document Type");
            PSLongtextLine.SETRANGE("Document No.", "Document No.");
            PSLongtextLine.SETRANGE(Position, Position);
            PSLongtextLine.SETRANGE("Document Line No.", "Document Line No.");
        end;

        delimiter[1] := 13;
        delimiter[2] := 10;

        if PSLongtextLine.FINDSET then
            repeat
                case PSLongtextLine.Type of
                    PSLongtextLine.Type::"Text + Line break":
                        text += (PSLongtextLine.Description + delimiter);
                    else
                        text += PSLongtextLine.Description;
                end;
            until PSLongtextLine.NEXT = 0;

        DBTextEdit.SetText(text);

        if DBTextEdit.RUNMODAL = ACTION::OK then begin
            PSLongtextLine.DELETEALL;
            text := DBTextEdit.GetText;
            for i := 1 to STRLEN(text) do begin
                c := text[i];
            end;
            CLEAR(delimiter);
            SplitText(text, delimiter, tempMemo, 120);
            if tempMemo.FINDSET then
                repeat
                    if tempMemo.Description <> '' then
                        filled := true;

                until tempMemo.NEXT = 0;
            if filled then begin
                if tempMemo.FINDSET then
                    repeat
                        LineNo += 10000;
                        PSLongtextLine.INIT;
                        /*
                        PSLongtextLine."Table ID" := "Table ID";
                        PSLongtextLine."Document Type" := "Document Type";
                        PSLongtextLine."Document No." := "Document No.";
                        PSLongtextLine.Position := Position;
                        PSLongtextLine."Document Line No." := "Document Line No.";
                        */
                        EVALUATE(PSLongtextLine."Table ID", Rec.GETFILTER("Table ID"));
                        EVALUATE(PSLongtextLine."Document Type", Rec.GETFILTER("Document Type"));
                        PSLongtextLine."Document No." := Rec.GETFILTER("Document No.");
                        EVALUATE(PSLongtextLine.Position, GETFILTER(Position));
                        EVALUATE(PSLongtextLine."Document Line No.", Rec.GETFILTER("Document Line No."));

                        PSLongtextLine.Description := tempMemo.Description;
                        PSLongtextLine."Line No." := LineNo;
                        PSLongtextLine.Type := tempMemo.Type;
                        PSLongtextLine.INSERT;
                    until tempMemo.NEXT = 0;
                if PSLongtextLine.Type <> PSLongtextLine.Type::"New Page" then begin
                    PSLongtextLine.Type := PSLongtextLine.Type::Text;
                    PSLongtextLine.MODIFY;
                end;
            end;
        end;

    end;

    local procedure SplitText(Text: Text; Delimiter: Text; var SplitBuffer: Record "LBT PS Longtext Line"; maxlen: Integer)
    var
        NewString: Text;
        SplitArray: List of [Text];
        ende: Boolean;
        newstring1: Text;
        LineNo: Integer;
        NewLen: Integer;
        TestString: Text;
    begin
        SplitArray := Text.Split(Delimiter);
        foreach newstring in text.Split(delimiter) do begin
            NewString := NewString.Trim();
            ende := false;
            repeat
                LineNo += 1;
                SplitBuffer.Init;
                SplitBuffer."Line No." := LineNo;
                if StrLen(NewString) > maxlen then begin
                    NewLen := maxlen;
                    TestString := NewString;
                    while (not (TestString[NewLen] in [' ', '.', '!', '?', ';', ',', ':', '"'])) and (NewLen <> 1) do begin
                        NewLen -= 1;
                    end;
                    if NewLen = 1 then
                        NewLen := maxlen;
                    newstring1 := CopyStr(NewString, 1, NewLen);
                    SplitBuffer.Description := newstring1;
                    NewString := CopyStr(NewString, NewLen + 1);
                end else begin
                    SplitBuffer.Description := NewString;
                    SplitBuffer.Type := SplitBuffer.Type::"Text + Line break";
                    ende := true;
                end;
                SplitBuffer.Insert;
            until ende;
        end;
    end;

}

