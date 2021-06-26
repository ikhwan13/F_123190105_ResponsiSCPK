function varargout = SPK_SAW(varargin)
% SPK_SAW MATLAB code for SPK_SAW.fig
%      SPK_SAW, by itself, creates a new SPK_SAW or raises the existing
%      singleton*.
%
%      H = SPK_SAW returns the handle to a new SPK_SAW or the handle to
%      the existing singleton*.
%
%      SPK_SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPK_SAW.M with the given input arguments.
%
%      SPK_SAW('Property','Value',...) creates a new SPK_SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SPK_SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SPK_SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SPK_SAW

% Last Modified by GUIDE v2.5 26-Jun-2021 07:45:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SPK_SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @SPK_SAW_OutputFcn, ...
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


% --- Executes just before SPK_SAW is made visible.
function SPK_SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SPK_SAW (see VARARGIN)

%menampilkan isi tabel ketika program dijalankan tanpa mengklik tombol
table = xlsread('DATA RUMAH.xlsx'); %membaca data excel
table =[table(:,1) table(:,3) table(:,4) table(:,5) table(:,6) table(:,7) table(:,8)]; %mengambil data dari kolom A,C,D,E,F,G,H
set(handles.tabel,'Data',table); %menampilkan data ke dalam tabel di GUI

% Choose default command line output for SPK_SAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SPK_SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SPK_SAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = readtable('DATA RUMAH.xlsx'); %membaca data tabel
rumah = data(:,2); %mengambil data kolom B(nomor urut data)
data =[data(:,3) data(:,4) data(:,5) data(:,6) data(:,7) data(:,8)]; %mengambil data tabel yang akan dihitung vektornya
data = table2array(data); %mengubah data tabel menjadi data array/matriks
rumah = table2array(rumah); %mengubah data tabel menjadi data array/matriks

k=[0,1,1,1,1,1];%nilai atribut, dimana 0= atribut biaya &1= atribut keuntungan
w=[0.30,0.20,0.23,0.10,0.07,0.10];% bobot untuk masing-masing kriteria


%tahapan 1. normalisasi matriks
[m n]=size (data); %matriks m x n dengan ukuran sebanyak variabel x (input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong

for j=1:n,
 if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
  R(:,j)=data(:,j)./max(data(:,j));
 else
  R(:,j)=min(data(:,j))./data(:,j);
 end;
end;

%tahapan kedua, proses perangkingan
for i=1:m,
 V(i)= sum(w.*R(i,:))
end;


[vektorV,index] = maxk(V,20); %membuat tabel perangkingan
rumah = rumah(index); %mengurutkan nama rumah
vektorV = transpose(num2cell(vektorV)); %melakukan pengubahan dari data horizontal ke data vertikal
%dan merubah array ke bentuk tabel
set(handles.tabel2,'Data',[rumah vektorV]); %menampilkan tabel perangkingan
