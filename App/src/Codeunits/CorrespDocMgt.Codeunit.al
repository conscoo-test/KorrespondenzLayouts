codeunit 5272720 "lbt Corresp. Doc. Mgt"
{
    trigger OnRun()
    begin
    end;

    var
        IndentTxt: Label 'Indenting the Document #1##########', Comment = '%1 - Document Name';
        MissingBeginTotalTxt: Label 'End-Total %1 is missing a matching Begin-Total.', Comment = '%1 - End-Total Name';
        FromDocOccurrenceNo: Integer;
        FromDocVersionNo: Integer;
        TotalTxt: Label 'Total';

    procedure SalesLineIndentTotaling(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        Window: Dialog;
        AccNo: array[10] of Code[20];
        NewString: Text;
        NoString: Text[20];
        Header: array[10] of Text;
        SummText: Text;
        StrLength: Integer;
        DescLength: Integer;
        NewLength: Integer;
        RestLength: Integer;
        i: Integer;
    begin
        i := 0;
        SummText := TotalTxt;
        if SummText <> '' then
            if COPYSTR(SummText, STRLEN(SummText)) <> ' ' then
                SummText := SummText + ' ';
        StrLength := STRLEN(SummText);
        Window.OPEN(IndentTxt);

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetFilter("Document No.", SalesHeader."No.");
        with SalesLine do
            if FindSet(true) then
                repeat
                    SalesLine2.Reset();
                    SalesLine2.SetRange("Document Type", SalesHeader."Document Type");
                    SalesLine2.SetRange("Document No.", SalesHeader."No.");
                    SalesLine2.SetRange("lbt Indentation", i - 1);
                    SalesLine2.SetFilter("Line No.", '<%1', SalesLine."Line No.");
                    if SalesLine2.FindLast() then;
                    if ("lbt Printoption" = "lbt Printoption"::"End Total") or
                        ((SalesLine2.FindLast()) and
                        (SalesLineGetParentLine(SalesLine2)) and
                        (SalesLine."Attached to Line No." = 0))
                    then begin
                        if i < 1 then
                            Error(MissingBeginTotalTxt, "No.");
                        if ((SalesLine2.FindLast()) and
                          (SalesLineGetParentLine(SalesLine2)) and
                          (SalesLine."Attached to Line No." = 0))
                        then
                            i -= 1;
                        if "lbt Printoption" = "lbt Printoption"::"End Total" then begin
                            "lbt Summation" := AccNo[i] + '..' + Format("Line No.");
                            Description := SummText + Header[i];
                            i := i - 1;
                        end;
                    end;

                    "lbt Indentation" := i;
                    Modify();

                    if ("lbt Printoption" = "lbt Printoption"::"Begin Total") or
                      (SalesLineGetParentLine(SalesLine))
                    then begin
                        i += 1;
                        NoString := Format("Line No.");
                        AccNo[i] := NoString;
                        DescLength := STRLEN(Description);
                        if StrLength + DescLength > 50 then begin
                            RestLength := StrLength + DescLength - 50;
                            NewLength := DescLength - RestLength;
                            NewString := DELSTR(Description, NewLength, 50);
                            Header[i] := NewString;
                        end else
                            Header[i] := Description;

                    end;
                until Next() = 0;
        Window.Close();
    end;

    procedure SalesLinePosNumber(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        PosMerker: Text[30];
        Merk1: Integer;
        Merk2: Integer;
        MaxIndent: Integer;
    begin
        SalesLineIndentTotaling(SalesHeader);

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        MaxIndent := 0;
        if SalesLine.FindSet() then
            repeat
                if SalesLine."lbt Indentation" > MaxIndent then
                    MaxIndent := SalesLine."lbt Indentation";
            until SalesLine.Next() = 0;

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.IsEmpty() then
            exit;

        Merk1 := 0;
        Merk2 := 1;

        repeat
            SalesLine.SetRange("lbt Indentation", Merk1);
            if SalesLine.FindSet(true) then begin
                repeat
                    if not (((SalesLine.Type = SalesLine.Type::" ") and
                              (SalesLine."lbt Printoption" = SalesLine."lbt Printoption"::Standard)) or
                            ((SalesLine."lbt Printoption" = SalesLine."lbt Printoption"::"End Total") or
                              (SalesLine."lbt Printoption" = SalesLine."lbt Printoption"::Title) or
                              (SalesLine."lbt Printoption" = SalesLine."lbt Printoption"::"New Page")))
                    then begin
                        PosMerker := '';
                        if SalesLine."lbt Indentation" > 0 then begin
                            SalesLine2.Reset();
                            SalesLine2.SetRange("Document Type", SalesHeader."Document Type");
                            SalesLine2.SetRange("Document No.", SalesHeader."No.");
                            SalesLine2.SetRange("lbt Indentation", SalesLine."lbt Indentation" - 1);
                            SalesLine2.SetFilter("Line No.", '<%1', SalesLine."Line No.");
                            if (SalesLine2.FindLast()) and
                              (SalesLine2."lbt Printoption" <> SalesLine2."lbt Printoption"::"End Total")
                            then begin
                                PosMerker := SalesLine2."lbt Pos. No.";
                                if (SalesLineGetParentLine(SalesLine2)) and
                                  (SalesLine."Attached to Line No." = 0)
                                then
                                    PosMerker := '';
                            end else
                                PosMerker := '';
                        end;
                        SalesLine3.Reset();
                        SalesLine3.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLine3.SetRange("Document No.", SalesHeader."No.");
                        SalesLine3.SetFilter("Line No.", '<%1', SalesLine."Line No.");
                        if SalesLine3.FindLast() then
                            if (SalesLine3."lbt Printoption" = SalesLine3."lbt Printoption"::"Begin Total") or
                              (SalesLineGetParentLine(SalesLine3))
                            then
                                Merk2 := 1;

                        SalesLine."lbt Pos. No." := CopyStr(PosMerker + Format(Merk2) + '.', 1, 30);
                        SalesLine.Modify();
                        Merk2 += 1;
                    end;
                until SalesLine.Next() = 0;
                Merk1 := Merk1 + 1;
                Merk2 := 1;
            end;
        until Merk1 = MaxIndent + 1;

        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("lbt Printoption", SalesLine."lbt Printoption"::"End Total");
        if SalesLine.FindSet(true) then
            repeat
                SalesLine2.Reset();
                SalesLine2.SetRange("Document Type", SalesHeader."Document Type");
                SalesLine2.SetFilter("Document No.", SalesHeader."No.");
                SalesLine2.SetRange("lbt Printoption", SalesLine2."lbt Printoption"::"Begin Total");
                SalesLine2.SetRange("lbt Indentation", SalesLine."lbt Indentation");
                SalesLine2.SetFilter("Line No.", SalesLine."lbt Summation");
                if SalesLine2.FindLast() then begin
                    SalesLine."lbt Pos. No." := SalesLine2."lbt Pos. No.";
                    SalesLine.Modify();
                end;
            until SalesLine.Next() = 0;

    end;

    local procedure SalesLineGetParentLine(SalesLine: Record "Sales Line"): Boolean
    var
        SalesLine2: Record "Sales Line";
    begin
        SalesLine2.SetRange("Document Type", SalesLine."Document Type");
        SalesLine2.SetRange("Document No.", SalesLine."Document No.");
        SalesLine2.SetRange("Attached to Line No.", SalesLine."Line No.");
        SalesLine2.SetFilter(Type, '<>%1', SalesLine2.Type::" ");
        exit(not SalesLine2.IsEmpty());
    end;

    procedure PurchLineIndentTotaling(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        Window: Dialog;
        AccNo: array[10] of Code[20];
        NoString: Text[20];
        Header: array[10] of Text;
        Summtext: Text;
        NewString: Text;
        i: Integer;
        StrLength: Integer;
        DescLength: Integer;
        NewLength: Integer;
        RestLength: Integer;
    begin
        i := 0;
        Summtext := TotalTxt;
        if Summtext <> '' then
            if COPYSTR(Summtext, STRLEN(Summtext)) <> ' ' then
                Summtext := Summtext + ' ';
        StrLength := STRLEN(Summtext);
        Window.OPEN(IndentTxt);

        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetFilter("Document No.", PurchHeader."No.");
        with PurchLine do
            if FindSet(true) then
                repeat
                    PurchLine2.Reset();
                    PurchLine2.SetRange("Document Type", PurchHeader."Document Type");
                    PurchLine2.SetRange("Document No.", PurchHeader."No.");
                    PurchLine2.SetRange("lbt Indentation", i - 1);
                    PurchLine2.SetFilter("Line No.", '<%1', PurchLine."Line No.");
                    if PurchLine2.FindLast() then;
                    if ("lbt Printoption" = "lbt Printoption"::"End Total") or
                        ((PurchLine2.FindLast()) and
                        (PurchLineGetParentLine(PurchLine2)) and
                        (PurchLine."Attached to Line No." = 0))
                    then begin
                        if i < 1 then
                            Error(MissingBeginTotalTxt, "No.");
                        if ((PurchLine2.FindLast()) and
                          (PurchLineGetParentLine(PurchLine2)) and
                          (PurchLine."Attached to Line No." = 0))
                        then
                            i -= 1;
                        if "lbt Printoption" = "lbt Printoption"::"End Total" then begin
                            "lbt Summation" := AccNo[i] + '..' + Format("Line No.");
                            Description := Summtext + Header[i];
                            i := i - 1;
                        end;
                    end;

                    "lbt Indentation" := i;
                    Modify();

                    if ("lbt Printoption" = "lbt Printoption"::"Begin Total") or
                      (PurchLineGetParentLine(PurchLine))
                    then begin
                        i += 1;
                        NoString := Format("Line No.");
                        AccNo[i] := NoString;
                        DescLength := STRLEN(Description);
                        if StrLength + DescLength > 50 then begin
                            RestLength := StrLength + DescLength - 50;
                            NewLength := DescLength - RestLength;
                            NewString := DELSTR(Description, NewLength, 50);
                            Header[i] := NewString;
                        end else
                            Header[i] := Description;

                    end;
                until Next() = 0;
        Window.Close();
    end;

    procedure PurchLinePosNumber(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        PurchLine3: Record "Purchase Line";
        MaxIndent: Integer;
        Merk1: Integer;
        Merk2: Integer;
        PosMerker: Text[30];
    begin
        PurchLineIndentTotaling(PurchHeader);

        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        MaxIndent := 0;
        if PurchLine.FindSet() then
            repeat
                if PurchLine."lbt Indentation" > MaxIndent then
                    MaxIndent := PurchLine."lbt Indentation";
            until PurchLine.Next() = 0;

        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        if PurchLine.IsEmpty() then
            exit;

        Merk1 := 0;
        Merk2 := 1;

        repeat
            PurchLine.SetRange("lbt Indentation", Merk1);
            if PurchLine.FindSet(true) then begin
                repeat
                    if not (((PurchLine.Type = PurchLine.Type::" ") and
                              (PurchLine."lbt Printoption" = PurchLine."lbt Printoption"::Standard)) or
                            ((PurchLine."lbt Printoption" = PurchLine."lbt Printoption"::"End Total") or
                              (PurchLine."lbt Printoption" = PurchLine."lbt Printoption"::Title) or
                              (PurchLine."lbt Printoption" = PurchLine."lbt Printoption"::"New Page")))
                    then begin
                        PosMerker := '';
                        if PurchLine."lbt Indentation" > 0 then begin
                            PurchLine2.Reset();
                            PurchLine2.SetRange("Document Type", PurchHeader."Document Type");
                            PurchLine2.SetRange("Document No.", PurchHeader."No.");
                            PurchLine2.SetRange("lbt Indentation", PurchLine."lbt Indentation" - 1);
                            PurchLine2.SetFilter("Line No.", '<%1', PurchLine."Line No.");
                            if (PurchLine2.FindLast()) and
                              (PurchLine2."lbt Printoption" <> PurchLine2."lbt Printoption"::"End Total")
                            then begin
                                PosMerker := PurchLine2."lbt Pos. No.";
                                if (PurchLineGetParentLine(PurchLine2)) and
                                  (PurchLine."Attached to Line No." = 0)
                                then
                                    PosMerker := '';
                            end else
                                PosMerker := '';
                        end;
                        PurchLine3.Reset();
                        PurchLine3.SetRange("Document Type", PurchHeader."Document Type");
                        PurchLine3.SetRange("Document No.", PurchHeader."No.");
                        PurchLine3.SetFilter("Line No.", '<%1', PurchLine."Line No.");
                        if PurchLine3.FindLast() then
                            if (PurchLine3."lbt Printoption" = PurchLine3."lbt Printoption"::"Begin Total") or
                              (PurchLineGetParentLine(PurchLine3))
                            then
                                Merk2 := 1;

                        PurchLine."lbt Pos. No." := CopyStr(PosMerker + Format(Merk2) + '.', 1, 30);
                        PurchLine.Modify();
                        Merk2 += 1;
                    end;
                until PurchLine.Next() = 0;
                Merk1 := Merk1 + 1;
                Merk2 := 1;
            end;
        until Merk1 = MaxIndent + 1;

        PurchLine.Reset();
        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        PurchLine.SetRange("lbt Printoption", PurchLine."lbt Printoption"::"End Total");
        if PurchLine.FindSet(true) then
            repeat
                PurchLine2.Reset();
                PurchLine2.SetRange("Document Type", PurchHeader."Document Type");
                PurchLine2.SetFilter("Document No.", PurchHeader."No.");
                PurchLine2.SetRange("lbt Printoption", PurchLine2."lbt Printoption"::"Begin Total");
                PurchLine2.SetRange("lbt Indentation", PurchLine."lbt Indentation");
                PurchLine2.SetFilter("Line No.", PurchLine."lbt Summation");
                if PurchLine2.FindLast() then begin
                    PurchLine."lbt Pos. No." := PurchLine2."lbt Pos. No.";
                    PurchLine.Modify();
                end;
            until PurchLine.Next() = 0;

    end;

    local procedure PurchLineGetParentLine(PurchLine: Record "Purchase Line"): Boolean
    var
        PurchLine2: Record "Purchase Line";
    begin
        PurchLine2.SetRange("Document Type", PurchLine."Document Type");
        PurchLine2.SetRange("Document No.", PurchLine."Document No.");
        PurchLine2.SetRange("Attached to Line No.", PurchLine."Line No.");
        PurchLine2.SetFilter(Type, '<>%1', PurchLine2.Type::" ");
        exit(not PurchLine2.IsEmpty());
    end;

    procedure DefragmentRowID(Type: Integer; Subtype: Integer; ID: Code[20]; BatchName: Code[20]; ProdOrderLine: Integer; RefNo: Integer): Text[250]
    var
        StrArray: array[2] of Text;
        Pos: Integer;
        Len: Integer;
        T: Integer;
    begin
        // Funktion zum zusammensetzen der RowID
        // somit werden alle wichtigen Kriterien generiert die für einen Filteraufbau von nöten sind

        StrArray[1] := ID;
        StrArray[2] := BatchName;
        for T := 1 to 2 do
            if STRPOS(StrArray[T], '"') > 0 then begin
                Len := STRLEN(StrArray[T]);
                Pos := 1;
                repeat
                    if COPYSTR(StrArray[T], Pos, 1) = '"' then begin
                        StrArray[T] := INSSTR(StrArray[T], '"', Pos + 1);
                        Len += 1;
                        Pos += 1;
                    end;
                    Pos += 1;
                until Pos > Len;
            end;

        exit(STRSUBSTNO('"%1";"%2";"%3";"%4";"%5";"%6"', Type, Subtype, StrArray[1], StrArray[2], ProdOrderLine, RefNo));
    end;

    local procedure GetTypeFieldRef(var RecRef_L: RecordRef; FieldID: Integer) TextVar: Text
    var
        FieldRef_L: FieldRef;
    begin
        FieldRef_L := RecRef_L.FIELD(FieldID);
        TextVar := Format(FieldRef_L.TYPE());
        exit(TextVar);
    end;

    procedure SetGetSalesArchivValues(FromDocOccurrenceNoVar: Integer; FromDocVersionNoVar: Integer)
    begin
        FromDocOccurrenceNo := FromDocOccurrenceNoVar;
        FromDocVersionNo := FromDocVersionNoVar;
    end;

    procedure SetGetPurchArchivValues(FromDocOccurrenceNoVar: Integer; FromDocVersionNoVar: Integer)
    begin
        FromDocOccurrenceNo := FromDocOccurrenceNoVar;
        FromDocVersionNo := FromDocVersionNoVar;
    end;

    procedure GetStyleExpr(Printoption: Option Standard,Title,,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total") StyleExprText: Text[30]
    var
        StyleExpr: Option Standard,StandardAccent,Strong,StrongAccent,Attention,AttentionAccent,Favorable,Unfavorable,Ambiguous,Subordinate;
    begin
        case Printoption of
            Printoption::"Price Invisible":
                StyleExprText := Format(StyleExpr::Attention);
            Printoption::"Line Invisible":
                StyleExprText := Format(StyleExpr::Subordinate);
            Printoption::Alternative:
                StyleExprText := Format(StyleExpr::StrongAccent);
            Printoption::Optional:
                StyleExprText := Format(StyleExpr::Favorable);
            Printoption::Title,
          Printoption::"Begin Total",
          Printoption::"End Total":
                StyleExprText := Format(StyleExpr::Strong);
            else
                StyleExprText := Format(StyleExpr::Standard);
        end;
    end;
}

