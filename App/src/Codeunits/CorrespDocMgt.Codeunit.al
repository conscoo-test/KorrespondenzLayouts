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

    procedure Number(Indent: Integer; Prefix: Text[30]; var SalesLine: Record "Sales Line"): Boolean
    var
        Counter: Integer;
        PosNo: Text[30];
    begin
        Counter := 1;
        repeat
            if SalesLine."lbt Printoption" = SalesLine."lbt Printoption"::"End Total" then begin
                SalesLine."lbt Pos. No." := Prefix;
                SalesLine.Modify();
                exit;
            end;
            if (SalesLine.Type <> SalesLine.Type::" ") or (SalesLine."lbt Printoption" = SalesLine."lbt Printoption"::"Begin Total") then begin
                PosNo := StrSubstNo('%1%2.', Prefix, Counter);
                Counter += 1;
                SalesLine."lbt Pos. No." := PosNo;
                SalesLine.Modify();
            end;
            if SalesLine."lbt Printoption" = SalesLine."lbt Printoption"::"Begin Total" then begin
                SalesLine.Next();
                Number(Indent + 1, PosNo, SalesLine);
            end;
        until SalesLine.Next() = 0;
    end;

    procedure Number(Indent: Integer; Prefix: Text[30]; var PurchaseLine: Record "Purchase Line"): Boolean
    var
        Counter: Integer;
        PosNo: Text[30];
    begin
        Counter := 1;
        repeat
            if PurchaseLine."lbt Printoption" = PurchaseLine."lbt Printoption"::"End Total" then begin
                PurchaseLine."lbt Pos. No." := Prefix;
                PurchaseLine.Modify();
                exit;
            end;
            if (PurchaseLine.Type <> PurchaseLine.Type::" ") or (PurchaseLine."lbt Printoption" = PurchaseLine."lbt Printoption"::"Begin Total") then begin
                PosNo := StrSubstNo('%1%2.', Prefix, Counter);
                Counter += 1;
                PurchaseLine."lbt Pos. No." := PosNo;
                PurchaseLine.Modify();
            end;
            if PurchaseLine."lbt Printoption" = PurchaseLine."lbt Printoption"::"Begin Total" then begin
                PurchaseLine.Next();
                Number(Indent + 1, PosNo, PurchaseLine);
            end;
        until PurchaseLine.Next() = 0;
    end;

    procedure SalesLinePosNumber(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLineIndentTotaling(SalesHeader);

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            Number(0, '', SalesLine);
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
                WindowDialog.Update(1, PurchaseLine."No.");

                if PurchaseLine."lbt Printoption" = PurchaseLine."lbt Printoption"::"End Total" then begin
                    if i < 1 then
                        Error(MissingBeginTotalTxt, PurchaseLine."No.");
                    PurchaseLine."lbt Summation" := AccNo[i] + '..' + Format(PurchaseLine."Line No.");
                    PurchaseLine.Description := Summtext + Header[i];
                    i -= 1;
                end;

                PurchaseLine."lbt Indentation" := i;
                PurchaseLine.Modify();

                if (PurchaseLine."lbt Printoption" = PurchaseLine."lbt Printoption"::"Begin Total") then begin
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
    begin
        PurchLineIndentTotaling(PurchaseHeader);

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            Number(0, '', PurchaseLine);
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

