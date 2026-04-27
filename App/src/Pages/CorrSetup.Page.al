page 5272728 "lbt Corr Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "lbt Corr Setup";
    Caption = 'LeBit Extended Layout Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Always print VAT"; Rec."Always print VAT")
                {
                    ToolTip = 'If selected VAT will be printed in reports even if it is 0.';
                }
                group(Sales)
                {
                    Caption = 'Sales';
                    field("Copy Quote Texts"; Rec."Copy Quote Texts")
                    {
                        ToolTip = 'This option affects the copying of header and footer texts from the quotation to the sales order.';
                    }
                    field("Copy Blanket Order Texts"; Rec."Copy Blanket Order Texts")
                    {
                        ToolTip = 'This option affects the copying of header and footer texts from the blanket order to the sales order.';
                    }
                    field("S.Print select Copy order"; Rec."S.Print select Copy order")
                    {
                        ToolTip = 'The configured option controls how "print option," "Optional" are handled when converting the sales quote into a sales order.Hint: Positions of type "Alternative" won''t ever be transfered.',
                        Comment = 'de-DE=Die eingerichtete Option steuert den Umgang mit "Druckauswahl" "Bedarfsposition" beim Überführen des Angebots in einen Verkaufsauftrag.Hinweis: Alternativpositionen können nicht mit in einen Auftrag überführt werden';
                    }
                }
                group(Purchase)
                {
                    Caption = 'Purchase', Comment = 'de-DE=Einkauf';
                    field("P.Print select Copy order"; Rec."P.Print select Copy order")
                    {
                        ToolTip = 'The configured option controls how "print option," "Optional" are handled when converting the purchase quote into a purchase order.Hint: Positions of type "Alternative" won''t ever be transfered.',
                        Comment = 'de-DE=Die eingerichtete Option steuert den Umgang mit "Druckauswahl" "Bedarfsposition" beim Überführen der Anfrage in eine Einkaufsbestellung.Hinweis: Alternativpositionen können nicht mit in eine Bestellung überführt werden';
                    }
                }
                group(Service)
                {
                    Caption = 'Service';
                    field("Copy ServiceQuote Texts"; Rec."Copy ServiceQuote Texts")
                    {
                        ToolTip = 'This option affects the copying of header and footer texts from the service quotation to the service order.';
                    }
                }
            }
            group("Automatic Numbering and Totaling")
            {
                Caption = 'Automatic Numbering and Totaling', Comment = 'de-DE=Automatische Nummerierung und Summierung';
                group(SalesTotaling)
                {
                    Caption = 'Sales', Comment = 'de-DE=Verkauf';
                    field("S.Quote Automatic Numbering"; Rec."S.Quote Automatic Numbering")
                    {
                        Caption = 'Quote', Comment = 'de-DE=Angebot';
                        ToolTip = 'If selected, the system will automatically number and total the sales quote before printing.',
                        Comment = 'de-DE=Wenn ausgewählt, wird das System das Verkaufsangebot beim Drucken automatisch nummerieren und summieren.';
                    }
                    field("S.Blanket Order Automatic Numbering"; Rec."S.Blanket Order Aut. Numbering")
                    {
                        Caption = 'Blanket Order', Comment = 'de-DE=Rahmenauftrag';
                        ToolTip = 'If selected, the system will automatically number and total the sales blanket order before printing.',
                        Comment = 'de-DE=Wenn ausgewählt, wird das System den Verkaufsrahmenauftrag beim Drucken automatisch nummerieren und summieren.';
                    }
                    field("S.Order Automatic Numbering"; Rec."S.Order Automatic Numbering")
                    {
                        Caption = 'Order', Comment = 'de-DE=Auftrag';
                        ToolTip = 'If selected, the system will automatically number and total the sales order before printing.',
                        Comment = 'de-DE=Wenn ausgewählt, wird das System den Verkaufsauftrag beim Drucken automatisch nummerieren und summieren.';
                    }
                    field("S.Invoice Automatic Numbering"; Rec."S.Invoice Automatic Numbering")
                    {
                        Caption = 'Invoice', Comment = 'de-DE=Rechnung';
                        ToolTip = 'If selected, the system will automatically number and total the sales invoice before printing.',
                        Comment = 'de-DE=Wenn ausgewählt, wird das System die Verkaufsrechnung beim Drucken automatisch nummerieren und summieren.';
                    }
                    field("S.Credit Memo Automatic Numbering"; Rec."S.Credit Memo Automatic Numbering")
                    {
                        Caption = 'Credit Memo', Comment = 'de-DE=Gutschrift';
                        ToolTip = 'If selected, the system will automatically number and total the sales credit memo before printing.',
                        Comment = 'de-DE=Wenn ausgewählt, wird das System die Verkaufsgutschrift beim Drucken automatisch nummerieren und summieren.';

                    }
                    field("S.Return Order Automatic Numbering"; Rec."S.Return Order Automatic Numbering")
                    {
                        Caption = 'Return Order', Comment = 'de-DE=Reklamation';
                        ToolTip = 'If selected, the system will automatically number and total the sales return order before printing.',
                        Comment = 'de-DE=Wenn ausgewählt, wird das System die Verkaufsreklamation beim Drucken automatisch nummerieren und summieren.';
                    }
                }
                group(PurchaseTotaling)
                {
                    Caption = 'Purchase', Comment = 'de-DE=Einkauf';
                    field("P.Quote Automatic Numbering"; Rec."P.Quote Automatic Numbering")
                    {
                        Caption = 'Quote', Comment = 'de-DE=Anfrage';
                        ToolTip = 'If selected, the system will automatically number and total the purchase quote before printing.',
                        Comment = 'de-DE=Wenn ausgewählt, wird das System die Einkaufsanfrage beim Drucken automatisch nummerieren und summieren.';
                    }
                    field("P.Blanket Order Automatic Numbering"; Rec."P.Blanket Order Aut. Numbering")
                    {
                        Caption = 'Blanket Order', Comment = 'de-DE=Rahmenbestellung';
                        ToolTip = 'If selected, the system will automatically number and total the purchase blanket order before printing.',
                        Comment = 'de-DE=Wenn ausgewählt, wird das System den Einkaufsrahmenauftrag beim Drucken automatisch nummerieren und summieren.';
                    }
                    field("P.Order Automatic Numbering"; Rec."P.Order Automatic Numbering")
                    {
                        Caption = 'Order', Comment = 'de-DE=Bestellung';
                        ToolTip = 'If selected, the system will automatically number and total the purchase order before printing.',
                        Comment = 'de-DE=Wenn ausgewählt, wird das System die Einkaufsbestellung beim Drucken automatisch nummerieren und summieren.';
                    }
                    field("P.Invoice Automatic Numbering"; Rec."P.Invoice Automatic Numbering")
                    {
                        Caption = 'Invoice', Comment = 'de-DE=Rechnung';
                        ToolTip = 'If selected, the system will automatically number and total the purchase invoice before printing.',
                        Comment = 'de-DE=Wenn ausgewählt, wird das System die Einkaufsrechnung beim Drucken automatisch nummerieren und summieren.';
                    }
                    field("P.Credit Memo Automatic Numbering"; Rec."P.Credit Memo Automatic Numbering")
                    {
                        Caption = 'Credit Memo', Comment = 'de-DE=Gutschrift';
                        ToolTip = 'If selected, the system will automatically number and total the purchase credit memo before printing.',
                        Comment = 'de-DE=Wenn ausgewählt, wird das System die Einkaufsgutschrift beim Drucken automatisch nummerieren und summieren.';
                    }
                    field("P.Return Order Automatic Numbering"; Rec."P.Return Order Automatic Numbering")
                    {
                        Caption = 'Return Order', Comment = 'de-DE=Reklamation';
                        ToolTip = 'If selected, the system will automatically number and total the purchase return order before printing.',
                        Comment = 'de-DE=Wenn ausgewählt, wird das System die Einkaufsreklamation beim Drucken automatisch nummerieren und summieren.';
                    }
                }
            }
            group(Texts)
            {
                Caption = 'Texts', Comment = 'de-DE=Texte';
                field("Copy General Text From Order"; Rec."Copy General Text From Order")
                {
                    ToolTip = 'If selected, the normal header and footer texts from the order will be copied to the invoice and shipment documents if the invoice or shipment header and footer texts are empty.',
                    Comment = 'de-DE=Wenn ausgewählt, werden die normalen Kopf- und Fußzeilentexte aus dem Auftrag in die Rechnungs- und Lieferscheindokumente kopiert, wenn die Rechnungs- oder Liefer- Kopf- und Fußzeilentexte leer sind.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Delete Empty Textheaders")
            {
                Caption = 'Delete Empty Textheaders';
                Image = Delete;

                trigger OnAction()
                var
                    ExtendedTextHeader: Record "Extended Text Header";
                    cnt: Integer;
                    DeleteQst: Label 'Are you sure you want to delete all empty textheaders?';
                    SuccessMsg: Label 'Deleted %1 empty textheaders.', Comment = '%1=Count';
                begin
                    if not Confirm(DeleteQst) then
                        exit;
                    ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::"Standard Text");
                    ExtendedTextHeader.SetRange("No.", '');
                    cnt := ExtendedTextHeader.Count;
                    ExtendedTextHeader.DeleteAll(true);
                    Message(SuccessMsg, cnt);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end
    end;
}