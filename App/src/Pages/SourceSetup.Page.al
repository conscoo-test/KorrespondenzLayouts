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
                field(SalesReportType; SalesReportTypeOption)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please select the report type';
                    Caption = 'Report Type';
                    OptionCaption = 'General,"Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order"';

                    trigger OnValidate()
                    begin
                        SetReportType();
                    end;
                }
                field(SalesSourceType; SalesSourceTypeOption)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please select type of origin';
                    Caption = 'Source Type';
                    OptionCaption = 'Default,"Bill-to Customer","Sell-to Customer"';


                    trigger OnValidate()
                    begin
                        SetSourceType();
                    end;
                }
            }
            repeater("Group Purch")
            {
                Visible = PurchVisible;
                field(PurchReportType; PurchReportTypeOption)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please select the report type';
                    Caption = 'Report Type';
                    OptionCaption = 'General,"Purchase Quote","Purchase Order","Blanket Purchase Order"';


                    trigger OnValidate()
                    begin
                        SetReportType();
                    end;
                }
                field(PurchSourceType; PurchSourceTypeOption)
                {
                    ApplicationArea = All;
                    ToolTip = 'Please select type of origin';
                    Caption = 'Source Type';
                    OptionCaption = 'Default,"Pay-to Vendor","Buy-from Vendor"';

                    trigger OnValidate()
                    begin
                        SetSourceType();
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
        SetReportVar();
        SetSourceVar();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetReportVar();
        SetSourceVar();
    end;

    trigger OnOpenPage()
    begin
        FILTERGROUP := 3;
        case GETFILTER(Type) of
            FORMAT(Type::Sales):
                begin
                    SalesVisible := true;
                    if IsEmpty() then begin
                        Type := Type::Sales;
                        "Report Type" := "Report Type"::General;
                        "Source Type" := "Source Type"::Default;
                        Insert();
                    end;
                end;
            FORMAT(Type::Purchase):
                begin
                    PurchVisible := true;
                    if IsEmpty() then begin
                        Type := Type::Purchase;
                        "Report Type" := "Report Type"::General;
                        "Source Type" := "Source Type"::Default;
                        Insert();
                    end;
                end;
        end;
        FILTERGROUP := 0;
    end;

    var
        SalesReportTypeOption: Option General,"Sales Quote","Sales Order","Sales Pro Forma Inv","Blanket Sales Order";
        PurchReportTypeOption: Option General,"Purchase Quote","Purchase Order","Blanket Purchase Order";
        SalesSourceTypeOption: Option Default,"Bill-to Customer","Sell-to Customer";
        PurchSourceTypeOption: Option Default,"Pay-to Vendor","Buy-from Vendor";
        SalesVisible: Boolean;
        PurchVisible: Boolean;

    local procedure SetReportType()
    begin
        case Type of
            Type::Sales:
                case SalesReportTypeOption of
                    SalesReportTypeOption::"Sales Quote":
                        "Report Type" := "Report Type"::"Sales Quote";
                    SalesReportTypeOption::"Sales Order":
                        "Report Type" := "Report Type"::"Sales Order";
                    SalesReportTypeOption::"Sales Pro Forma Inv":
                        "Report Type" := "Report Type"::"Sales Pro Forma Inv";
                    SalesReportTypeOption::"Blanket Sales Order":
                        "Report Type" := "Report Type"::"Blanket Sales Order";
                end;
            Type::Purchase:
                case PurchReportTypeOption of
                    PurchReportTypeOption::"Purchase Quote":
                        "Report Type" := "Report Type"::"Purchase Quote";
                    PurchReportTypeOption::"Purchase Order":
                        "Report Type" := "Report Type"::"Purchase Order";
                    PurchReportTypeOption::"Blanket Purchase Order":
                        "Report Type" := "Report Type"::"Blanket Purchase Order";
                end;
        end;
    end;

    local procedure SetSourceType()
    begin
        case Type of
            Type::Sales:
                case SalesSourceTypeOption of
                    SalesSourceTypeOption::Default:
                        "Source Type" := "Source Type"::Default;
                    SalesSourceTypeOption::"Bill-to Customer":
                        "Source Type" := "Source Type"::"Bill-to Customer";
                    SalesSourceTypeOption::"Sell-to Customer":
                        "Source Type" := "Source Type"::"Sell-to Customer";
                end;
            Type::Purchase:
                case PurchSourceTypeOption of
                    PurchSourceTypeOption::Default:
                        "Source Type" := "Source Type"::Default;
                    PurchSourceTypeOption::"Buy-from Vendor":
                        "Source Type" := "Source Type"::"Buy-from Vendor";
                    PurchSourceTypeOption::"Pay-to Vendor":
                        "Source Type" := "Source Type"::"Pay-to Vendor";
                end;
        end;
    end;

    local procedure SetReportVar()
    begin
        case "Report Type" of
            "Report Type"::General:
                begin
                    SalesReportTypeOption := SalesReportTypeOption::General;
                    PurchReportTypeOption := PurchReportTypeOption::General;
                end;
            "Report Type"::"Sales Quote":
                SalesReportTypeOption := SalesReportTypeOption::"Sales Quote";
            "Report Type"::"Sales Order":
                SalesReportTypeOption := SalesReportTypeOption::"Sales Order";
            "Report Type"::"Sales Pro Forma Inv":
                SalesReportTypeOption := SalesReportTypeOption::"Sales Pro Forma Inv";
            "Report Type"::"Blanket Sales Order":
                SalesReportTypeOption := SalesReportTypeOption::"Blanket Sales Order";
            "Report Type"::"Purchase Quote":
                PurchReportTypeOption := PurchReportTypeOption::"Purchase Quote";
            "Report Type"::"Purchase Order":
                PurchReportTypeOption := PurchReportTypeOption::"Purchase Order";
            "Report Type"::"Blanket Purchase Order":
                PurchReportTypeOption := PurchReportTypeOption::"Blanket Purchase Order";
        end;
    end;

    local procedure SetSourceVar()
    begin
        case "Source Type" of
            "Source Type"::Default:
                begin
                    SalesSourceTypeOption := SalesSourceTypeOption::Default;
                    PurchSourceTypeOption := PurchSourceTypeOption::Default;
                end;
            "Source Type"::"Bill-to Customer":
                SalesSourceTypeOption := SalesSourceTypeOption::"Bill-to Customer";
            "Source Type"::"Sell-to Customer":
                SalesSourceTypeOption := SalesSourceTypeOption::"Sell-to Customer";
            "Source Type"::"Buy-from Vendor":
                PurchSourceTypeOption := PurchSourceTypeOption::"Buy-from Vendor";
            "Source Type"::"Pay-to Vendor":
                PurchSourceTypeOption := PurchSourceTypeOption::"Pay-to Vendor";
        end;
    end;
}

