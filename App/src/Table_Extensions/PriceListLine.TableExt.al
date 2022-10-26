tableextension 5272770 "lbt cl PriceListLine" extends "Price List Line"
{

    fields
    {
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
            Caption = 'Price in Price Factor';
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            trigger OnValidate()
            begin
                lbtclSetUnitPrice(FieldNo("lbt cl Price in Price Factor"));
            end;

        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                lbtclSetUnitPrice(FieldNo("Unit Price"));
            end;
        }
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                lbtclSetUnitPrice(FieldNo("Direct Unit Cost"));

            end;
        }
    }
    ///H22/0437
    procedure lbtclSetUnitPrice(CurrentFieldNo: Integer)
    var
        CorrespDocMgt: Codeunit "lbt Corresp. Doc. Mgt";

    begin
        case "Source Group" of
            "Source Group"::Customer:
                begin
                    case CurrentFieldNo of
                        FieldNo("lbt cl Price in Price Factor"):
                            Validate("Unit Price", "lbt cl Price in Price Factor" / CorrespDocMgt.GetPriceFactor("lbt cl Price Factor"));
                        FieldNo("Unit Price"), FieldNo("lbt cl Price Factor"):
                            "lbt cl Price in Price Factor" := "Unit Price" * CorrespDocMgt.GetPriceFactor("lbt cl Price Factor");
                    end;
                end;
            "Source Group"::Vendor:
                begin
                    case CurrentFieldNo of
                        FieldNo("lbt cl Price in Price Factor"):
                            Validate("direct unit Cost", "lbt cl Price in Price Factor" / CorrespDocMgt.GetPriceFactor("lbt cl Price Factor"));
                        FieldNo("Direct Unit Cost"), FieldNo("lbt cl Price Factor"):
                            "lbt cl Price in Price Factor" := "Direct Unit Cost" * CorrespDocMgt.GetPriceFactor("lbt cl Price Factor");
                    end;
                end;
        end;
    end;
}
