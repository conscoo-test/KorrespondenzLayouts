pageextension 5272720 "LBT Company Information" extends "Company Information"
{
    // version NAVW111.00.00.19846,NAVDACH11.00.00.19846,NAVDE11.00.00.19846,LBCOR1.00

    layout
    {
        addafter("Industrial Classification")
        {
            field("LBT District Court"; "LBT District Court")
            {
                ApplicationArea = All;
            }
            field("LBT Trade Register Name"; "LBT Trade Register Name")
            {
                ApplicationArea = All;
            }
            field("LBT Commercial Register No."; "LBT Commercial Register No.")
            {
                ApplicationArea = All;
            }
            field("LBT CEO1"; "LBT CEO1")
            {
                ApplicationArea = All;
            }
            field("LBT CEO2"; "LBT CEO2")
            {
                ApplicationArea = All;
            }
            field("LBT CEO3"; "LBT CEO3")
            {
                ApplicationArea = All;
            }
        }
        addafter(BankAccountPostingGroup)
        {
            field("LBT Bank Name 2"; "LBT Bank Name 2")
            {
                ApplicationArea = All;
            }
            field("LBT Bank Branch No. 2"; "LBT Bank Branch No. 2")
            {
                ApplicationArea = All;
            }
            field("LBT Bank Account No. 2"; "LBT Bank Account No. 2")
            {
                ApplicationArea = All;
            }
            field("LBT IBAN 2"; "LBT IBAN 2")
            {
                ApplicationArea = All;
            }
            field("LBT SWIFT Code 2"; "LBT SWIFT Code 2")
            {
                ApplicationArea = All;
            }
            field("LBT Bank Name 3"; "LBT Bank Name 3")
            {
                ApplicationArea = All;
            }
            field("LBT Bank Branch No. 3"; "LBT Bank Branch No. 3")
            {
                ApplicationArea = All;
            }
            field("LBT Bank Account No. 3"; "LBT Bank Account No. 3")
            {
                ApplicationArea = All;
            }
            field("LBT IBAN 3"; "LBT IBAN 3")
            {
                ApplicationArea = All;
            }
            field("LBT SWIFT Code 3"; "LBT SWIFT Code 3")
            {
                ApplicationArea = All;
            }
        }
    }
}

