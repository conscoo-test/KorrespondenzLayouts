controladdin "lbt cl QuillEditor"
{
    VerticalStretch = true;
    HorizontalStretch = true;

    //MinimumWidth = 200;
    //MaximumHeight = 


    //StyleSheets = 'https://cdn.quilljs.com/1.3.6/quill.snow.css', 'obj/addin/Editor/Scripts/quillStyle.css';
    StyleSheets = 'src/addin/Editor/Scripts/quill.snow.css', 'src/addin/Editor/Scripts/quillStyle.css';

    Scripts = 'src/addin/Editor/Scripts/quill.min.js', 'src/addin/Editor//Scripts/MainQuill.js';
    //Scripts = 'https://cdn.quilljs.com/1.3.6/quill.js', 'obj/addin/Editor//Scripts/MainQuill.js';


    StartupScript = 'src/addin/Editor//Scripts/startupScript.js';
    RecreateScript = 'src/addin/Editor//Scripts/recreateScript.js';
    RefreshScript = 'src/addin/Editor//Scripts/refreshScript.js';

    event ControlReady();
    //event SaveRequested(data: Text);
    //event ContentChanged();
    event OnAfterInit();

    procedure Init(readOnly: Boolean; toolbarOff: Boolean);
    //procedure Load(data: Text);
    //procedure RequestSave();
    //procedure SetReadOnly(readonly: boolean);
    procedure SetHTMLText(data: Text);
    procedure SetText(data: Text);

    procedure GetAll();

    event OnSave(Data: text);
    event OnSaveText(Data: text);

    event OnSaveAll(Data: text; DataText: text);
    event OnAfterSave();

    procedure ReadOnly(ReadOnly: Boolean)


}