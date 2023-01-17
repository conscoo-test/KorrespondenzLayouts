page 5272731 "lbt cl Editor"

{
    Caption = 'Editor';
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            usercontrol(editor; "lbt cl QuillEditor")
            {
                ApplicationArea = All;
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
                ApplicationArea = All;
                Caption = 'Insert From';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Insert;
                trigger OnAction()
                var
                    ExtTxtHdr: Record "Extended Text Header";
                    ExtendedTextList: Page "Extended Text List";
                    seperatorLbl: Label '%1<p>###### %2 ######</p>%3', Locked = true;
                    content: Text;
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
                ApplicationArea = All;
                Caption = 'TestPrint';
                Promoted = true;
                InFooterBar = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = TestReport;
                trigger OnAction()
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
        HTMLMode: Boolean;

        lookupok: Boolean;
        saved: Boolean;
        data: Text;
        datatext: Text;

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

    procedure SetText(ContentData: Text; isHTML: Boolean)
    begin
        data := ContentData;
        HTMLMode := isHTML;
    end;
}