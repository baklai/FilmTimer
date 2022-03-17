unit FTMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ImgList, mmsystem, ShellApi, Math,
  ComCtrls, jpeg, TabNotBk, Vcl.Imaging.pngimage, Vcl.Menus;

{ TbklForm }
type
  TbklForm = class(TForm)
  private
  { ������ ������� ���������� }
    procedure IconTrayMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); /// ��������� ����� �� ������ � ����...
  protected
  { ������ ���������� ���������� }
    procedure CreateParams(var Params:TCreateParams); override; /// ���� ������ �����...
    procedure CreateWnd; override; /// ������ �� ��������� ������ ���������...
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer); override; /// ����������� �����...
    procedure PaintWindow(DC:HDC); override; /// ��������� ������� �����...
  public
  { ������ ����� ���������� }
    constructor Create(AOwner: TComponent); override; /// �������� �������������� � �����...
    destructor Destroy; /// �������� �������������� �� �����...
    procedure WMGetSysCommand(var Msg:TMessage); message WM_SYSCOMMAND; /// ����������� ����� � ��������� ����...
  published
  { ������ �������������� ���������� }
    IconTray: TTrayIcon; /// �������� TrayIcon...
    PMIconTray: TPopupMenu; /// ��������� PopupMenu ��� TrayIcon...
  end;

{ TbklHintWindow }
type
  TbklHintWindow = class(THintWindow)
  private
  { ������ ������� ���������� }
    FBitmap: TBitmap;
    FRegion: THandle;
    procedure FreeRegion;
  protected
  { ������ ���������� ���������� }
    procedure CreateParams (var Params: TCreateParams); override;
    procedure Paint; override;
    procedure Erase(var Message: TMessage); message WM_ERASEBKGND;
  public
  { ������ ����� ���������� }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ActivateHint(Rect: TRect; const AHint: String); Override;
  published
  { ������ �������������� ���������� }
  end;
THintWindow = class(TbklHintWindow);

{ TbklLabel }
type
  TbklLabel = class(TLabel)
    private
      FScroll : boolean;
      FTime   : integer;
    protected
      procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
      procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
      procedure SetScroll(Value:boolean);
      procedure SetTime(Value:integer);
    public
      property Scroll : boolean read FScroll write SetScroll default true;
      property Time   : integer read FTime   write SetTime   default -1;
  end;
TLabel = class(TbklLabel);

{ TbklSpeedButton }
type
  TbklSpeedButton = class(TSpeedButton)
    protected
      procedure CMMouseEnter(var Message:TMessage); message CM_MOUSEENTER;
      procedure CMMouseLeave(var Message:TMessage); message CM_MOUSELEAVE;
      procedure Paint; override;
  end;
TSpeedButton = class(TbklSpeedButton);

type
  TFFilmTimer = class(TbklForm)
    LCaption: TLabel;
    IIcon: TImage;
    GoTimer: TTimer;
    IFonVerh: TImage;
    IFonNiz: TImage;
    LCopirate: TLabel;
    IStop: TSpeedButton;
    IRun: TSpeedButton;
    IClose: TSpeedButton;
    IFixed: TSpeedButton;
    IOption: TSpeedButton;
    IMin: TSpeedButton;
    PBTime: TShape;
    LClock: TLabel;
    LClockUp: TLabel;
    Shape1: TShape;
    Shape4: TShape;
    LClockDown: TLabel;
    Label1: TLabel;
    LMinutes: TLabel;
    Shape5: TShape;
    LMinutesDown: TLabel;
    Shape2: TShape;
    LMinutesUp: TLabel;
    Label2: TLabel;
    LSeconds: TLabel;
    Shape3: TShape;
    Shape6: TShape;
    LSecondsDown: TLabel;
    LSecondsUp: TLabel;
    OpenDialog: TOpenDialog;
    GroupBox1: TGroupBox;
    CBUse: TComboBox;
    EPath: TEdit;
    CBShowTimer: TCheckBox;
    CBShowSound: TCheckBox;
    IOpen: TSpeedButton;
    CBShowTime: TCheckBox;
    GroupBox2: TGroupBox;
    RBFinishFrom: TRadioButton;
    RBFinishIn: TRadioButton;
    FIconTray: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
