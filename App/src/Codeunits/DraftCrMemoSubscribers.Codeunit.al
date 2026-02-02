codeunit 5272735 "lbt Draft Cr.Memo Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforeGetSalesDocTypeUsage', '', false, false)]
    local procedure HandleOnBeforeGetSalesDocTypeUsage(SalesHeader: Record "Sales Header"; var ReportSelectionUsage: Enum "Report Selection Usage"; var IsHandled: Boolean)
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::"Credit Memo" then
            exit;
        ReportSelectionUsage := ReportSelectionUsage::"lbt S.Cr.Memo Draft";
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Sales", 'OnSetUsageFilterOnAfterSetFiltersByReportUsage', '', false, false)]
    local procedure HandleOnSetUsageFilterOnAfterSetFiltersByReportUsage(var Rec: Record "Report Selections"; ReportUsage2: Option)
    var
        SelectionUsageSales: Enum "Report Selection Usage Sales";
    begin
        SelectionUsageSales := Enum::"Report Selection Usage Sales".FromInteger(ReportUsage2);
        case SelectionUsageSales of
            SelectionUsageSales::"lbt Draft Credit Memo":
                Rec.SetRange("Usage", Enum::"Report Selection Usage"::"lbt S.Cr.Memo Draft");
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Sales", 'OnInitUsageFilterOnElseCase', '', false, false)]
    local procedure HandleOnInitUsageFilterOnElseCase(ReportUsage: Enum "Report Selection Usage"; var ReportUsage2: Enum "Report Selection Usage Sales")
    begin
        case ReportUsage of
            ReportUsage::"lbt S.Cr.Memo Draft":
                ReportUsage2 := Enum::"Report Selection Usage Sales"::"lbt Draft Credit Memo";
        end;
    end;



}