function varargout = Rumah_Jaksel(varargin)
% RUMAH_JAKSEL MATLAB code for Rumah_Jaksel.fig
%      RUMAH_JAKSEL, by itself, creates a new RUMAH_JAKSEL or raises the existing
%      singleton*.
%
%      H = RUMAH_JAKSEL returns the handle to a new RUMAH_JAKSEL or the handle to
%      the existing singleton*.
%
%      RUMAH_JAKSEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUMAH_JAKSEL.M with the given input arguments.
%
%      RUMAH_JAKSEL('Property','Value',...) creates a new RUMAH_JAKSEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Rumah_Jaksel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Rumah_Jaksel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Rumah_Jaksel

% Last Modified by GUIDE v2.5 26-Jun-2021 09:12:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Rumah_Jaksel_OpeningFcn, ...
                   'gui_OutputFcn',  @Rumah_Jaksel_OutputFcn, ...
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


% --- Executes just before Rumah_Jaksel is made visible.
function Rumah_Jaksel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Rumah_Jaksel (see VARARGIN)

% Choose default command line output for Rumah_Jaksel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Rumah_Jaksel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Rumah_Jaksel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Proses_Button.
function Proses_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Proses_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%membaca data dari file "DATA RUMAH.xlsx"
opts = detectImportOptions('DATA RUMAH.xlsx');
%membatasi pembacaan dari kolom 3 sampai 8
opts.SelectedVariableNames = ([3:8]);
x = readmatrix('DATA RUMAH.xlsx', opts); %nilai data x 
k=[0,1,1,1,1,1]; %nilai atribut, 0 = cost/biaya, dan 1 = benefit/keuntungan
w=[0.30,0.20,0.23,0.10,0.07,0.10]; %bobot untuk masing-masing kriteria

%tahapan 1. normalisasi matriks
[m n]=size (x); %matriks m x n dengan ukuran x(input)
R=zeros (m,n); %membuat matriks kosong R
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong

for j=1:n,
    if k(j)==1, %statement untuk kriteria k = 1 atau benefit/keuntungan
    R(:,j)=x(:,j)./max(x(:,j));
    else %statement untuk kriteria cost/biaya
    R(:,j)=min(x(:,j))./x(:,j);
    end;
end;

%tahapan kedua, proses perangkingan
for i=1:m,
    V(i)= sum(w.*R(i,:)); %mencari nilai V
end;

[rank numb] = sort(V,'descend'); %mengurutkan nilai V yang paling di rekomendasikan

global r
for a=1:20,
    %merangking nilai untuk mendapatkan 20 besar
    Rank = rank(a); 
    %menyimpan nomor rumah untuk ditampilkan kembali
    nomor = numb(a); 
    r.End = [r.End; [a Rank nomor]];
    %menampilkan hasil ke GUI
    set(handles.Tabel_Hasil, 'Data', r.End); 
end;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%mengambil data
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = ([1 3:8]);
data = readmatrix('DATA RUMAH.xlsx', opts);
set(handles.Tabel_Rumah, 'data', data); %menampilkan data ke table GUI