////////////////////////////////////////////////////////////////////////////////
    procedure GoForm(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); /// ����������� �����...
    procedure EndRun;
////////////////////////////////////////////////////////////////////////////////
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure GoTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure MinClick(Sender: TObject);
    procedure OptionClick(Sender: TObject);
    procedure FixedClick(Sender: TObject);
    procedure RunClick(Sender: TObject);
    procedure StopClick(Sender: TObject);
    procedure CBShowTimerClick(Sender: TObject);
    procedure CBUseChange(Sender: TObject);
    procedure IOpenClick(Sender: TObject);
    procedure CBShowSoundClick(Sender: TObject);
    procedure CBShowTimeClick(Sender: TObject);
  private
  { ������ ������� ���������� }
  protected
  { ������ ���������� ���������� }
  public
  { ������ ����� ���������� }
  published
  { ������ �������������� ���������� }
  end;

const
  ClientNill : integer = 148; // ������ ����� ��� ������...
  ClientFull : integer = 350; // ������ ����� ��� ���������...
  TimeUps    : integer = 60; // ���������� ������ ����� ��������...

var
  FFilmTimer: TFFilmTimer;

  ClientNillFull : boolean = false; // ������ ����� ��� ������...
  FTFormStyle    : boolean = false; // ������� ����� ��� ������ (������ ����)...

  GoTime    : boolean = false; /// ������ ����/����...
  ShowTimer : boolean = true;  // ����������� ���� ������� �� ���������...
  ShowTimes : boolean = true;  // ����������� ���� ������� �� ���������...
  ShowSound : boolean = true;  // �������� ������

  idTime     : integer = 0; // ������� ������� ��� �������� �������...
  idClock    : integer = 0; // ���������� �����...
  idMinutes  : integer = 0; // ���������� �����...
  idSeconds  : integer = 0; // ���������� ������...

  PBTimeMax  : integer = 0; // ������������ ������ ������ ���������...
  PBTimeMin  : integer = 0;
  PBTimeStep : real    = 0;
  PBTimePos  : real    = 0;

implementation

uses FTTime;

{$R *.dfm}

{ TbklForm }
constructor TbklForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  IconTray:=TTrayIcon.Create(AOwner);
  PMIconTray:=TPopupMenu.Create(AOwner);
  IconTray.OnMouseDown:=IconTrayMouseDown;
end;
procedure TbklForm.CreateParams(var Params: TCreateParams);
const CS_DROPSHADOW = $00020000;
begin
  inherited CreateParams(Params); // ����� �������������� ���������
  Params.WindowClass.Style:=Params.WindowClass.Style or CS_DROPSHADOW;
end;
procedure TbklForm.CreateWnd;
begin
  inherited;
  CreateMutex(nil,true,PWideChar(ExtractFileName(Application.ExeName)));
  if GetLastError=ERROR_ALREADY_EXISTS then
    begin
      MessageBox(Handle,PChar('FilmTimer - ��� �������!!!'),PChar('���������...'),48);
      Application.Terminate; Halt;
    end;
end;
destructor TbklForm.Destroy;
begin
  IconTray.Free;
  PMIconTray.Free;
end;
procedure TbklForm.IconTrayMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Case Button of
    mbLeft:
      begin
        IconTray.Visible:=false;
        Application.MainForm.Show;
        Application.MainForm.WindowState:=wsNormal;
      end;
    mbRight:
      begin
        PMIconTray.Popup(X,Y);
      end;
    end;
end;
procedure TbklForm.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ReleaseCapture; perform(WM_SysCommand,$F012,0);
end;
procedure TbklForm.PaintWindow(DC: HDC);
var
  Region:HRGN;
  Oblast:TRect;
