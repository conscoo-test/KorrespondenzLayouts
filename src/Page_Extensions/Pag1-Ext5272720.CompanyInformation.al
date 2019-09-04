pageextension 5272720 "LBT Company Information" extends "Company Information"
{
    // version NAVW111.00.00.19846,NAVDACH11.00.00.19846,NAVDE11.00.00.19846,LBCOR1.00

    layout
    {
        addafter("Industrial Classification")
        {
            field("LBT District Court"; "LBT District Court")
            {
                ToolTip = 'Enter the district court here', comment = 'DEU="Tragen Sie hier das Amtsgericht ein"';
                ApplicationArea = All;
            }
            field("LBT Trade Register Name"; "LBT Trade Register Name")
            {
                ToolTip = 'Enter your trade register name.', comment = 'DEU="Tragen Sie ihren Handelsregisternamen ein"';
                ApplicationArea = All;
            }
            field("LBT Commercial Register No."; "LBT Commercial Register No.")
            {
                ToolTip = 'Enter your commercial register number', comment = 'DEU="Tragen Sie ihre Handelsregisternr. ein"';
                ApplicationArea = All;
            }
            field("LBT CEO1"; "LBT CEO1")
            {
                ToolTip = 'Enter the Name of CEO', comment = 'DEU="Name des Geschäftsführer"';
                ApplicationArea = All;
            }
            field("LBT CEO2"; "LBT CEO2")
            {
                ToolTip = 'Enter the Name of 2. CEO', comment = 'DEU="Name des 2. Geschäftsführer"';
                ApplicationArea = All;
            }
            field("LBT CEO3"; "LBT CEO3")
            {
                ToolTip = 'Enter the Name of 3. CEO', comment = 'DEU="Name des 3. Geschäftsführer"';
                ApplicationArea = All;
            }
        }
        addafter(BankAccountPostingGroup)
        {
            field("LBT Bank Name 2"; "LBT Bank Name 2")
            {
                ToolTip = 'Please enter the Name of your 2. bank  here', comment = 'DEU="Bitte geben Sie hier den Namen ihrer 2. Bank ein"';
                ApplicationArea = All;
            }
            field("LBT Bank Branch No. 2"; "LBT Bank Branch No. 2")
            {
                ToolTip = 'Please enter the 2. bank code here', comment = 'DEU="Bitte geben Sie hier die 2. Bankleitzahl ein"';
                ApplicationArea = All;
            }
            field("LBT Bank Account No. 2"; "LBT Bank Account No. 2")
            {
                ToolTip = 'Please enter your 2. bank account number here', comment = 'DEU="Bitte geben Sie hier ihre 2. Bankkontonr. ein"';
                ApplicationArea = All;
            }
            field("LBT IBAN 2"; "LBT IBAN 2")
            {
                ToolTip = 'Please enter the 2. IBAN here', comment = 'DEU="Bitte geben Sie hier die 2. IBAN ein"';
                ApplicationArea = All;
            }
            field("LBT SWIFT Code 2"; "LBT SWIFT Code 2")
            {
                ToolTip = 'Please enter the 2. SWIFT code here', comment = 'DEU="Bitte geben Sie hier die 2. SWIFT Code ein"';
                ApplicationArea = All;
            }
            field("LBT Bank Name 3"; "LBT Bank Name 3")
            {
                ToolTip = 'Please enter the Name of your 3. bank  here', comment = 'DEU="Bitte geben Sie hier den Namen ihrer 3. Bank ein"';
                ApplicationArea = All;
            }
            field("LBT Bank Branch No. 3"; "LBT Bank Branch No. 3")
            {
                ToolTip = 'Please enter the 3. bank code here', comment = 'DEU="Bitte geben Sie hier die 3. Bankleitzahl ein"';
                ApplicationArea = All;
            }
            field("LBT Bank Account No. 3"; "LBT Bank Account No. 3")
            {
                ToolTip = 'Please enter your 3. bank account number here', comment = 'DEU="Bitte geben Sie hier ihre 3. Bankkontonr. ein"';
                ApplicationArea = All;
            }
            field("LBT IBAN 3"; "LBT IBAN 3")
            {
                ToolTip = 'Please enter the 3. IBAN here', comment = 'DEU="Bitte geben Sie hier die 3. IBAN ein"';
                ApplicationArea = All;
            }
            field("LBT SWIFT Code 3"; "LBT SWIFT Code 3")
            {
                ToolTip = 'Please enter the 3. SWIFT code here', comment = 'DEU="Bitte geben Sie hier die 3. SWIFT Code ein"';
                ApplicationArea = All;
            }
        }
    }
}

