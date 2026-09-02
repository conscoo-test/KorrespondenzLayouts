reportextension 5266412 "lbt ForNAV Purchase Template" extends "ForNAV Purchase Template"
{
    dataset
    {
        add(Header)
        {
            column(lbtHeaderText; HeaderText)
            {
                IncludeCaption = false;
            }
            column(lbtFooterText; FooterText)
            {
                IncludeCaption = false;
            }
        }
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            begin
                HeaderText := Header.lbtGetPrintData("lbt Position"::EditorHeader);
                FooterText := Header.lbtGetPrintData("lbt Position"::EditorFooter);
            end;
        }
        add(Line)
        {
            column(lbtLineText; LineText)
            {
                IncludeCaption = false;
            }
            column(lbtBalance; Line."lbt Balance")
            {
                IncludeCaption = false;
            }
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                LineText := Line.lbtGetPrintData("lbt Position"::EditorLine);
                Line.CalcFields("lbt Balance");
            end;
        }
    }

    var
        HeaderText: Text;
        FooterText: Text;
        LineText: Text;
}