begin
  GetWindowRect(Handle,Oblast);
  OffsetRect(Oblast,-Oblast.Left,-Oblast.Top);
  Region:=CreateRoundRectRgn(Oblast.Left,Oblast.Top,Oblast.Right,Oblast.Bottom,5,5);
  SetWindowRgn(Handle,Region,TRUE);
end;
procedure TbklForm.WMGetSysCommand(var Msg: TMessage);
begin
  If Msg.WParam=SC_MINIMIZE then
    begin
      IconTray.Visible:=true;
      IconTray.ShowBalloonHint;
      Application.MainForm.Hide;
    end;
  inherited;
end;

{ TbklHintWindow }
procedure DrawGradient(Canvas: TCanvas; Rect: TRect; FromColor, ToColor: TColor);
var
  i,Y:Integer;
  R,G,B:Byte;
begin
  i:=0;
  for Y:=Rect.Top to Rect.Bottom-1 do
    begin
      R:=GetRValue(FromColor)+Ceil(((GetRValue(ToColor)-GetRValue(FromColor))/Rect.Bottom-Rect.Top)*i);
      G:=GetGValue(FromColor)+Ceil(((GetGValue(ToColor)-GetGValue(FromColor))/Rect.Bottom-Rect.Top)*i);
      B:=GetBValue(FromColor)+Ceil(((GetBValue(ToColor)-GetBValue(FromColor))/Rect.Bottom-Rect.Top)*i);
      Canvas.Pen.Color:=RGB(R,G,B);
      Canvas.MoveTo(Rect.Left,Y);
      Canvas.LineTo(Rect.Right,Y);
      Inc(i);
    end;
end;
procedure TbklHintWindow.ActivateHint(Rect: TRect; const AHint: String);
begin
  inherited;
  Caption:=AHint;
  Canvas.Font:=Screen.HintFont;
  FBitmap.Canvas.Font:=Screen.HintFont;
  DrawText(Canvas.Handle,PChar(Caption),Length(Caption),Rect,DT_CALCRECT or DT_NOPREFIX);
  Width:=(Rect.Right-Rect.Left)+ 16;
  Height:=(Rect.Bottom-Rect.Top)+ 10;
  FBitmap.Width:=Width;
  FBitmap.Height:=Height;
  Left:=Rect.Left;
  Top:=Rect.Top;
  FreeRegion;
  With Rect do FRegion:=CreateRoundRectRgn(1,1,(Rect.Right-Rect.Left)+16,(Rect.Bottom-Rect.Top)+10,3,3);
  If FRegion<>0 then SetWindowRgn(Handle,FRegion,True);
  AnimateWindowProc(Handle,300,AW_BLEND);
  SetWindowPos(Handle,HWND_TOPMOST,Left,Top,0,0,SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOSIZE);
end;
constructor TbklHintWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBitmap:=TBitmap.Create;
  FBitmap.PixelFormat:=pf24bit;
end;
procedure TbklHintWindow.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $20000;
begin
  inherited;
  Params.Style:=Params.Style-WS_BORDER;
  Params.WindowClass.Style:=Params.WindowClass.style or CS_DROPSHADOW;
end;
destructor TbklHintWindow.Destroy;
begin
  FBitmap.Free;
  FreeRegion;
  inherited;
end;
procedure TbklHintWindow.Erase(var Message: TMessage);
begin
  Message.Result:=0;
end;
procedure TbklHintWindow.FreeRegion;
begin
  if FRegion<>0 then
    begin
      SetWindowRgn(Handle,0,True);
      DeleteObject(FRegion);
      FRegion:=0;
    end;
end;
procedure TbklHintWindow.Paint;
var
  CaptionRect:TRect;
