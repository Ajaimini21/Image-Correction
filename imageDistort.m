% Andrew Sack
% Lab LA
% 5/10/17 
% main GUI file of project

% Note: I double percent commented all functions that I manually modified
% code for to make it easier to find. Most custom code is in separate
% function filed in the guiSubfunctions folder that are called by the
% functions in this file

%% main GUI function; no modifications
function varargout = imageDistort(varargin)
% IMAGEDISTORT MATLAB code for imageDistort.fig
%      IMAGEDISTORT, by itself, creates a new IMAGEDISTORT or raises the existing
%      singleton*.
%
%      H = IMAGEDISTORT returns the handle to a new IMAGEDISTORT or the handle to
%      the existing singleton*.
%
%      IMAGEDISTORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEDISTORT.M with the given input arguments.
%
%      IMAGEDISTORT('Property','Value',...) creates a new IMAGEDISTORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imageDistort_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imageDistort_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageDistort

% Last Modified by GUIDE v2.5 06-May-2017 23:01:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageDistort_OpeningFcn, ...
                   'gui_OutputFcn',  @imageDistort_OutputFcn, ...
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
end

%% turn axis off on startup; defines global variables
% --- Executes just before imageDistort is made visible.
function imageDistort_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imageDistort (see VARARGIN)

% Choose default command line output for imageDistort
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imageDistort wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.imgWindow,'visible','off'); % turn off axis

%% define global variables
global imgSelected imgOrig imgDistort; 
global thresh M N numIter;
imgSelected = 0;

updateParam_SubFunc(handles); % read in initial parameters

end

%% select and load image from file
% --- Executes on button press in selectImg.
function selectImg_Callback(hObject, eventdata, handles)
% hObject    handle to selectImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selectImg_SubFunc(handles);
end

%% triggers distortion
% --- Executes on button press in distortGo.
function distortGo_Callback(hObject, eventdata, handles)
% hObject    handle to distortGo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
distortGo_SubFunc(handles);
end

%% controls distortion percent slider; sets value of distort percent input text box 
% --- Executes on slider movement.
function sliderDistort_Callback(hObject, eventdata, handles)
% hObject    handle to sliderDistort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.distortPercent,'string', get(hObject,'Value'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
end

%% reads in all image correction parameters
% --- Executes on button press in updateParam.
function updateParam_Callback(hObject, eventdata, handles)
% hObject    handle to updateParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
updateParam_SubFunc(handles);
end

%% run selective correction
% --- Executes on button press in selectCorr.
function selectCorr_Callback(hObject, eventdata, handles)
% hObject    handle to selectCorr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selectCorr_SubFunc(handles);

end
 
%% run general correction (correction on all points)
% --- Executes on button press in genCorr.
function genCorr_Callback(hObject, eventdata, handles)
% hObject    handle to genCorr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

genCorr_SubFunc(handles);

end

%% save all versions of image into 1 figure
% --- Executes on button press in saveCombo.
function saveCombo_Callback(hObject, eventdata, handles)
% hObject    handle to saveCombo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

saveCombo_SubFunc(handles);

end

%% saves image currently in preview window as JPG
% --- Executes on button press in saveJPG.
function saveJPG_Callback(hObject, eventdata, handles)
% hObject    handle to saveJPG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

saveJPG_SubFunc(handles);

end

%% saves image currently in preview window as figure
% --- Executes on button press in saveCurr.
function saveCurr_Callback(hObject, eventdata, handles)
% hObject    handle to saveCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

saveCurr_SubFunc(handles);

end

%% generates text file of details of correction performed
% --- Executes on button press in genTxt.
function genTxt_Callback(hObject, eventdata, handles)
% hObject    handle to genTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

genTxt_SubFunc(handles);

end





%% unedited functions

% no modifications
% --- Outputs from this function are returned to the command line.
function varargout = imageDistort_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% callback for distortPercent edit txt box; don't use
function distortPercent_Callback(hObject, eventdata, handles)
% hObject    handle to distortPercent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distortPercent as text
%        str2double(get(hObject,'String')) returns contents of distortPercent as a double
end

% don't use
% --- Executes during object creation, after setting all properties.
function distortPercent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distortPercent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

%do not use
% --- Executes during object creation, after setting all properties.
function sliderDistort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderDistort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

% do not use
function editThresh_Callback(hObject, eventdata, handles)
% hObject    handle to editThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editThresh as text
%        str2double(get(hObject,'String')) returns contents of editThresh as a double
end

% do not use
% --- Executes during object creation, after setting all properties.
function editThresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% do not use
function editM_Callback(hObject, eventdata, handles)
% hObject    handle to editM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editM as text
%        str2double(get(hObject,'String')) returns contents of editM as a double
end

%do not use
% --- Executes during object creation, after setting all properties.
function editM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% do not use
function editN_Callback(hObject, eventdata, handles)
% hObject    handle to editN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editN as text
%        str2double(get(hObject,'String')) returns contents of editN as a double
end

%do not use
% --- Executes during object creation, after setting all properties.
function editN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

%do not use
function editNumIt_Callback(hObject, eventdata, handles)
% hObject    handle to editNumIt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNumIt as text
%        str2double(get(hObject,'String')) returns contents of editNumIt as a double
end

% do not use
% --- Executes during object creation, after setting all properties.
function editNumIt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNumIt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

%% probably not necessary code
% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
end

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
end
