var InputArea
var Editor

function Init(readOnly,toolbaroff) {
    var div = document.getElementById("controlAddIn");
    //div.innerHTML = "";
    InputArea = document.createElement("div");//textarea
    InputArea.id = "editor";
    InputArea.name = "editor";
    div.appendChild(InputArea);
    //Editor = new Quill('#editor', {
    //    theme: 'snow'
    //});
    if (toolbaroff){
        var toolbarOptions=[];

    }
    else 
    {
    var toolbarOptions = [
        [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
        ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
        ['blockquote', 'code-block'],
      
        [{ 'header': 1 }, { 'header': 2 }],               // custom button values
        [{ 'list': 'ordered'}, { 'list': 'bullet' }],
        [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
        [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
        //[{ 'direction': 'rtl' }],                         // text direction
        [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
        [{ 'color': [] }, { 'background': [] }]          // dropdown with defaults from theme
//        [{ 'font': [] }],
//        [{ 'align': [] }],
//        ['clean']                                         // remove formatting button
    ];
}


    
        Editor = new Quill('#editor', {
            modules: {
              // Equivalent to { toolbar: { container: '#toolbar' }}
              toolbar: toolbarOptions
            },
            theme:'snow', 
            readOnly
          });
    
      
    Editor.setText('');
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("OnAfterInit",[]);
}
function SetHTMLText(Data){
    Editor.root.innerHTML = Data;
}

function SetText(Data){
    Editor.root.innerText = Data;
    //Editor.setText = Data;
}

function GetAll(){
    //Data = Editor.root.innerText;
    var Data;
    var DataText;
    Data = Editor.root.innerHTML;
    DataText = Editor.getText();
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("OnSave",[Data]);
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("OnSaveText",[DataText]);
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("OnAfterSave");
    
}


function readOnly(ReadOnly){
    Editor.readOnly = ReadOnly;

}