begin
  inherited;
  DrawGradient(FBitmap.Canvas,GetClientRect,RGB(255,255,255),RGB(229,229,240));
  With FBitmap.Canvas do
    begin
      Font.Color:=clGray;
      Brush.Style:= bsClear;
      Pen.Color:=RGB(118,118,118);
      RoundRect(1,1,Width-1,Height-1,6,6);
      RoundRect(1,1,Width-1,Height-1,3,3);
    end;
  CaptionRect:=Rect(8,5,Width,Height);
  DrawText(FBitmap.Canvas.Handle,PChar(Caption),Length(Caption),CaptionRect,DT_WORDBREAK or DT_NOPREFIX);
  BitBlt(Canvas.Handle,0,0,Width,Height,FBitmap.Canvas.Handle,0,0,SRCCOPY);
end;


{ TbklLabel }
procedure TbklLabel.SetScroll(Value: boolean);
begin
  FScroll:=Value;
end;
procedure TbklLabel.SetTime(Value: integer);
begin
  FTime:=Value;
end;
procedure TbklLabel.CMMouseEnter(var Message: TMessage);
begin
  If Time>0 then Scroll:=true;
end;
procedure TbklLabel.CMMouseLeave(var Message: TMessage);
begin
  If Time>0 then Scroll:=false;
end;


{ TbklSpeedButton }
procedure TbklSpeedButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Enabled:=true; RePaint;
end;
procedure TbklSpeedButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if GroupIndex=1 then Enabled:=true else Enabled:=false;
end;
procedure TbklSpeedButton.Paint;
begin
  inherited;
  Canvas.Pen.Color:=clBtnShadow;
  Canvas.Pen.Style:=psSolid;
  Canvas.Brush.Style:=bsClear;
  Canvas.RoundRect(0,0,Width,Height,5,5);
end;

////////////////////////////////////////////////////////////////////////////////
function WindowsExit(RebootParam: Longword): Boolean;
var
   TTokenHd: THandle;
   TTokenPvg: TTokenPrivileges;
   cbtpPrevious: DWORD;
   rTTokenPvg: TTokenPrivileges;
   pcbtpPreviousRequired: DWORD;
   tpResult: Boolean;
const
   SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
   if Win32Platform = VER_PLATFORM_WIN32_NT then
   begin
     tpResult := OpenProcessToken(GetCurrentProcess(),
       TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
       TTokenHd) ;
     if tpResult then
     begin
       tpResult := LookupPrivilegeValue(nil,
                                        SE_SHUTDOWN_NAME,
                                        TTokenPvg.Privileges[0].Luid) ;
       TTokenPvg.PrivilegeCount := 1;
       TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
       cbtpPrevious := SizeOf(rTTokenPvg) ;
       pcbtpPreviousRequired := 0;
       if tpResult then
         Windows.AdjustTokenPrivileges(TTokenHd,
                                       False,
                                       TTokenPvg,
                                       cbtpPrevious,
                                       rTTokenPvg,
                                       pcbtpPreviousRequired) ;
     end;
   end;
   Result := ExitWindowsEx(RebootParam, 0) ;
end;

////////////////////////////////////////////////////////////////////////////////
/////////////// �������� ����� � ����������� ��������� ������� /////////////////
////////////////////////////////////////////////////////////////////////////////

