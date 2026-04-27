codeunit 5272720 "lbt Corresp. Doc. Mgt"
{
    trigger OnRun()
    begin
    end;

    var
        IndentTxt: Label 'Indenting the Document #1##########', Comment = '%1 - Document Name';
        MissingBeginTotalTxt: Label 'End-Total %1 is missing a matching Begin-Total.', Comment = '%1 - End-Total Name';
        PosNoTemplateLbl: Label '%1%2.', Locked = true;
        TotalTxt: Label 'Total';

    procedure GetPriceFactor(PriceFactor: Enum "lbt cl Price Factor") Result: Decimal
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetPriceFactor(PriceFactor, IsHandled, Result);
        if IsHandled then
            exit;
        case PriceFactor of
            PriceFactor::"1":
                Result := 1;
            PriceFactor::"10":
                Result := 10;
            PriceFactor::"100":
                Result := 100;
            PriceFactor::"1000":
                Result := 1000;
        end;
    end;

    procedure GetStyleExpr(Printoption: Enum "lbt cl Printoption") StyleExprText: Text[30]
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
            Printoption::Bold,
            Printoption::Title,
            Printoption::"Begin Total",
            Printoption::"End Total":
                StyleExprText := Format(StyleExpr::Strong);
            else
                StyleExprText := Format(StyleExpr::Standard);
        end;
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
                PosNo := StrSubstNo(PosNoTemplateLbl, Prefix, Counter);
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
                PosNo := StrSubstNo(PosNoTemplateLbl, Prefix, Counter);
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

    procedure PurchLineIndentTotaling(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        AccNo: array[10] of Code[20];
        WindowDialog: Dialog;
        Indentation: Integer;
        Header: array[10] of Text;
        Summtext: Text;
    begin
        Indentation := 0;
        Summtext := TotalTxt;
        if not Summtext.EndsWith(' ') then
            Summtext := Summtext + ' ';
        WindowDialog.Open(IndentTxt);

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetFilter("Document No.", PurchaseHeader."No.");
        if PurchaseLine.FindSet(true) then
            repeat
                WindowDialog.Update(1, PurchaseLine."No.");

                if PurchaseLine."lbt Printoption" = PurchaseLine."lbt Printoption"::"End Total" then begin
                    if Indentation < 1 then
                        Error(MissingBeginTotalTxt, PurchaseLine."No.");
                    PurchaseLine."lbt Summation" := AccNo[Indentation] + '..' + Format(PurchaseLine."Line No.");
                    PurchaseLine.Description := CopyStr(Summtext + Header[Indentation], 1, MaxStrLen(PurchaseLine.Description));
                    Indentation -= 1;
                end;

                PurchaseLine."lbt Indentation" := Indentation;
                PurchaseLine.Modify();

                if (PurchaseLine."lbt Printoption" = PurchaseLine."lbt Printoption"::"Begin Total") then begin
                    Indentation += 1;
                    AccNo[Indentation] := Format(PurchaseLine."Line No.");
                    ;
                    Header[Indentation] := PurchaseLine.Description;
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

    procedure SalesLineIndentTotaling(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        AccNo: array[10] of Code[20];
        WindowDialog: Dialog;
        Indentation: Integer;
        Header: array[10] of Text;
        SummText: Text;
    begin
        Indentation := 0;
        SummText := TotalTxt;
        if not SummText.EndsWith(' ') then
            SummText := SummText + ' ';
        WindowDialog.Open(IndentTxt);

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetFilter("Document No.", SalesHeader."No.");
        if SalesLine.FindSet(true) then
            repeat
                WindowDialog.Update(1, SalesLine."No.");

                if SalesLine."lbt Printoption" = SalesLine."lbt Printoption"::"End Total" then begin
                    if Indentation < 1 then
                        Error(MissingBeginTotalTxt);
                    SalesLine."lbt Summation" := AccNo[Indentation] + '..' + Format(SalesLine."Line No.");
                    SalesLine.Description := CopyStr(SummText + Header[Indentation], 1, MaxStrLen(SalesLine.Description));
                    Indentation -= 1;
                end;

                SalesLine."lbt Indentation" := Indentation;
                SalesLine.Modify();

                if (SalesLine."lbt Printoption" = SalesLine."lbt Printoption"::"Begin Total") then begin
                    Indentation += 1;
                    AccNo[Indentation] := Format(SalesLine."Line No.");
                    Header[Indentation] := SalesLine.Description;
                end;
            until SalesLine.Next() = 0;
        WindowDialog.Close();
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

    procedure GetStyleExprBold(Printoption: Enum "lbt cl Printoption") StyleExprText: Text[30]
    var
        StyleExpr: Option Standard,StandardAccent,Strong,StrongAccent,Attention,AttentionAccent,Favorable,Unfavorable,Ambiguous,Subordinate;
    begin
        case Printoption of
            Printoption::Bold,
            Printoption::Title,
            Printoption::"Begin Total",
            Printoption::"End Total":
                StyleExprText := Format(StyleExpr::Strong);
            else
                StyleExprText := Format(StyleExpr::Standard);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetPriceFactor(PriceFactor: Enum "lbt cl Price Factor"; var Ishandled: Boolean; var Result: Decimal)
    begin
    end;
}
