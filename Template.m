function varargout = Template(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Template_OpeningFcn, ...
    'gui_OutputFcn',  @Template_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Template is made visible.
function Template_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Template (see VARARGIN)

% Choose default command line output for Template
handles.output = hObject;

handles.FS = 44100;
handles.BN = 16;

handles.CPatch = 1;
handles.Patches = zeros(5, 441000);
handles.PatchesLen = zeros(5,1);

%Will record mono audio signal
handles.recorder = audiorecorder(handles.FS, handles.BN, 1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Template wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Template_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in C.
function C_Callback(hObject, eventdata, handles)


% --- Executes on button press in D.
function D_Callback(hObject, eventdata, handles)


% --- Executes on button press in E.
function E_Callback(hObject, eventdata, handles)


% --- Executes on button press in F.
function F_Callback(hObject, eventdata, handles)


% --- Executes on button press in G.
function G_Callback(hObject, eventdata, handles)


% --- Executes on button press in A.
function A_Callback(hObject, eventdata, handles)


% --- Executes on button press in B.
function B_Callback(hObject, eventdata, handles)


% --- Executes on button press in Cs.
function Cs_Callback(hObject, eventdata, handles)


% --- Executes on button press in Ds.
function Ds_Callback(hObject, eventdata, handles)


% --- Executes on button press in Fs.
function Fs_Callback(hObject, eventdata, handles)


% --- Executes on button press in Gs.
function Gs_Callback(hObject, eventdata, handles)


% --- Executes on button press in As.
function As_Callback(hObject, eventdata, handles)


% --- Executes on button press in Record.
function Record_Callback(hObject, eventdata, handles)
handles.recorder = audiorecorder(handles.FS, handles.BN, 1);
record(handles.recorder);
guidata(hObject, handles);


function Stop_Callback(hObject, eventdata, handles)
stop(handles.recorder);
p = handles.Patches(handles.CPatch,:);
data = getaudiodata(handles.recorder);
handles.Patches(handles.CPatch,1:length(data)) = p(1:length(data)) + data';
handles.PatchesLen(handles.CPatch) = length(data);
guidata(hObject, handles);


% --- Executes on button press in Patch1.
function Patch1_Callback(hObject, eventdata, handles)
handles.CPatch = 1;
guidata(hObject, handles);

% --- Executes on button press in Patch2.
function Patch2_Callback(hObject, eventdata, handles)
handles.CPatch = 2;
guidata(hObject, handles);

% --- Executes on button press in Patch3.
function Patch3_Callback(hObject, eventdata, handles)
handles.CPatch = 3;
guidata(hObject, handles);

% --- Executes on button press in Patch4.
function Patch4_Callback(hObject, eventdata, handles)
handles.CPatch = 4;
guidata(hObject, handles);

% --- Executes on button press in Patch5.
function Patch5_Callback(hObject, eventdata, handles)
handles.CPatch = 5;
guidata(hObject, handles);


% --- Executes on button press in Play.
function Play_Callback(hObject, eventdata, handles)
data = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
soundsc(data, handles.FS);
