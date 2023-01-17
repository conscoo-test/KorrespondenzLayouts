tableextension 5272772 "lbtcl RequisitionLine" extends "Requisition Line"
{
    fields
    {
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                lbtclSetUnitPrice(FieldNo("Direct Unit Cost"));
            end;
        }
        field(5272730; "lbt cl Price Factor"; Enum "lbt cl Price Factor")
        {
            Caption = 'Price Factor';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                lbtclSetUnitPrice(FieldNo("lbt cl Price Factor"));
            end;
        }
        field(5272731; "lbt cl Price in Price Factor"; Decimal)
        {
            Caption = 'Unit Price in Price Factor';
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            //CaptionClass = GetCaptionClass(FieldNo("lbt cl Price in Price Factor"));
            trigger OnValidate()
            begin
                lbtclSetUnitPrice(FieldNo("lbt cl Price in Price Factor"));
            end;
        }
    }
    procedure lbtclSetUnitPrice(CurrentFieldNo: Integer)
    var
        CorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";

    begin
        case CurrentFieldNo of
            FieldNo("lbt cl Price in Price Factor"):
                Validate("Direct Unit Cost", "lbt cl Price in Price Factor" / CorrespDocMgt.GetPriceFactor("lbt cl Price Factor"));
            FieldNo("Direct Unit Cost"), FieldNo("lbt cl Price Factor"):
                "lbt cl Price in Price Factor" := "Direct Unit Cost" * CorrespDocMgt.GetPriceFactor("lbt cl Price Factor");
        end;
    end;
}