procedure TFFilmTimer.FormCreate(Sender: TObject); /// ��������� ��� ��������...
begin
  FFilmTimer.ClientHeight:=ClientNill; // ����������� ������� �����...
  PBTimeMax:=FFilmTimer.ClientWidth; // ����������� ������������� ������� ������ �������...
  PBTime.Width:=PBTimeMin;  // ����������� ������ ������� � ����...
  LCopirate.Top:=IFonNiz.Top+(IFonNiz.Height-LCopirate.Height) div 2; // �������� �� ������ ������� ����...
  GoTimer.Enabled:=GoTime; // ���������� �������...
  CBShowTimer.Checked:=ShowTimer; N6.Checked:=ShowTimer; // ��������� ������ ����������� �������...
  CBShowTime.Checked:=ShowTimes; N7.Checked:=ShowTimes; // ��������� ������ ����������� ���������� �������...
  CBShowSound.Checked:=ShowSound; N8.Checked:=ShowSound; // ��������� ������ ��������� �������...
  CBUse.ItemIndex:=3; // ������ �������� �� ���������...
  SendMessage(GetWindow(CBUse.Handle,GW_CHILD),EM_SETREADONLY,1,0); // ������ ������...
  TimerBox; // �������� ���� �������...
  TimesBox; // �������� ���� ���������� �������...
  PMIconTray:=FIconTray; // ��������������� �������...
  LClock.SetTime(24);    // ������ ������� - ����...
  LMinutes.SetTime(60);  // ������ ������� - ������...
  LSeconds.SetTime(60);  // ������ ������� - �������...
end;

procedure TFFilmTimer.GoForm(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); // ����������� �����...
begin
  ReleaseCapture; perform(WM_SysCommand,$F012,0);
end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////// ������ ��������� ////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure TFFilmTimer.CloseClick(Sender: TObject); // �������� ���������...
var
   MsgBx:Integer;
begin
  FFilmTimer.Hide;
  MsgBx:=MessageBox(Handle,PChar('�� ������������� ������ �������� ������ ���������?'), PChar('FilmTimer - ���������...'),36);
  if MsgBx=IDYES then Close;
  if MsgBx=IDNO then FFilmTimer.Show;
end;

procedure TFFilmTimer.MinClick(Sender: TObject); // ����������� ��������� � ����...
begin
  PostMessage(FFilmTimer.Handle,WM_SYSCOMMAND,SC_MINIMIZE,0);
  if GoTime=true then
    begin
      IconTray.BalloonTitle:='FilmTimer - �������������� ����������...';
      IconTray.BalloonHint:='������ �������!'+#13+'������ ��������� ����� : '+IntToStr(idClock)+'�. '+IntToStr(idMinutes)+'���. '+IntToStr(idSeconds)+'���.'+#13+CBUse.Text;
      IconTray.BalloonFlags:=bfInfo;
    end
  else
    begin
      IconTray.BalloonTitle:='FilmTimer - �������������� ����������...';
      IconTray.BalloonHint:='������ �� �������!';
      IconTray.BalloonFlags:=bfInfo;
    end;
end;

procedure TFFilmTimer.OptionClick(Sender: TObject); // ����� ���������...
begin
  if ClientNillFull=false then
    begin
      FFilmTimer.ClientHeight:=ClientFull; IOption.GroupIndex:=1; ClientNillFull:=true;
    end
  else
    begin
      FFilmTimer.ClientHeight:=ClientNill; IOption.GroupIndex:=0; ClientNillFull:=false;
    end;
  LCopirate.Top:=IFonNiz.Top+(IFonNiz.Height-LCopirate.Height) div 2;
end;

procedure TFFilmTimer.FixedClick(Sender: TObject); // ������������ �� ���� ���� ����...
begin
  if FTFormStyle=false then
    begin
      FFilmTimer.FormStyle:=fsStayOnTop;
      Application.RestoreTopMosts;
      IFixed.GroupIndex:=1; FTFormStyle:=true;
    end
  else
    begin
      FFilmTimer.FormStyle:=fsNormal;
      IFixed.GroupIndex:=0; FTFormStyle:=false;
    end;
end;

procedure TFFilmTimer.StopClick(Sender: TObject); // ��������� ������ ��������� (�������)...
begin
  GoTime:=false; GoTimer.Enabled:=GoTime;
  PBTime.Width:=PBTimeMin;
  PBTimePos:=0;
  PBTimeStep:=0;
  TimerBoxForm.Hide;
  TimesBoxForm.Hide;
  IRun.GroupIndex:=0;
  IRun.Enabled:=false;
end;

