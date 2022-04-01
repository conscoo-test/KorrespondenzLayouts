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
                end;

                trigger OnAfterSave()
                begin
                    saved := true;
                    CurrPage.Close();
                end;

                trigger OnSave(ContentData: Text)
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
                    ExtendedTextList: Page "Extended Text List";
                    content: Text;
                    seperatorLbl: Label '%1<p>###### %2 ######</p>%3', Locked = true;
                begin
                    ExtTxtHdr.SetRange("lbt Textchoice", ExtTxtHdr."lbt Textchoice"::Blob);
                    ExtendedTextList.SetTableView(ExtTxtHdr);
                    ExtendedTextList.LookupMode(true);
                    if ExtendedTextList.RunModal() = Action::LookupOK then begin
                        ExtendedTextList.SetSelectionFilter(ExtTxtHdr);
                        if ExtTxtHdr.FindSet() then
                            repeat
                                content := ExtTxtHdr.lbtclReadContentData(false);
                                data := StrSubstNo(seperatorLbl, data, ExtTxtHdr."No.", content);
                            until ExtTxtHdr.Next() = 0;
                        CurrPage.editor.SetHTMLText(data);
                    end;
                end;
            }
            action(TestPrint)
            {

                ApplicationArea = all;
                Caption = 'TestPrint';
                Promoted = true;
                InFooterBar = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = TestReport;
                trigger onAction()
                var
                    htmlreport: Report "lbt cl htmlreport";
                    EditorHelper: Codeunit "lbt cl EditorHelper";
                    content: Text;
                begin
                    content := data;

                    htmlreport.sethtmltext(EditorHelper.PrepareHtmltoprint(content));
                    htmlreport.Run();
                end;



            }
        }
    }

    var
        data: Text;
        datatext: Text;
        saved: Boolean;
        HTMLMode: Boolean;

        lookupok: Boolean;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if not lookupok then
            lookupok := CloseAction = CloseAction::LookupOK;
        if lookupok and not saved then begin
            CurrPage.editor.GetAll();
            exit(saved);
        end;
        if saved then begin
            CloseAction := CloseAction::LookupOK;
            exit(saved);
        end;
        exit(true);
    end;

    procedure SetText(ContentData: Text; isHTML: Boolean)
    begin
        data := ContentData;
        HTMLMode := isHTML;
    end;

    procedure GetText() Result: Text
    begin
        Result := data;
    end;

    procedure GetTextText() Result: Text
    begin
        Result := datatext;
    end;

    procedure IfLookupOk() Result: Boolean
    begin
        Result := lookupok;
    end;
}