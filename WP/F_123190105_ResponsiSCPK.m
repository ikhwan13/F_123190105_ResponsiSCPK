function varargout = F_123190105_ResponsiSCPK(varargin)
% F_123190105_RESPONSISCPK MATLAB code for F_123190105_ResponsiSCPK.fig
%      F_123190105_RESPONSISCPK, by itself, creates a new F_123190105_RESPONSISCPK or raises the existing
%      singleton*.
%
%      H = F_123190105_RESPONSISCPK returns the handle to a new F_123190105_RESPONSISCPK or the handle to
%      the existing singleton*.
%
%      F_123190105_RESPONSISCPK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in F_123190105_RESPONSISCPK.M with the given input arguments.
%
%      F_123190105_RESPONSISCPK('Property','Value',...) creates a new F_123190105_RESPONSISCPK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before F_123190105_ResponsiSCPK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to F_123190105_ResponsiSCPK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help F_123190105_ResponsiSCPK

% Last Modified by GUIDE v2.5 25-Jun-2021 17:12:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @F_123190105_ResponsiSCPK_OpeningFcn, ...
                   'gui_OutputFcn',  @F_123190105_ResponsiSCPK_OutputFcn, ...
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


% --- Executes just before F_123190105_ResponsiSCPK is made visible.
function F_123190105_ResponsiSCPK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to F_123190105_ResponsiSCPK (see VARARGIN)

% Choose default command line output for F_123190105_ResponsiSCPK
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes F_123190105_ResponsiSCPK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = F_123190105_ResponsiSCPK_OutputFcn(hObject, eventdata, handles) 
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
table = xlsread('Real estate valuation data set.xlsx'); %membaca data excel
table =[table(:,3) table(:,4) table(:,5) table(:,8)]; %mengambil data dari kolom C,D,E,H
table = table(1:50,:); %mengambil 50 data pertama
set(handles.tabel,'Data',table); %menampilkan data ke dalam tabel di GUI

data = readtable('Real estate valuation data set.xlsx'); %membaca data tabel
datanama = data(:,1); %mengambil data kolom A(nomor urut data)
data =[data(:,3) data(:,4) data(:,5) data(:,8)]; %mengambil data tabel yang akan dihitung vektornya
data = data(1:50,:); %mengambil 50 data pertama
data = table2array(data); %mengubah data tabel menjadi data array/matriks
datanama = datanama(1:50,:); %mengambil 50 data pertama
datanama = table2array(datanama); %mengubah data tabel menjadi data array/matriks

k = [0 0 0 1]; %0 berarti merupakan biaya, 1 berarti merupakan keuntungan
w = [3 5 4 1]; 
%tahapan pertama, perbaikan bobot

[m,n]=size(data); %inisialisasi ukuran data
w = w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n
    if k(j)==0, w(j)=-1*w(j);
    end
end
for i=1:m
    S(i)=prod(data(i,:).^w);
end

%tahapan ketiga, proses perangkingan
V = S/sum(S);

[vektorV,datanama] = maxk(V,50); %membuat tabel perangkingan
datanama = transpose(num2cell(datanama)); %melakukan pengubahan dari data horizontal ke data vertikal 
%dan merubah array ke bentuk tabel
vektorV = transpose(num2cell(vektorV)); %melakukan pengubahan dari data horizontal ke data vertikal
%dan merubah array ke bentuk tabel
hasil = [datanama vektorV]; %menggabungkan 2 kolom menjadi 1 tabel
set(handles.tabel2,'Data',hasil); %menampilkan tabel perangkingan
