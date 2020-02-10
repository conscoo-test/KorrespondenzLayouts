pageextension 5272720 "lbt Company Information" extends "Company Information"
{
    // version NAVW111.00.00.19846,NAVDACH11.00.00.19846,NAVDE11.00.00.19846,LBCOR1.00

    layout
    {
        addafter("Industrial Classification")
        {
            field("lbt District Court"; "lbt District Court")
            {
                ToolTip = 'Enter the district court here', comment = 'DEU="Tragen Sie hier das Amtsgericht ein"';
                ApplicationArea = All;
            }
            field("lbt Trade Register Name"; "lbt Trade Register Name")
            {
                ToolTip = 'Enter your trade register name.', comment = 'DEU="Tragen Sie ihren Handelsregisternamen ein"';
                ApplicationArea = All;
            }
            field("lbt Commercial Register No."; "lbt Commercial Register No.")
            {
                ToolTip = 'Enter your commercial register number', comment = 'DEU="Tragen Sie ihre Handelsregisternr. ein"';
                ApplicationArea = All;
            }
            field("lbt CEO1"; "lbt CEO1")
            {
                ToolTip = 'Enter the Name of CEO', comment = 'DEU="Name des Geschäftsführer"';
                ApplicationArea = All;
            }
            field("lbt CEO2"; "lbt CEO2")
            {
                ToolTip = 'Enter the Name of 2. CEO', comment = 'DEU="Name des 2. Geschäftsführer"';
                ApplicationArea = All;
            }
            field("lbt CEO3"; "lbt CEO3")
            {
                ToolTip = 'Enter the Name of 3. CEO', comment = 'DEU="Name des 3. Geschäftsführer"';
                ApplicationArea = All;
            }
        }
        addafter(BankAccountPostingGroup)
        {
            field("lbt Bank Name 2"; "lbt Bank Name 2")
            {
                ToolTip = 'Please enter the Name of your 2. bank  here', comment = 'DEU="Bitte geben Sie hier den Namen ihrer 2. Bank ein"';
                ApplicationArea = All;
            }
            field("lbt Bank Branch No. 2"; "lbt Bank Branch No. 2")
            {
                ToolTip = 'Please enter the 2. bank code here', comment = 'DEU="Bitte geben Sie hier die 2. Bankleitzahl ein"';
                ApplicationArea = All;
            }
            field("lbt Bank Account No. 2"; "lbt Bank Account No. 2")
            {
                ToolTip = 'Please enter your 2. bank account number here', comment = 'DEU="Bitte geben Sie hier ihre 2. Bankkontonr. ein"';
                ApplicationArea = All;
            }
            field("lbt IBAN 2"; "lbt IBAN 2")
            {
                ToolTip = 'Please enter the 2. IBAN here', comment = 'DEU="Bitte geben Sie hier die 2. IBAN ein"';
                ApplicationArea = All;
            }
            field("lbt SWIFT Code 2"; "lbt SWIFT Code 2")
            {
                ToolTip = 'Please enter the 2. SWIFT code here', comment = 'DEU="Bitte geben Sie hier die 2. SWIFT Code ein"';
                ApplicationArea = All;
            }
            field("lbt Bank Name 3"; "lbt Bank Name 3")
            {
                ToolTip = 'Please enter the Name of your 3. bank  here', comment = 'DEU="Bitte geben Sie hier den Namen ihrer 3. Bank ein"';
                ApplicationArea = All;
            }
            field("lbt Bank Branch No. 3"; "lbt Bank Branch No. 3")
            {
                ToolTip = 'Please enter the 3. bank code here', comment = 'DEU="Bitte geben Sie hier die 3. Bankleitzahl ein"';
                ApplicationArea = All;
            }
            field("lbt Bank Account No. 3"; "lbt Bank Account No. 3")
            {
                ToolTip = 'Please enter your 3. bank account number here', comment = 'DEU="Bitte geben Sie hier ihre 3. Bankkontonr. ein"';
                ApplicationArea = All;
            }
            field("lbt IBAN 3"; "lbt IBAN 3")
            {
                ToolTip = 'Please enter the 3. IBAN here', comment = 'DEU="Bitte geben Sie hier die 3. IBAN ein"';
                ApplicationArea = All;
            }
            field("lbt SWIFT Code 3"; "lbt SWIFT Code 3")
            {
                ToolTip = 'Please enter the 3. SWIFT code here', comment = 'DEU="Bitte geben Sie hier die 3. SWIFT Code ein"';
                ApplicationArea = All;
            }
        }
    }
}