procedure TFFilmTimer.RunClick(Sender: TObject); // ������ ������ ��������� (�������)...
var
  KeyFinish:boolean;
  Time: TDateTime;
  Hours,Minutes,Seconds,Milliseconds: Word;
begin
  KeyFinish:=false;
  idClock:=StrToInt(LClock.Caption);
  idMinutes:=StrToInt(LMinutes.Caption);
  idSeconds:=StrToInt(LSeconds.Caption);
  if (RBFinishFrom.Checked=true) and ((idClock>0) or (idMinutes>0) or (idSeconds>0)) then KeyFinish:=true;
  {if (RBFinishIn.Checked=true) then
    begin
      Time:=GetTime; DecodeTime(Time,Hours,Minutes,Seconds,Milliseconds);
      KeyFinish:=true;
    end;}
  If KeyFinish=true then
    begin
      PBTime.Width:=PBTimeMin; PBTimePos:=0;
      PBTimeStep:=(PBTimeMax/(idClock*120+idMinutes*60+idSeconds));
      GoTime:=true; GoTimer.Enabled:=GoTime; // ������ �������...
      IRun.GroupIndex:=1; IRun.Enabled:=true;
      LCopirate.Caption:=LCopirate.Hint+CBUse.Text;
      MinClick(Sender);
      if ShowTimer=true then TimerBoxForm.Show; // ����������� �������...
      if ShowTimes=true then TimesBoxForm.Show; // ����������� ���������� �������...
    end
  Else
    begin
      MessageBox(handle,pchar('��� ������� ��������� �����!'),pchar('FilmTimer - ���������...'),64);
    end;
end;

////////////////////////////////////////////////////////////////////////////////
///////////////////////////// �������� ������� /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure GoTimerEnabled; // �������� - ������� �� ������ - ��������� ���������...
begin
  if GoTime=true then
    begin
      idClock  :=StrToInt(FFilmTimer.LClock.Caption);
      idMinutes:=StrToInt(FFilmTimer.LMinutes.Caption);
      idSeconds:=StrToInt(FFilmTimer.LSeconds.Caption);
      PBTimePos:=0; //PBTimeStep:=0;
      FFilmTimer.PBTime.Width:=Trunc(PBTimeMax/(idClock*120+idMinutes*60+idSeconds));
    end
  else
    begin
      GoTime:=false; FFilmTimer.GoTimer.Enabled:=GoTime;
      FFilmTimer.PBTime.Width:=PBTimeMin;
      PBTimePos:=0;
      PBTimeStep:=0;
      TimerBoxForm.Hide;
      TimesBoxForm.Hide;
      FFilmTimer.IRun.GroupIndex:=0;
      FFilmTimer.IRun.Enabled:=false;
    end;
end;

procedure TFFilmTimer.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  i:integer;
begin
  for i:=0 to ComponentCount-1 do
    if Components[i] is TLabel then
      if (Components[i] as TLabel).Scroll=true then
        begin
          idTime:=StrToInt((Components[i] as TLabel).Caption); Inc(idTime);
          if idTime=(Components[i] as TLabel).Time then idTime:=1;
          if idTime in [1..(Components[i] as TLabel).Time] then
            (Components[i] as TLabel).Caption:=Format('%.2d',[idTime]);
          TLabel(FindComponent((Components[i] as TLabel).Name+'Up')).Caption:=Format('%.2d',[idTime+1]);
          TLabel(FindComponent((Components[i] as TLabel).Name+'Down')).Caption:=Format('%.2d',[idTime-1]);
          GoTimerEnabled; // �������� - ������� �� ������ - ��������� ���������...
        end;
end;

