reportextension 52753 "lbt Sales Credit Memo" extends "ForNAV VAT Credit Memo"
{
    dataset
    {
        add(Header)
        {
            column(lbtCompanyAddressLine; CompanyAddressLine)
            {
                IncludeCaption = false;
            }
            column(lbtHeaderText; HeaderText)
            {
                IncludeCaption = false;
            }
            column(lbtFooterText; FooterText)
            {
                IncludeCaption = false;
            }
        }
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            begin
                HeaderText := Header.lbtGetPrintData("lbt Position"::EditorHeader);
                FooterText := Header.lbtGetPrintData("lbt Position"::EditorFooter);
            end;
        }
        add(Line)
        {
            column(lbtLineText; LineText)
            {
                IncludeCaption = false;
            }
            column(lbtShipmentDate; ShipmentDate)
            {
                IncludeCaption = false;
            }
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                LineText := Line.lbtGetPrintData("lbt Position"::EditorLine);
                ShipmentDate := GetShipmentDate();
            end;
        }
    }

    trigger OnPreReport()
    var
        lbtFormatDocument: Codeunit "lbt Format Document";
    begin
        CompanyAddressLine := lbtFormatDocument.CompanyAddressLine();
    end;

    local procedure GetShipmentDate(): Date
    var
        ReturnReceiptHeader: Record "Return Receipt Header";
        SalesShipmentBuffer: Record "Sales Shipment Buffer";
    begin
        if Line."Return Receipt No." <> '' then
            if ReturnReceiptHeader.Get(Line."Return Receipt No.") then
                exit(ReturnReceiptHeader."Posting Date");
        if Header."Return Order No." = '' then
            exit(Header."Posting Date");
        if Line.Type = Line.Type::" " then
            exit(0D);

        SalesShipmentBuffer.GetLinesForSalesCreditMemoLine(Line, Header);

        SalesShipmentBuffer.Reset();
        SalesShipmentBuffer.SetRange("Line No.", Line."Line No.");
        if SalesShipmentBuffer.Find('-') then
            if SalesShipmentBuffer.Next() = 0 then
                exit(SalesShipmentBuffer."Posting Date");
        exit(Header."Posting Date");
    end;

    var
        CompanyAddressLine: Text;
        HeaderText: Text;
        FooterText: Text;
        LineText: Text;
        ShipmentDate: Date;
}