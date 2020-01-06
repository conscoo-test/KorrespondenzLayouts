codeunit 5272720 "LBT Corresp. Doc. Mgt"
{
    trigger OnRun()
    begin
    end;

    var
        Text5272726: Label 'Indenting the Document #1##########';
        Text5272727: Label 'End-Total %1 is missing a matching Begin-Total.';
        LineCounter: Integer;
        FromDocOccurrenceNo: Integer;
        FromDocVersionNo: Integer;
        Text5272722: Label 'Total';

    procedure SalesLineIndentTotaling(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        Window: Dialog;
        AccNo: array[10] of Code[20];
        NewString: Text[50];
        NoString: Text[30];
        Header: array[10] of Text[50];
        SummText: Text[30];
        StrLength: Integer;
        DescLength: Integer;
        NewLength: Integer;
        RestLength: Integer;
        i: Integer;
    begin
        SummText := Text5272722;
        if SummText <> '' then
            if COPYSTR(SummText, STRLEN(SummText)) <> ' ' then
                SummText := SummText + ' ';
        StrLength := STRLEN(SummText);
        Window.OPEN(Text5272726);

        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETFILTER("Document No.", SalesHeader."No.");
        with SalesLine do
            if FINDSET(true) then
                repeat
                    SalesLine2.RESET;
                    SalesLine2.SETRANGE("Document Type", SalesHeader."Document Type");
                    SalesLine2.SETRANGE("Document No.", SalesHeader."No.");
                    SalesLine2.SETRANGE("LBT Indentation", i - 1);
                    SalesLine2.SETFILTER("Line No.", '<%1', SalesLine."Line No.");
                    if SalesLine2.FINDLAST then;
                    if ("LBT Printoption" = "LBT Printoption"::"End Total") or
                        ((SalesLine2.FINDLAST) and
                        (SalesLineGetParentLine(SalesLine2)) and
                        (SalesLine."Attached to Line No." = 0))
                    then begin
                        if i < 1 then
                            ERROR(Text5272727, "No.");
                        if ((SalesLine2.FINDLAST) and
                          (SalesLineGetParentLine(SalesLine2)) and
                          (SalesLine."Attached to Line No." = 0))
                        then
                            i -= 1;
                        if "LBT Printoption" = "LBT Printoption"::"End Total" then begin
                            "LBT Summation" := AccNo[i] + '..' + FORMAT("Line No.");
                            Description := SummText + Header[i];
                            i := i - 1;
                        end;
                    end;

                    "LBT Indentation" := i;
                    MODIFY;

                    if ("LBT Printoption" = "LBT Printoption"::"Begin Total") or
                      (SalesLineGetParentLine(SalesLine))
                    then begin
                        i += 1;
                        NoString := FORMAT("Line No.");
                        AccNo[i] := NoString;
                        DescLength := STRLEN(Description);
                        if StrLength + DescLength > 50 then begin
                            RestLength := StrLength + DescLength - 50;
                            NewLength := DescLength - RestLength;
                            NewString := DELSTR(Description, NewLength, 50);
                            Header[i] := NewString;
                        end else begin
                            Header[i] := Description;
                        end;
                    end;
                until NEXT = 0;
        Window.CLOSE;
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
        LineNoMerker: Code[20];
    begin
        SalesLineIndentTotaling(SalesHeader);

        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        MaxIndent := 0;
        if SalesLine.FINDSET then
            repeat
                if SalesLine."LBT Indentation" > MaxIndent then
                    MaxIndent := SalesLine."LBT Indentation";
            until SalesLine.NEXT = 0;

        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        if SalesLine.ISEMPTY then
            exit;

        Merk1 := 0;
        Merk2 := 1;

        repeat
            SalesLine.SETRANGE("LBT Indentation", Merk1);
            if SalesLine.FINDSET(true) then begin
                repeat
                    if not (((SalesLine.Type = SalesLine.Type::" ") and
                              (SalesLine."LBT Printoption" = SalesLine."LBT Printoption"::Standard)) or
                            ((SalesLine."LBT Printoption" = SalesLine."LBT Printoption"::"End Total") or
                              (SalesLine."LBT Printoption" = SalesLine."LBT Printoption"::Title) or
                              (SalesLine."LBT Printoption" = SalesLine."LBT Printoption"::"New Page")))
                    then begin
                        PosMerker := '';
                        if SalesLine."LBT Indentation" > 0 then begin
                            SalesLine2.RESET;
                            SalesLine2.SETRANGE("Document Type", SalesHeader."Document Type");
                            SalesLine2.SETRANGE("Document No.", SalesHeader."No.");
                            SalesLine2.SETRANGE("LBT Indentation", SalesLine."LBT Indentation" - 1);
                            SalesLine2.SETFILTER("Line No.", '<%1', SalesLine."Line No.");
                            if (SalesLine2.FINDLAST) and
                              (SalesLine2."LBT Printoption" <> SalesLine2."LBT Printoption"::"End Total")
                            then begin
                                PosMerker := SalesLine2."LBT Pos. No.";
                                if (SalesLineGetParentLine(SalesLine2)) and
                                  (SalesLine."Attached to Line No." = 0)
                                then
                                    PosMerker := '';
                            end else
                                PosMerker := '';
                        end;
                        SalesLine3.RESET;
                        SalesLine3.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine3.SETRANGE("Document No.", SalesHeader."No.");
                        SalesLine3.SETFILTER("Line No.", '<%1', SalesLine."Line No.");
                        if SalesLine3.FINDLAST then
                            if (SalesLine3."LBT Printoption" = SalesLine3."LBT Printoption"::"Begin Total") or
                              (SalesLineGetParentLine(SalesLine3))
                            then
                                Merk2 := 1;

                        SalesLine."LBT Pos. No." := PosMerker + FORMAT(Merk2) + '.';
                        SalesLine.MODIFY;
                        Merk2 += 1;
                    end;
                until SalesLine.NEXT = 0;
                Merk1 := Merk1 + 1;
                Merk2 := 1;
            end;
        until Merk1 = MaxIndent + 1;

        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE("LBT Printoption", SalesLine."LBT Printoption"::"End Total");
        if SalesLine.FINDSET(true) then begin
            repeat
                SalesLine2.RESET;
                SalesLine2.SETRANGE("Document Type", SalesHeader."Document Type");
                SalesLine2.SETFILTER("Document No.", SalesHeader."No.");
                SalesLine2.SETRANGE("LBT Printoption", SalesLine2."LBT Printoption"::"Begin Total");
                SalesLine2.SETRANGE("LBT Indentation", SalesLine."LBT Indentation");
                SalesLine2.SETFILTER("Line No.", SalesLine."LBT Summation");
                if SalesLine2.FINDLAST then begin
                    SalesLine."LBT Pos. No." := SalesLine2."LBT Pos. No.";
                    SalesLine.MODIFY;
                end;
            until SalesLine.NEXT = 0;
        end;
    end;

    local procedure SalesLineGetParentLine(SalesLine: Record "Sales Line"): Boolean
    var
        SalesLine2: Record "Sales Line";
    begin
        SalesLine2.SETRANGE("Document Type", SalesLine."Document Type");
        SalesLine2.SETRANGE("Document No.", SalesLine."Document No.");
        SalesLine2.SETRANGE("Attached to Line No.", SalesLine."Line No.");
        SalesLine2.SETFILTER(Type, '<>%1', SalesLine2.Type::" ");
        exit(not SalesLine2.ISEMPTY);
    end;

    procedure PurchLineIndentTotaling(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        Window: Dialog;
        AccNo: array[10] of Code[20];
        NoString: Text[30];
        Header: array[10] of Text[50];
        Summtext: Text[30];
        NewString: Text[50];
        i: Integer;
        StrLength: Integer;
        DescLength: Integer;
        NewLength: Integer;
        RestLength: Integer;
    begin
        Summtext := Text5272722;
        if Summtext <> '' then
            if COPYSTR(Summtext, STRLEN(Summtext)) <> ' ' then
                Summtext := Summtext + ' ';
        StrLength := STRLEN(Summtext);
        Window.OPEN(Text5272726);

        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETFILTER("Document No.", PurchHeader."No.");
        with PurchLine do
            if FINDSET(true) then
                repeat
                    PurchLine2.RESET;
                    PurchLine2.SETRANGE("Document Type", PurchHeader."Document Type");
                    PurchLine2.SETRANGE("Document No.", PurchHeader."No.");
                    PurchLine2.SETRANGE("LBT Indentation", i - 1);
                    PurchLine2.SETFILTER("Line No.", '<%1', PurchLine."Line No.");
                    if PurchLine2.FINDLAST then;
                    if ("LBT Printoption" = "LBT Printoption"::"End Total") or
                        ((PurchLine2.FINDLAST) and
                        (PurchLineGetParentLine(PurchLine2)) and
                        (PurchLine."Attached to Line No." = 0))
                    then begin
                        if i < 1 then
                            ERROR(Text5272727, "No.");
                        if ((PurchLine2.FINDLAST) and
                          (PurchLineGetParentLine(PurchLine2)) and
                          (PurchLine."Attached to Line No." = 0))
                        then
                            i -= 1;
                        if "LBT Printoption" = "LBT Printoption"::"End Total" then begin
                            "LBT Summation" := AccNo[i] + '..' + FORMAT("Line No.");
                            Description := Summtext + Header[i];
                            i := i - 1;
                        end;
                    end;

                    "LBT Indentation" := i;
                    MODIFY;

                    if ("LBT Printoption" = "LBT Printoption"::"Begin Total") or
                      (PurchLineGetParentLine(PurchLine))
                    then begin
                        i += 1;
                        NoString := FORMAT("Line No.");
                        AccNo[i] := NoString;
                        DescLength := STRLEN(Description);
                        if StrLength + DescLength > 50 then begin
                            RestLength := StrLength + DescLength - 50;
                            NewLength := DescLength - RestLength;
                            NewString := DELSTR(Description, NewLength, 50);
                            Header[i] := NewString;
                        end else begin
                            Header[i] := Description;
                        end;
                    end;
                until NEXT = 0;
        Window.CLOSE;
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

        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        MaxIndent := 0;
        if PurchLine.FINDSET then
            repeat
                if PurchLine."LBT Indentation" > MaxIndent then
                    MaxIndent := PurchLine."LBT Indentation";
            until PurchLine.NEXT = 0;

        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        if PurchLine.ISEMPTY then
            exit;

        Merk1 := 0;
        Merk2 := 1;

        repeat
            PurchLine.SETRANGE("LBT Indentation", Merk1);
            if PurchLine.FINDSET(true) then begin
                repeat
                    if not (((PurchLine.Type = PurchLine.Type::" ") and
                              (PurchLine."LBT Printoption" = PurchLine."LBT Printoption"::Standard)) or
                            ((PurchLine."LBT Printoption" = PurchLine."LBT Printoption"::"End Total") or
                              (PurchLine."LBT Printoption" = PurchLine."LBT Printoption"::Title) or
                              (PurchLine."LBT Printoption" = PurchLine."LBT Printoption"::"New Page")))
                    then begin
                        PosMerker := '';
                        if PurchLine."LBT Indentation" > 0 then begin
                            PurchLine2.RESET;
                            PurchLine2.SETRANGE("Document Type", PurchHeader."Document Type");
                            PurchLine2.SETRANGE("Document No.", PurchHeader."No.");
                            PurchLine2.SETRANGE("LBT Indentation", PurchLine."LBT Indentation" - 1);
                            PurchLine2.SETFILTER("Line No.", '<%1', PurchLine."Line No.");
                            if (PurchLine2.FINDLAST) and
                              (PurchLine2."LBT Printoption" <> PurchLine2."LBT Printoption"::"End Total")
                            then begin
                                PosMerker := PurchLine2."LBT Pos. No.";
                                if (PurchLineGetParentLine(PurchLine2)) and
                                  (PurchLine."Attached to Line No." = 0)
                                then
                                    PosMerker := '';
                            end else
                                PosMerker := '';
                        end;
                        PurchLine3.RESET;
                        PurchLine3.SETRANGE("Document Type", PurchHeader."Document Type");
                        PurchLine3.SETRANGE("Document No.", PurchHeader."No.");
                        PurchLine3.SETFILTER("Line No.", '<%1', PurchLine."Line No.");
                        if PurchLine3.FINDLAST then
                            if (PurchLine3."LBT Printoption" = PurchLine3."LBT Printoption"::"Begin Total") or
                              (PurchLineGetParentLine(PurchLine3))
                            then
                                Merk2 := 1;

                        PurchLine."LBT Pos. No." := PosMerker + FORMAT(Merk2) + '.';
                        PurchLine.MODIFY;
                        Merk2 += 1;
                    end;
                until PurchLine.NEXT = 0;
                Merk1 := Merk1 + 1;
                Merk2 := 1;
            end;
        until Merk1 = MaxIndent + 1;

        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        PurchLine.SETRANGE("LBT Printoption", PurchLine."LBT Printoption"::"End Total");
        if PurchLine.FINDSET(true) then begin
            repeat
                PurchLine2.RESET;
                PurchLine2.SETRANGE("Document Type", PurchHeader."Document Type");
                PurchLine2.SETFILTER("Document No.", PurchHeader."No.");
                PurchLine2.SETRANGE("LBT Printoption", PurchLine2."LBT Printoption"::"Begin Total");
                PurchLine2.SETRANGE("LBT Indentation", PurchLine."LBT Indentation");
                PurchLine2.SETFILTER("Line No.", PurchLine."LBT Summation");
                if PurchLine2.FINDLAST then begin
                    PurchLine."LBT Pos. No." := PurchLine2."LBT Pos. No.";
                    PurchLine.MODIFY;
                end;
            until PurchLine.NEXT = 0;
        end;
    end;

    local procedure PurchLineGetParentLine(PurchLine: Record "Purchase Line"): Boolean
    var
        PurchLine2: Record "Purchase Line";
    begin
        PurchLine2.SETRANGE("Document Type", PurchLine."Document Type");
        PurchLine2.SETRANGE("Document No.", PurchLine."Document No.");
        PurchLine2.SETRANGE("Attached to Line No.", PurchLine."Line No.");
        PurchLine2.SETFILTER(Type, '<>%1', PurchLine2.Type::" ");
        exit(not PurchLine2.ISEMPTY);
    end;

    procedure DefragmentRowID(Type: Integer; Subtype: Integer; ID: Code[20]; BatchName: Code[20]; ProdOrderLine: Integer; RefNo: Integer): Text[250]
    var
        StrArray: array[2] of Text[100];
        Pos: Integer;
        Len: Integer;
        T: Integer;
    begin
        // Funktion zum zusammensetzen der RowID
        // somit werden alle wichtigen Kriterien generiert die für einen Filteraufbau von nöten sind

        StrArray[1] := ID;
        StrArray[2] := BatchName;
        for T := 1 to 2 do begin
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
        end;
        exit(STRSUBSTNO('"%1";"%2";"%3";"%4";"%5";"%6"', Type, Subtype, StrArray[1], StrArray[2], ProdOrderLine, RefNo));
    end;

    local procedure GetTypeFieldRef(var RecRef_L: RecordRef; FieldID: Integer) TextVar: Text
    var
        FieldRef_L: FieldRef;
        IntVar: Integer;
    begin
        FieldRef_L := RecRef_L.FIELD(FieldID);
        TextVar := FORMAT(FieldRef_L.TYPE);
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

    procedure GetStyleExpr(Printoption: Option Standard,Title,,"Price Invisible","Line Invisible",Alternative,Optional,"New Page","Begin Total","End Total") StyleExprText: Text
    var
        StyleExpr: Option Standard,StandardAccent,Strong,StrongAccent,Attention,AttentionAccent,Favorable,Unfavorable,Ambiguous,Subordinate;
    begin
        case Printoption of
            Printoption::"Price Invisible":
                StyleExprText := FORMAT(StyleExpr::Attention);
            Printoption::"Line Invisible":
                StyleExprText := FORMAT(StyleExpr::Subordinate);
            Printoption::Alternative:
                StyleExprText := FORMAT(StyleExpr::StrongAccent);
            Printoption::Optional:
                StyleExprText := FORMAT(StyleExpr::Favorable);
            Printoption::Title,
          Printoption::"Begin Total",
          Printoption::"End Total":
                StyleExprText := FORMAT(StyleExpr::Strong);
            else
                StyleExprText := FORMAT(StyleExpr::Standard);
        end;
    end;
}

