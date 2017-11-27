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


% --- Outputs from this function are returned to the command line.
function varargout = Template_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% --- Executes on button press in C.
function C_Callback(hObject, eventdata, handles)
audio = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
audio_out = formantPreservation(audio, 1);
soundsc(audio_out, handles.FS);

% --- Executes on button press in D.
function D_Callback(hObject, eventdata, handles)
audio = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
audio_out = formantPreservation(audio, 1.2);
soundsc(audio_out, handles.FS);

% --- Executes on button press in E.
function E_Callback(hObject, eventdata, handles)
audio = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
audio_out = formantPreservation(audio, 1.4);
soundsc(audio_out, handles.FS);

% --- Executes on button press in F.
function F_Callback(hObject, eventdata, handles)
audio = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
audio_out = formantPreservation(audio, 1.6);
soundsc(audio_out, handles.FS);

% --- Executes on button press in G.
function G_Callback(hObject, eventdata, handles)
audio = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
audio_out = PitchScaling(audio, 1.8);
soundsc(audio_out, handles.FS);

% --- Executes on button press in A.
function A_Callback(hObject, eventdata, handles)
audio = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
audio_out = PitchScaling(audio, 2);
soundsc(audio_out, handles.FS);

% --- Executes on button press in B.
function B_Callback(hObject, eventdata, handles)
audio = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
audio_out = PitchScaling(audio, 2.2);
soundsc(audio_out, handles.FS);

% --- Executes on button press in Cs.
function Cs_Callback(hObject, eventdata, handles)
audio = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
audio_out = PitchScaling(audio, 1.1);
soundsc(audio_out, handles.FS);

% --- Executes on button press in Ds.
function Ds_Callback(hObject, eventdata, handles)
audio = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
audio_out = PitchScaling(audio, 1.3);
soundsc(audio_out, handles.FS);

% --- Executes on button press in Fs.
function Fs_Callback(hObject, eventdata, handles)
audio = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
audio_out = PitchScaling(audio, 1.5);
soundsc(audio_out, handles.FS);

% --- Executes on button press in Gs.
function Gs_Callback(hObject, eventdata, handles)
audio = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
audio_out = PitchScaling(audio, 1.7);
soundsc(audio_out, handles.FS);

% --- Executes on button press in As.
function As_Callback(hObject, eventdata, handles)
audio = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
audio_out = PitchScaling(audio, 1.9);
soundsc(audio_out, handles.FS);

% --- Executes on button press in Record.
function Record_Callback(hObject, eventdata, handles)
handles.recorder = audiorecorder(handles.FS, handles.BN, 1);
record(handles.recorder);
guidata(hObject, handles);


function Stop_Callback(hObject, eventdata, handles)
stop(handles.recorder);
p = handles.Patches(handles.CPatch,:);
data = getaudiodata(handles.recorder);
data = data(5000:length(data)-5000);
handles.Patches(handles.CPatch,1:length(data)) = p(1:length(data)) + data';
handles.PatchesLen(handles.CPatch) = length(data);
n = 0:length(data)-1;
plot(n, data);

xlabel('Samples');
ylabel('Normalized Magnitude');

guidata(hObject, handles);


% --- Executes on button press in Patch1.
function Patch1_Callback(hObject, eventdata, handles)
handles.CPatch = 1;
data = handles.Patches(handles.CPatch,:);
n = 0:length(data)-1;
plot(n, data);
guidata(hObject, handles);

% --- Executes on button press in Patch2.
function Patch2_Callback(hObject, eventdata, handles)
handles.CPatch = 2;
data = handles.Patches(handles.CPatch,:);
n = 0:length(data)-1;
plot(n, data);
guidata(hObject, handles);

% --- Executes on button press in Patch3.
function Patch3_Callback(hObject, eventdata, handles)
handles.CPatch = 3;
data = handles.Patches(handles.CPatch,:);
n = 0:length(data)-1;
plot(n, data);
guidata(hObject, handles);

% --- Executes on button press in Patch4.
function Patch4_Callback(hObject, eventdata, handles)
handles.CPatch = 4;
data = handles.Patches(handles.CPatch,:);
n = 0:length(data)-1;
plot(n, data);
guidata(hObject, handles);

% --- Executes on button press in Patch5.
function Patch5_Callback(hObject, eventdata, handles)
handles.CPatch = 5;
data = handles.Patches(handles.CPatch,:);
n = 0:length(data)-1;
plot(n, data);
guidata(hObject, handles);


% --- Executes on button press in Play.
function Play_Callback(hObject, eventdata, handles)
data = handles.Patches(handles.CPatch, 1:handles.PatchesLen(handles.CPatch));
soundsc(data, handles.FS);


% --- Executes on slider movement.
function Length_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function Length_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function StartPosition_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function StartPosition_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function AudioData_CreateFcn(hObject, eventdata, handles)
xlabel('Sample');
ylabel('Magnitude');