procedure TFFilmTimer.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  i:integer;
begin
  for i:=0 to ComponentCount-1 do
    if Components[i] is TLabel then
      if (Components[i] as TLabel).Scroll=true then
        begin
          idTime:=StrToInt((Components[i] as TLabel).Caption);
          if (idTime=0) or (idTime=1) then idTime:=(Components[i] as TLabel).Time; Dec(idTime);
          if idTime in [1..(Components[i] as TLabel).Time] then
            (Components[i] as TLabel).Caption:=Format('%.2d',[idTime]);
          TLabel(FindComponent((Components[i] as TLabel).Name+'Up')).Caption:=Format('%.2d',[idTime+1]);
          TLabel(FindComponent((Components[i] as TLabel).Name+'Down')).Caption:=Format('%.2d',[idTime-1]);
          GoTimerEnabled; // �������� - ������� �� ������ - ��������� ���������...
        end;
end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////// ������ �������� /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure TFFilmTimer.EndRun;
begin
// ������� �������� : ������� ����... ������������� ����... ��������� ���������...
  if (CBUse.ItemIndex=0) or (CBUse.ItemIndex=1) or (CBUse.ItemIndex=2) then ShellExecute(Handle,'open',PChar(EPath.Text), nil, nil, SW_SHOWNORMAL);
// ������� �������� : ��������� ���������...
  if (CBUse.ItemIndex=3) then WindowsExit(EWX_POWEROFF or EWX_FORCE);
// ������� �������� : ������������� ���������...
  if (CBUse.ItemIndex=4) then WindowsExit(EWX_REBOOT or EWX_FORCE);
// ������� �������� : ����� �� �������...
  if (CBUse.ItemIndex=5) then ExitWindowsEx(EWX_LOGOFF or ewx_force,0);
// ������� �������� : ������ �����...
  if (CBUse.ItemIndex=6) then MessageBox(handle,pchar('����� �� �������!'),pchar('FilmTimer - ���������...'),64);
// ������� �������� : ������ �����...
  if (CBUse.ItemIndex=7) then MessageBox(handle,pchar('����� �� �������!'),pchar('FilmTimer - ���������...'),64);
end;

////////////////////////////////////////////////////////////////////////////////
///////////////////////////// ��������� ��������� //////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure TFFilmTimer.CBShowSoundClick(Sender: TObject); /// ���������: �������� ������...
begin
  if (Sender is TCheckBox) then ShowSound:=(Sender as TCheckBox).Checked;
  if (Sender is TMenuItem) then ShowSound:=(Sender as TMenuItem).Checked;
  CBShowSound.Checked:=ShowSound;
  N8.Checked:=ShowSound;
end;

procedure TFFilmTimer.CBShowTimerClick(Sender: TObject); /// ���������: ���� �������...
begin
  if (Sender is TCheckBox) then ShowTimer:=(Sender as TCheckBox).Checked;
  if (Sender is TMenuItem) then ShowTimer:=(Sender as TMenuItem).Checked;
  CBShowTimer.Checked:=ShowTimer;
  N6.Checked:=ShowTimer;
  if GoTime=true then if ShowTimer=true then TimerBoxForm.Show else TimerBoxForm.Hide;
end;

procedure TFFilmTimer.CBShowTimeClick(Sender: TObject); /// ���������: ���� ���������� �������...
begin
  if (Sender is TCheckBox) then ShowTimes:=(Sender as TCheckBox).Checked;
  if (Sender is TMenuItem) then ShowTimes:=(Sender as TMenuItem).Checked;
  CBShowTime.Checked:=ShowTimes;
  N7.Checked:=ShowTimes;
  if GoTime=true then if ShowTimes=true then TimesBoxForm.Show else TimesBoxForm.Hide;
end;

procedure TFFilmTimer.CBUseChange(Sender: TObject); /// ���������: ����� ��������...
begin
  if (CBUse.ItemIndex=0) or (CBUse.ItemIndex=1) or (CBUse.ItemIndex=2) then
    begin
      EPath.Visible:=true; IOpen.Visible:=true;
    end
  else
    begin
      EPath.Visible:=false; IOpen.Visible:=false;
    end;
  LCopirate.Caption:=LCopirate.Hint+CBUse.Text;
