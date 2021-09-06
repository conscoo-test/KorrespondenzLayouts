codeunit 5272720 "lbt Corresp. Doc. Mgt"
{
    trigger OnRun()
    begin
    end;

    var
        IndentTxt: Label 'Indenting the Document #1##########', Comment = '%1 - Document Name';
        MissingBeginTotalTxt: Label 'End-Total %1 is missing a matching Begin-Total.', Comment = '%1 - End-Total Name';
        RowIDTemplateTxt: Label '"%1";"%2";"%3";"%4";"%5";"%6"', Locked = true;
        TotalTxt: Label 'Total';

    procedure SalesLineIndentTotaling(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        WindowDialog: Dialog;
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
        WindowDialog.OPEN(IndentTxt);

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetFilter("Document No.", SalesHeader."No.");
        if SalesLine.FindSet(true) then
            repeat
                WindowDialog.Update(1, SalesLine."No.");

                if SalesLine."lbt Printoption" = SalesLine."lbt Printoption"::"End Total" then begin
                    if i < 1 then
                        Error(MissingBeginTotalTxt);
                    SalesLine."lbt Summation" := AccNo[i] + '..' + FORMAT(SalesLine."Line No.");
                    SalesLine.Description := SummText + Header[i];
                    i -= 1;
                end;

                SalesLine."lbt Indentation" := i;
                SalesLine.Modify();

                if (SalesLine."lbt Printoption" = SalesLine."lbt Printoption"::"Begin Total") then begin
                    i += 1;
                    NoString := Format(SalesLine."Line No.");
                    AccNo[i] := NoString;
                    DescLength := STRLEN(SalesLine.Description);
                    if StrLength + DescLength > 50 then begin
                        RestLength := StrLength + DescLength - 50;
                        NewLength := DescLength - RestLength;
                        NewString := DELSTR(SalesLine.Description, NewLength, 50);
                        Header[i] := NewString;
                    end else
                        Header[i] := SalesLine.Description;

                end;
            until SalesLine.Next() = 0;
        WindowDialog.Close();
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
        SalesLine.SetFilter(Type, '%1..%2', SalesLine.Type::"G/L Account", SalesLine.Type::"Charge (Item)");
        if SalesLine.IsEmpty() then
            exit;

        Merk1 := 0;
        Merk2 := 1;

        repeat
            SalesLine.SetRange("lbt Indentation", Merk1);
            if SalesLine.FindSet(true) then begin
                repeat
                    PosMerker := '';
                    if SalesLine."lbt Indentation" > 0 then begin
                        SalesLine2.Reset();
                        SalesLine2.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLine2.SetRange("Document No.", SalesHeader."No.");
                        SalesLine2.SetFilter(Type, '%1..%2', SalesLine.Type::"G/L Account", SalesLine.Type::"Charge (Item)");
                        SalesLine2.SetRange("lbt Indentation", SalesLine."lbt Indentation" - 1);
                        SalesLine2.SetFilter("Line No.", '<%1', SalesLine."Line No.");
                        if SalesLine2.FindLast() then
                            PosMerker := SalesLine2."lbt Pos. No."
                        else
                            PosMerker := '';
                    end;
                    SalesLine3.Reset();
                    SalesLine3.SetRange("Document Type", SalesHeader."Document Type");
                    SalesLine3.SetRange("Document No.", SalesHeader."No.");
                    SalesLine3.SetFilter(Type, '%1..%2', SalesLine.Type::"G/L Account", SalesLine.Type::"Charge (Item)");
                    SalesLine3.SetFilter("Line No.", '<%1', SalesLine."Line No.");
                    if SalesLine3.FindLast() then
                        if (SalesLine3."lbt Printoption" = SalesLine3."lbt Printoption"::"Begin Total") then
                            Merk2 := 1;

                    SalesLine."lbt Pos. No." := CopyStr(PosMerker + Format(Merk2) + '.', 1, 30);
                    SalesLine.Modify();
                    Merk2 += 1;
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

    procedure PurchLineIndentTotaling(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        WindowDialog: Dialog;
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
        WindowDialog.OPEN(IndentTxt);

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetFilter("Document No.", PurchaseHeader."No.");
        if PurchaseLine.FindSet(true) then
            repeat
                if PurchaseLine.Type = PurchaseLine.Type::"Begin Total" then
                    PurchaseLine."lbt Printoption" := PurchaseLine."lbt Printoption"::Title;
                if PurchaseLine.Type = PurchaseLine.Type::"End Total" then
                    PurchaseLine."lbt Printoption" := PurchaseLine."lbt Printoption"::Total;
                PurchaseLine.Modify();
                WindowDialog.Update(1, PurchaseLine."No.");

                if PurchaseLine.Type = PurchaseLine.Type::"End Total" then begin
                    if i < 1 then
                        Error(MissingBeginTotalTxt, PurchaseLine."No.");
                    PurchaseLine."lbt Summation" := AccNo[i] + '..' + Format(PurchaseLine."Line No.");
                    PurchaseLine.Description := Summtext + Header[i];
                    i -= 1;
                end;

                PurchaseLine."lbt Indentation" := i;
                PurchaseLine.Modify();

                if (PurchaseLine.Type = PurchaseLine.Type::"Begin Total") then begin
                    i += 1;
                    NoString := Format(PurchaseLine."Line No.");
                    AccNo[i] := NoString;
                    DescLength := STRLEN(PurchaseLine.Description);
                    if StrLength + DescLength > 50 then begin
                        RestLength := StrLength + DescLength - 50;
                        NewLength := DescLength - RestLength;
                        NewString := DELSTR(PurchaseLine.Description, NewLength, 50);
                        Header[i] := NewString;
                    end else
                        Header[i] := PurchaseLine.Description;
                end;
            until PurchaseLine.Next() = 0;
        WindowDialog.Close();
    end;

    procedure PurchLinePosNumber(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        PurchLine3: Record "Purchase Line";
        MaxIndent: Integer;
        Merk1: Integer;
        Merk2: Integer;
        PosMerker: Text[30];
    begin
        PurchLineIndentTotaling(PurchaseHeader);

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        MaxIndent := 0;
        if PurchaseLine.FindSet() then
            repeat
                if PurchaseLine."lbt Indentation" > MaxIndent then
                    MaxIndent := PurchaseLine."lbt Indentation";
            until PurchaseLine.Next() = 0;

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetFilter(Type, '%1..%2', PurchaseLine.Type::"G/L Account", PurchaseLine.Type::"Begin Total");
        if PurchaseLine.IsEmpty() then
            exit;

        Merk1 := 0;
        Merk2 := 1;

        repeat
            PurchaseLine.SetRange("lbt Indentation", Merk1);
            if PurchaseLine.FindSet(true) then begin
                repeat
                    PosMerker := '';
                    if PurchaseLine."lbt Indentation" > 0 then begin
                        PurchLine2.Reset();
                        PurchLine2.SetRange("Document Type", PurchaseHeader."Document Type");
                        PurchLine2.SetRange("Document No.", PurchaseHeader."No.");
                        PurchLine2.SETFILTER(Type, '%1..%2', PurchaseLine.Type::"G/L Account", PurchaseLine.Type::"Begin Total");
                        PurchLine2.SetRange("lbt Indentation", PurchaseLine."lbt Indentation" - 1);
                        PurchLine2.SetFilter("Line No.", '<%1', PurchaseLine."Line No.");
                        if (PurchLine2.FindLast()) then
                            PosMerker := PurchLine2."lbt Pos. No."
                        else
                            PosMerker := '';
                    end;
                    PurchLine3.Reset();
                    PurchLine3.SetRange("Document Type", PurchaseHeader."Document Type");
                    PurchLine3.SetRange("Document No.", PurchaseHeader."No.");
                    PurchLine3.SETFILTER(Type, '%1..%2', PurchaseLine.Type::"G/L Account", PurchaseLine.Type::"Begin Total");
                    PurchLine3.SetFilter("Line No.", '<%1', PurchaseLine."Line No.");
                    if PurchLine3.FindLast() then
                        if (PurchLine3.Type = PurchLine3.Type::"Begin Total") then
                            Merk2 := 1;

                    PurchaseLine."lbt Pos. No." := CopyStr(PosMerker + Format(Merk2) + '.', 1, 30);
                    PurchaseLine.Modify();
                    Merk2 += 1;
                until PurchaseLine.Next() = 0;
                Merk1 := Merk1 + 1;
                Merk2 := 1;
            end;
        until Merk1 = MaxIndent + 1;

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetRange(Type, PurchaseLine.Type::"End Total");
        if PurchaseLine.FindSet(true) then
            repeat
                PurchLine2.Reset();
                PurchLine2.SetRange("Document Type", PurchaseHeader."Document Type");
                PurchLine2.SetFilter("Document No.", PurchaseHeader."No.");
                PurchLine2.SetRange(Type, PurchLine2.Type::"Begin Total");
                PurchLine2.SetRange("lbt Indentation", PurchaseLine."lbt Indentation");
                PurchLine2.SetFilter("Line No.", PurchaseLine."lbt Summation");
                if PurchLine2.FindLast() then begin
                    PurchaseLine."lbt Pos. No." := PurchLine2."lbt Pos. No.";
                    PurchaseLine.Modify();
                end;
            until PurchaseLine.Next() = 0;

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

        exit(STRSUBSTNO(RowIDTemplateTxt, Type, Subtype, StrArray[1], StrArray[2], ProdOrderLine, RefNo));
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

