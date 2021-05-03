function varargout = monte_carlo_s(varargin)
% MONTE_CARLO_S MATLAB code for monte_carlo_s.fig
%      MONTE_CARLO_S, by itself, creates a new MONTE_CARLO_S or raises the existing
%      singleton*.
%
%      H = MONTE_CARLO_S returns the handle to a new MONTE_CARLO_S or the handle to
%      the existing singleton*.
%
%      MONTE_CARLO_S('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONTE_CARLO_S.M with the given input arguments.
%
%      MONTE_CARLO_S('Property','Value',...) creates a new MONTE_CARLO_S or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before monte_carlo_s_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to monte_carlo_s_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help monte_carlo_s

% Last Modified by GUIDE v2.5 11-Oct-2019 03:20:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @monte_carlo_s_OpeningFcn, ...
    'gui_OutputFcn',  @monte_carlo_s_OutputFcn, ...
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


% --- Executes just before monte_carlo_s is made visible.
function monte_carlo_s_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to monte_carlo_s (see VARARGIN)
Ax = findall(0,'type','axes1');
d = imread('background.png');
image(d);
set(gca,'xtick',[]);
set(gca,'ytick',[])
global record;
record=0;
% Choose default command line output for monte_carlo_s
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes monte_carlo_s wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = monte_carlo_s_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dry = randi([0 50],1,5) % 건조기 5개의 시간 random number 생성
wash=randi([0 50],1,7) % 세탁기 7개의 시간 random number 생성
my_wash=50; % 내 세탁기
global time;
time=0;
while 1
    pause(0.01);
    time=time+1;
    set(handles.text3,'String', sprintf('%0.f', dry(1))); % 건조기
    set(handles.text4,'String', sprintf('%0.f', dry(2)));
    set(handles.text5,'String', sprintf('%0.f', dry(3)));
    set(handles.text6,'String', sprintf('%0.f', dry(4)));
    set(handles.text7,'String', sprintf('%0.f', dry(5)));
    
    set(handles.text14,'String', sprintf('%0.f', my_wash)); % 내 세탁기
    
    set(handles.text8,'String', sprintf('%0.f', wash(1))); % 세탁기
    set(handles.text9,'String', sprintf('%0.f', wash(2)));
    set(handles.text10,'String', sprintf('%0.f', wash(3)));
    set(handles.text11,'String', sprintf('%0.f', wash(4)));
    set(handles.text12,'String', sprintf('%0.f', wash(5)));
    set(handles.text13,'String', sprintf('%0.f', wash(6)));
    set(handles.text15,'String', sprintf('%0.f', wash(7)));
    
    if my_wash>0
        my_wash=my_wash-1; % 내 세탁기 1분씩 줄어듬
    end
    if find(wash>0)>0
        wash(find(wash>0))=wash(find(wash>0))-1; % 끝나지 않은 세탁기들 1분씩 줄어듬
    end
    if find(dry>0)>0
        dry(find(dry>0))=dry(find(dry>0))-1; % 끝나지 않은 건조기들 1분씩 줄어듬
    end
    
    % 끝난 세탁기가 건조기를 사용할 수 있을 경우
    if length(find(dry==0))>=1 & find(wash==0)>0 % 만약 동시에 끝난 건조기가 있다면 작은거 선택
            dry(min(find(dry==0)))=dry(min(find(dry==0)))+50;
            wash(find(wash==0))=-1;
    end
    
    % 끝난 건조기가 3개를 넘을 때는 늦게 가지러옴.
    if find(dry==0)>=3
        dry(min(find(dry==0)))=dry(min(find(dry==0)))+randi([0 5]);
    end
    
    % 내 세탁기가 끝나고 사용할 수 있는 건조기가 있는 경우
    if my_wash==0 & find(dry==0)>0 & size(find(wash==-1))==[1 7] 
        msgbox(sprintf('건조기 사용까지 %d분 걸렸습니다.',time));
        break;
    end
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3,'String', sprintf('%0.f', 0)); % 건조기
    set(handles.text4,'String', sprintf('%0.f', 0));
    set(handles.text5,'String', sprintf('%0.f', 0));
    set(handles.text6,'String', sprintf('%0.f', 0));
    set(handles.text7,'String', sprintf('%0.f', 0));
    
    set(handles.text14,'String', sprintf('%0.f', 0)); % 내 세탁기
    
    set(handles.text8,'String', sprintf('%0.f', 0)); % 세탁기
    set(handles.text9,'String', sprintf('%0.f', 0));
    set(handles.text10,'String', sprintf('%0.f', 0));
    set(handles.text11,'String', sprintf('%0.f', 0));
    set(handles.text12,'String', sprintf('%0.f', 0));
    set(handles.text13,'String', sprintf('%0.f', 0));
    set(handles.text15,'String', sprintf('%0.f', 0));

    global record;
    global time;
    record=[record,time];
    msgbox(sprintf('저장되었습니다.'));
    disp(record);
