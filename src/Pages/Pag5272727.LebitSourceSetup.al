page 5272727 "LBT Source Setup"
{
    Caption = 'LBT Source Setup';
    PageType = List;
    SourceTable = "LBT Source Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater("Group Sales")
            {
                Visible = SalesVisible;
                field(SalesReportType; SalesReportType)
                {
                    ApplicationArea = All;
                    Caption = 'Report Type';
                    OptionCaption = 'General,Sales Quote,Sales Order,Sales Pro Forma Inv,Blanket Sales Order';

                    trigger OnValidate()
                    begin
                        SetReportType;
                    end;
                }
                field(SalesSourceType; SalesSourceType)
                {
                    ApplicationArea = All;
                    Caption = 'Source Type';
                    OptionCaption = 'Default,Bill-to Customer,Sell-to Customer';

                    trigger OnValidate()
                    begin
                        SetSourceType;
                    end;
                }
            }
            repeater("Group Purch")
            {
                Visible = PurchVisible;
                field(PurchReportType; PurchReportType)
                {
                    ApplicationArea = All;
                    Caption = 'Report Type';
                    OptionCaption = 'General,Purchase Quote,Purchase Order,Blanket Purchase Order';

                    trigger OnValidate()
                    begin
                        SetReportType;
                    end;
                }
                field(PurchSourceType; PurchSourceType)
                {
                    ApplicationArea = All;
                    Caption = 'Source Type';
                    OptionCaption = 'Default,Pay-to Vendor,Buy-from Vendor';

                    trigger OnValidate()
                    begin
                        SetSourceType;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetReportVar;
        SetSourceVar;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetReportVar;
        SetSourceVar;
    end;

    trigger OnOpenPage()
    begin
        FILTERGROUP := 3;
        case GETFILTER(Type) of
            FORMAT(Type::Sales):
                begin
                    SalesVisible := true;
                    if ISEMPTY then begin
                        Type := Type::Sales;
                        "Report Type" := "Report Type"::General;
                        "Source Type" := "Source Type"::Default;
                        INSERT;
                    end;
                end;
            FORMAT(Type::Purchase):
                begin
                    PurchVisible := true;
                    if ISEMPTY then begin
                        Type := Type::Purchase;
                        "Report Type" := "Report Type"::General;
                        "Source Type" := "Source Type"::Default;
                        INSERT;
                    end;
                end;
        end;
        FILTERGROUP := 0;
    end;

    var
        SalesReportType: Option General,"Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order";
        PurchReportType: Option General,"Purchase Quote","Purchase Order","Blanket Purchase Order";
        SalesSourceType: Option Default,"Bill-to Customer","Sell-to Customer";
        PurchSourceType: Option Default,"Pay-to Vendor","Buy-from Vendor";
        SalesVisible: Boolean;
        PurchVisible: Boolean;

    local procedure SetReportType()
    begin
        case Type of
            Type::Sales:
                case SalesReportType of
                    SalesReportType::"Sales Quote":
                        "Report Type" := "Report Type"::"Sales Quote";
                    SalesReportType::"Sales Order":
                        "Report Type" := "Report Type"::"Sales Order";
                    SalesReportType::"Sales Pro Forma Inv":
                        "Report Type" := "Report Type"::"Sales Pro Forma Inv";
                    SalesReportType::"Blanket Sales Order":
                        "Report Type" := "Report Type"::"Blanket Sales Order";
                end;
            Type::Purchase:
                case PurchReportType of
                    PurchReportType::"Purchase Quote":
                        "Report Type" := "Report Type"::"Purchase Quote";
                    PurchReportType::"Purchase Order":
                        "Report Type" := "Report Type"::"Purchase Order";
                    PurchReportType::"Blanket Purchase Order":
                        "Report Type" := "Report Type"::"Blanket Purchase Order";
                end;
        end;
    end;

    local procedure SetSourceType()
    begin
        case Type of
            Type::Sales:
                case SalesSourceType of
                    SalesSourceType::Default:
                        "Source Type" := "Source Type"::Default;
                    SalesSourceType::"Bill-to Customer":
                        "Source Type" := "Source Type"::"Bill-to Customer";
                    SalesSourceType::"Sell-to Customer":
                        "Source Type" := "Source Type"::"Sell-to Customer";
                end;
            Type::Purchase:
                case PurchSourceType of
                    PurchSourceType::Default:
                        "Source Type" := "Source Type"::Default;
                    PurchSourceType::"Buy-from Vendor":
                        "Source Type" := "Source Type"::"Buy-from Vendor";
                    PurchSourceType::"Pay-to Vendor":
                        "Source Type" := "Source Type"::"Pay-to Vendor";
                end;
        end;
    end;

    local procedure SetReportVar()
    begin
        case "Report Type" of
            "Report Type"::General:
                begin
                    SalesReportType := SalesReportType::General;
                    PurchReportType := PurchReportType::General;
                end;
            "Report Type"::"Sales Quote":
                SalesReportType := SalesReportType::"Sales Quote";
            "Report Type"::"Sales Order":
                SalesReportType := SalesReportType::"Sales Order";
            "Report Type"::"Sales Pro Forma Inv":
                SalesReportType := SalesReportType::"Sales Pro Forma Inv";
            "Report Type"::"Blanket Sales Order":
                SalesReportType := SalesReportType::"Blanket Sales Order";
            "Report Type"::"Purchase Quote":
                PurchReportType := PurchReportType::"Purchase Quote";
            "Report Type"::"Purchase Order":
                PurchReportType := PurchReportType::"Purchase Order";
            "Report Type"::"Blanket Purchase Order":
                PurchReportType := PurchReportType::"Blanket Purchase Order";
        end;
    end;

    local procedure SetSourceVar()
    begin
        case "Source Type" of
            "Source Type"::Default:
                begin
                    SalesSourceType := SalesSourceType::Default;
                    PurchSourceType := PurchSourceType::Default;
                end;
            "Source Type"::"Bill-to Customer":
                SalesSourceType := SalesSourceType::"Bill-to Customer";
            "Source Type"::"Sell-to Customer":
                SalesSourceType := SalesSourceType::"Sell-to Customer";
            "Source Type"::"Buy-from Vendor":
                PurchSourceType := PurchSourceType::"Buy-from Vendor";
            "Source Type"::"Pay-to Vendor":
                PurchSourceType := PurchSourceType::"Pay-to Vendor";
        end;
    end;
}

