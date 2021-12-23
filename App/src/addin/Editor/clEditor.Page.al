page 50731 "lbt cl Editor"

{
    caption = 'Editor';
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {

            usercontrol(editor; "lbt cl QuillEditor")
            {
                ApplicationArea = all;
                trigger ControlReady()
                begin
                    CurrPage.editor.Init(false, false);
                    if HTMLMode then
                        CurrPage.editor.SetHTMLText(data)
                    else
                        CurrPage.editor.SetText(data);
                    //CurrPage.editor2.ReadOnly(true);
                end;

                trigger OnAfterSave()
                begin
                    saved := true;
                    CurrPage.Close();
                end;

                trigger OnSave(ContentData: text)
                begin
                    data := ContentData;
                end;

                trigger OnSaveText(ContentData: Text)
                begin
                    datatext := ContentData;
                end;
            }

        }
    }
    actions
    {
        area(Navigation)
        {
            // action(Save)
            // {
            //     ApplicationArea = all;
            //     caption = 'Save';
            //     trigger OnAction()

            //     begin
            //         GetContentText();
            //     end;

            // }
            action(InsertFrom)
            {

                ApplicationArea = all;
                caption = 'Insert From';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Insert;
                trigger onAction()
                var
                    ExtTxtHdr: Record "Extended Text Header";
                    content: text;
                    seperatorLbl: label '%1<p>###### %2 ######</p>%3', Locked = true;
                begin
                    ExtTxtHdr.setrange("lbt Textchoice", ExtTxtHdr."lbt Textchoice"::Blob);
                    if page.RunModal(0, ExtTxtHdr) = action::LookupOK then begin
                        content := ExtTxtHdr.lbtclReadContentData(false);
                        data := StrSubstNo(seperatorLbl, data, ExtTxtHdr."No.", content);
                        CurrPage.editor.SetHTMLText(data);
                    end;
                end;
            }
            action(TestPrint)
            {

                ApplicationArea = all;
                caption = 'TestPrint';
                Promoted = true;
                InFooterBar = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = TestReport;
                trigger onAction()
                var
                    htmlreport: Report "lbt cl htmlreport";
                    content: text;
                    EditorHelper: Codeunit "lbt cl EditorHelper";
                begin
                    //CurrPage.editor.GetText(content);
                    content := data;

                    htmlreport.sethtmltext(editorhelper.PrepareHtmltoprint(content));
                    htmlreport.run();
                end;



            }
            // action("lbt load")
            // {
            //     ApplicationArea = all;
            //     trigger OnAction()

            //     begin
            //         SetHTMLText('<p>Some initial <strong>bold</strong> text</p>');
            //         //CurrPage.Editor.Load('This is a <strong>BOLD</strong> statement');
            //     end;

            //}
        }
    }

    var
        data: text;
        datatext: text;
        saved: Boolean;
        HTMLMode: Boolean;

        lookupok: Boolean;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if not lookupok then
            lookupok := CloseAction = CloseAction::LookupOK;
        if lookupok and not saved then begin
            //data := GetContentText();
            CurrPage.editor.GetAll();
            exit(saved);
        end;
        if saved then begin
            CloseAction := CloseAction::LookupOK;
            exit(saved);
        end;
        exit(true);
    end;

    local procedure SetContentText(P_Data: text)
    begin
        data := P_Data;
        if HTMLMode then
            CurrPage.editor.SetHTMLText(data)
        else
            CurrPage.editor.SetText(data);

        //CurrPage.Editor.Load(data);
        //CurrPage.Editor.SetReadOnly(true);
    end;



    procedure SetText(ContentData: text; isHTML: Boolean)
    begin
        data := ContentData;
        HTMLMode := isHTML;
    end;

    procedure GetText() Result: text
    begin
        result := data;
    end;

    procedure GetTextText() Result: text
    begin
        result := dataText;
    end;

    procedure IfLookupOk() Result: Boolean
    begin
        result := lookupok;
    end;
}