end;

procedure TFFilmTimer.IOpenClick(Sender: TObject); /// ���������: ����� �����...
begin
  if OpenDialog.Execute then EPath.Text:=OpenDialog.Files.CommaText;
end;

////////////////////////////////////////////////////////////////////////////////
//////////////////////////////// ������ ������� ////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure TFFilmTimer.GoTimerTimer(Sender: TObject); // ������ ������� - �������� 1 �������...
 var
  Time: TDateTime;
  Hours,Minutes,Seconds,Milliseconds: Word;
begin
  idClock  :=StrToInt(LClock.Caption);
  idMinutes:=StrToInt(LMinutes.Caption);
  idSeconds:=StrToInt(LSeconds.Caption);
  if (idClock>0) or (idMinutes>0) or (idSeconds>0) then
    begin
      if (idSeconds=0) and (idMinutes=0) then
        begin
          idClock:=idClock-1;     idMinutes:=60;
          idMinutes:=idMinutes-1; idSeconds:=60;
          idSeconds:=idSeconds-1;
        end;
      if (idSeconds=0) and (idMinutes>0) then
        begin
          idMinutes:=idMinutes-1; idSeconds:=60;
          idSeconds:=idSeconds-1;
          if ShowTimer=true then Application.RestoreTopMosts;
        end;
      if idSeconds>0 then idSeconds:=idSeconds-1;
      PBTimePos:=PBTimePos+PBTimeStep;
      PBTime.Width:=Trunc(PBTimePos);
////////////////////////////////////////////////////////////////////////////////
      LClock.Caption:=Format('%.2d',[idClock]);
      if LClock.Caption<>'00' then begin
      LClockUp.Caption:=Format('%.2d',[idClock+1]);
      LClockDown.Caption:=Format('%.2d',[idClock-1]);
      end else begin LClockUp.Caption:='00'; LClockDown.Caption:='00'; end;

      LMinutes.Caption:=Format('%.2d',[idMinutes]);
      if LMinutes.Caption<>'00' then begin
      LMinutesUp.Caption:=Format('%.2d',[idMinutes+1]);
      LMinutesDown.Caption:=Format('%.2d',[idMinutes-1]);
      end else begin LMinutesUp.Caption:='00'; LMinutesDown.Caption:='00'; end;

      LSeconds.Caption:=Format('%.2d',[idSeconds]);
      if LSeconds.Caption<>'00' then begin
      LSecondsUp.Caption:=Format('%.2d',[idSeconds+1]);
      LSecondsDown.Caption:=Format('%.2d',[idSeconds-1]);
      end else begin LSecondsUp.Caption:='00'; LSecondsDown.Caption:='00'; end;
////////////////////////////////////////////////////////////////////////////////
      if (idClock*120+idMinutes*60+idSeconds)=TimeUps then
        if ShowSound=true then Sound;
      if (idClock*120+idMinutes*60+idSeconds)<TimeUps then
        if TimerBoxForm.LTime.Font.Color=clMaroon then TimerBoxForm.LTime.Font.Color:=clRed
        else TimerBoxForm.LTime.Font.Color:=clMaroon
      else TimerBoxForm.LTime.Font.Color:=clMaroon;
      TimerBoxForm.LTime.Caption:=Format('%.2d',[idClock])+':'+Format('%.2d',[idMinutes])+':'+Format('%.2d',[idSeconds]);
      Time:=GetTime; DecodeTime(Time,Hours,Minutes,Seconds,Milliseconds);
      TimesBoxForm.LTime.Caption:=Format('%.2d',[Hours])+':'+Format('%.2d',[Minutes])+':'+Format('%.2d',[Seconds]);
    end
  else
    begin
      GoTime:=false; GoTimerEnabled;
      EndRun;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////// ����� /////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

initialization
{ ������������� ������ }
  HintWindowClass:=TBKLHintWindow;

finalization
{ ���������� ������ ������ }

end.
