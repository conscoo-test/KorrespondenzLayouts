reportextension 5266411 "lbt ForNAV Sales Template" extends "ForNAV Sales Template"
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
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                LineText := Line.lbtGetPrintData("lbt Position"::EditorLine);
            end;
        }
    }

    var
        HeaderText: Text;
        FooterText: Text;
        LineText: Text;
}