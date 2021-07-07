table 5272720 "lbt PS Longtext Line"
{
    // version LBCOR1.00

    Caption = 'Purch/Sales Longtext Line';
    DrillDownPageID = "lbt PS Longtext Lines";
    LookupPageID = "lbt PS Longtext Lines";
    PasteIsValid = false;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Table));
            DataClassification = CustomerContent;
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Shipment/Receipt';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Shipment/Receipt";
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            NotBlank = true;
            TableRelation = IF ("Table ID" = CONST(36)) "Sales Header"."No." WHERE("Document Type" = FIELD("Document Type"))
            ELSE
            IF ("Table ID" = CONST(37)) "Sales Line"."Document No." WHERE("Document Type" = FIELD("Document Type"))
            ELSE
            IF ("Table ID" = CONST(38)) "Purchase Header"."No." WHERE("Document Type" = FIELD("Document Type"))
            ELSE
            IF ("Table ID" = CONST(39)) "Purchase Line"."Document No." WHERE("Document Type" = FIELD("Document Type"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(4; Position; Option)
        {
            Caption = 'Position';
            OptionCaption = 'Header,Footer,Longtext';
            OptionMembers = Header,Footer,Longtext;
            DataClassification = CustomerContent;
        }
        field(5; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            TableRelation = IF ("Table ID" = CONST(37)) "Sales Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                                                     "Document No." = FIELD("Document No."))
            ELSE
            IF ("Table ID" = CONST(39)) "Purchase Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                                                                                                                      "Document No." = FIELD("Document No."));
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Text,New Page,Text + Line break';
            OptionMembers = Text,"New Page","Text + Line break";
            DataClassification = CustomerContent;

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
                            Description := NewPageLbl;
                        end;
                end;
            end;
        }
        field(11; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST(Text)) "Standard Text";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                case Type of
                    Type::Text,
                    Type::"Text + Line break":
                        begin
                            StandardText.GET("No.");
                            Description := StandardText.Description;
                        end;
                end;
            end;
        }
        field(12; Description; Text[120])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Type = Type::"New Page" then
                    ERROR(CantChangeTxt);
                if Description = '' then
                    Type := Type::Text;
            end;
        }
        field(13; "Text"; BLOB)
        {
            Caption = 'Text';
            DataClassification = CustomerContent;
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
        StandardText: Record "Standard Text";
        NewPageLbl: Label '--- New Page ---';
        CantChangeTxt: Label 'You can not change this text.'; //TODO: ??

    procedure DBOpenMemo()
    var
        PSLongtextLine: Record "lbt PS Longtext Line";
        TempPSLongtextLine: Record "lbt PS Longtext Line" temporary;
        DBTextEdit: Page "lbt DBTextEdit";
        Txt: Text;
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

        if PSLongtextLine.FindSet() then
            repeat
                case PSLongtextLine.Type of
                    PSLongtextLine.Type::"Text + Line break":
                        Txt += (PSLongtextLine.Description + delimiter);
                    else
                        Txt += PSLongtextLine.Description;
                end;
            until PSLongtextLine.Next() = 0;

        DBTextEdit.SetText(Txt);

        if DBTextEdit.RUNMODAL() = ACTION::OK then begin
            PSLongtextLine.DELETEALL();
            Txt := DBTextEdit.GetText();
            CLEAR(delimiter);
            SplitText(Txt, delimiter, TempPSLongtextLine, 120);
            if TempPSLongtextLine.FindSet() then
                repeat
                    if TempPSLongtextLine.Description <> '' then
                        filled := true;

                until TempPSLongtextLine.Next() = 0;
            if filled then begin
                if TempPSLongtextLine.FindSet() then
                    repeat
                        LineNo += 10000;
                        PSLongtextLine.Init();
                        EVALUATE(PSLongtextLine."Table ID", Rec.GETFILTER("Table ID"));
                        EVALUATE(PSLongtextLine."Document Type", Rec.GETFILTER("Document Type"));
                        PSLongtextLine."Document No." := CopyStr(Rec.GETFILTER("Document No."), 1, 20);
                        EVALUATE(PSLongtextLine.Position, GETFILTER(Position));
                        EVALUATE(PSLongtextLine."Document Line No.", Rec.GETFILTER("Document Line No."));

                        PSLongtextLine.Description := TempPSLongtextLine.Description;
                        PSLongtextLine."Line No." := LineNo;
                        PSLongtextLine.Type := TempPSLongtextLine.Type;
                        PSLongtextLine.Insert();
                    until TempPSLongtextLine.Next() = 0;
                if PSLongtextLine.Type <> PSLongtextLine.Type::"New Page" then begin
                    PSLongtextLine.Type := PSLongtextLine.Type::Text;
                    PSLongtextLine.Modify();
                end;
            end;
        end;

    end;

    local procedure SplitText(Text: Text; Delimiter: Text; var PSLongtextLine: Record "lbt PS Longtext Line"; maxlen: Integer)
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
                PSLongtextLine.Init();
                PSLongtextLine."Line No." := LineNo;
                if StrLen(NewString) > maxlen then begin
                    NewLen := maxlen;
                    TestString := NewString;
                    while (not (TestString[NewLen] in [' ', '.', '!', '?', ';', ',', ':', '"'])) and (NewLen <> 1) do
                        NewLen -= 1;
                    if NewLen = 1 then
                        NewLen := maxlen;
                    newstring1 := CopyStr(NewString, 1, NewLen);
                    PSLongtextLine.Description := CopyStr(newstring1, 1, 120);
                    NewString := CopyStr(NewString, NewLen + 1);
                end else begin
                    PSLongtextLine.Description := CopyStr(NewString, 1, 120);
                    PSLongtextLine.Type := PSLongtextLine.Type::"Text + Line break";
                    ende := true;
                end;
                PSLongtextLine.Insert();
            until ende;
        end;
    end;

}

