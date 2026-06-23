pageextension 5266400 "lbt ForNAV Reports" extends "ForNAV Reports"
{
    actions
    {
        addlast(Processing)
        {
            group(lbtconscoo)
            {
                Caption = 'conscoo', Locked = true;
                action(lbtLayoutSelection)
                {
                    ApplicationArea = All;
                    Caption = 'Init conscoo Reports';
                    Image = Process;

                    trigger OnAction()
                    var
                        InitReports: Codeunit "lbt Init Reports";
                    begin
                        InitReports.InitReports();
                    end;
                }
            }
        }
        addlast(Promoted)
        {
            group(lbtconscooPromoted)
            {
                Caption = 'conscoo', Locked = true;
                actionref(lbtLayoutSelection_Promoted; lbtLayoutSelection) { }
            }
        }
    }


}