page 5272727 "lbt Source Setup"
{
    Caption = 'lbt Source Setup';
    PageType = List;
    SourceTable = "lbt Source Setup";
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
        Rec.FILTERGROUP := 3;
        case Rec.GETFILTER(Type) of
            FORMAT(Rec.Type::Sales):
                begin
                    SalesVisible := true;
                    if Rec.IsEmpty() then begin
                        Rec.Type := Rec.Type::Sales;
                        Rec."Report Type" := Rec."Report Type"::General;
                        Rec."Source Type" := Rec."Source Type"::Default;
                        Rec.Insert();
                    end;
                end;
            FORMAT(Rec.Type::Purchase):
                begin
                    PurchVisible := true;
                    if Rec.IsEmpty() then begin
                        Rec.Type := Rec.Type::Purchase;
                        Rec."Report Type" := Rec."Report Type"::General;
                        Rec."Source Type" := Rec."Source Type"::Default;
                        Rec.Insert();
                    end;
                end;
        end;
        Rec.FILTERGROUP := 0;
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
        case Rec.Type of
            Rec.Type::Sales:
                case SalesReportTypeOption of
                    SalesReportTypeOption::"Sales Quote":
                        Rec."Report Type" := Rec."Report Type"::"Sales Quote";
                    SalesReportTypeOption::"Sales Order":
                        Rec."Report Type" := Rec."Report Type"::"Sales Order";
                    SalesReportTypeOption::"Sales Pro Forma Inv":
                        Rec."Report Type" := Rec."Report Type"::"Sales Pro Forma Inv";
                    SalesReportTypeOption::"Blanket Sales Order":
                        Rec."Report Type" := Rec."Report Type"::"Blanket Sales Order";
                end;
            Rec.Type::Purchase:
                case PurchReportTypeOption of
                    PurchReportTypeOption::"Purchase Quote":
                        Rec."Report Type" := Rec."Report Type"::"Purchase Quote";
                    PurchReportTypeOption::"Purchase Order":
                        Rec."Report Type" := Rec."Report Type"::"Purchase Order";
                    PurchReportTypeOption::"Blanket Purchase Order":
                        Rec."Report Type" := Rec."Report Type"::"Blanket Purchase Order";
                end;
        end;
    end;

    local procedure SetSourceType()
    begin
        case Rec.Type of
            Rec.Type::Sales:
                case SalesSourceTypeOption of
                    SalesSourceTypeOption::Default:
                        Rec."Source Type" := Rec."Source Type"::Default;
                    SalesSourceTypeOption::"Bill-to Customer":
                        Rec."Source Type" := Rec."Source Type"::"Bill-to Customer";
                    SalesSourceTypeOption::"Sell-to Customer":
                        Rec."Source Type" := Rec."Source Type"::"Sell-to Customer";
                end;
            Rec.Type::Purchase:
                case PurchSourceTypeOption of
                    PurchSourceTypeOption::Default:
                        Rec."Source Type" := Rec."Source Type"::Default;
                    PurchSourceTypeOption::"Buy-from Vendor":
                        Rec."Source Type" := Rec."Source Type"::"Buy-from Vendor";
                    PurchSourceTypeOption::"Pay-to Vendor":
                        Rec."Source Type" := Rec."Source Type"::"Pay-to Vendor";
                end;
        end;
    end;

    local procedure SetReportVar()
    begin
        case Rec."Report Type" of
            Rec."Report Type"::General:
                begin
                    SalesReportTypeOption := SalesReportTypeOption::General;
                    PurchReportTypeOption := PurchReportTypeOption::General;
                end;
            Rec."Report Type"::"Sales Quote":
                SalesReportTypeOption := SalesReportTypeOption::"Sales Quote";
            Rec."Report Type"::"Sales Order":
                SalesReportTypeOption := SalesReportTypeOption::"Sales Order";
            Rec."Report Type"::"Sales Pro Forma Inv":
                SalesReportTypeOption := SalesReportTypeOption::"Sales Pro Forma Inv";
            Rec."Report Type"::"Blanket Sales Order":
                SalesReportTypeOption := SalesReportTypeOption::"Blanket Sales Order";
            Rec."Report Type"::"Purchase Quote":
                PurchReportTypeOption := PurchReportTypeOption::"Purchase Quote";
            Rec."Report Type"::"Purchase Order":
                PurchReportTypeOption := PurchReportTypeOption::"Purchase Order";
            Rec."Report Type"::"Blanket Purchase Order":
                PurchReportTypeOption := PurchReportTypeOption::"Blanket Purchase Order";
        end;
    end;

    local procedure SetSourceVar()
    begin
        case Rec."Source Type" of
            Rec."Source Type"::Default:
                begin
                    SalesSourceTypeOption := SalesSourceTypeOption::Default;
                    PurchSourceTypeOption := PurchSourceTypeOption::Default;
                end;
            Rec."Source Type"::"Bill-to Customer":
                SalesSourceTypeOption := SalesSourceTypeOption::"Bill-to Customer";
            Rec."Source Type"::"Sell-to Customer":
                SalesSourceTypeOption := SalesSourceTypeOption::"Sell-to Customer";
            Rec."Source Type"::"Buy-from Vendor":
                PurchSourceTypeOption := PurchSourceTypeOption::"Buy-from Vendor";
            Rec."Source Type"::"Pay-to Vendor":
                PurchSourceTypeOption := PurchSourceTypeOption::"Pay-to Vendor";
        end;
    end;
}

