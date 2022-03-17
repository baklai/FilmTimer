unit FTTime;

interface

{$IFDEF MSWINDOWS}
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls, Buttons, mmsystem;
{$ENDIF}

  procedure TimerBox; /// Создание формы с таймером...
  procedure TimesBox; /// Создание формы с системным временем...
  procedure Sound; /// Звук...

{ TTimeBoxForm }
type
  TTimeBoxForm = class(TForm)
    LTime:TLabel;
    GTime:TGroupBox;
    procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); /// Перемещение формы...
    procedure FormShow(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams);
  public
    constructor CreateNew(AOwner:TComponent); reintroduce;
  end;

var
  TimerBoxForm:TTimeBoxForm;
  TimesBoxForm:TTimeBoxForm;

  Tada: Pointer;

implementation

{$R FTTime.res}

uses FTMain;

procedure Sound; /// Звук...
begin
  sndPlaySound(Tada, SND_MEMORY or SND_NODEFAULT or SND_ASYNC);
end;

{ TTimeBoxForm }
constructor TTimeBoxForm.CreateNew(AOwner: TComponent);
begin
  inherited
  CreateNew(AOwner);
end;

procedure TTimeBoxForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      ExStyle:=ExStyle or WS_EX_TOPMOST;
      WndParent:=GetDesktopWindow;
    end;
end;

procedure TTimeBoxForm.FormShow(Sender: TObject);
begin
  PostMessage(Handle,WM_SYSCOMMAND,SC_RESTORE,0);
end;

procedure TTimeBoxForm.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture; perform(WM_SysCommand,$F012,0);
end;

////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// СОЗДАНИЕ ОКНА ////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

function TimeBoxCreate:TTimeBoxForm;
begin
  result:=TTimeBoxForm.CreateNew(Application);
  with result do
    begin
      Parent:=nil;
      AlphaBlend:=true; AlphaBlendValue:=250;
      BorderIcons:=[]; BorderStyle:=bsNone;
      ClientHeight:=58; ClientWidth:=160;
      FormStyle:=fsStayOnTop;
      Color:=clGray; TransparentColor:=true;
      TransparentColorValue:=clGray;
      OnShow:=TTimeBoxForm(Result).FormShow;
      OnMouseDown:=TTimeBoxForm(Result).MouseDown;
      TTimeBoxForm(Result).GTime:=TGroupBox.Create(Result);
      with TTimeBoxForm(Result).GTime do
        begin
          Parent:=result; Color:=clGray; ParentBackground:=false;
          ParentColor:=false; Width:=143; Height:=31; Left:=10; Top:=8;
          OnMouseDown:=TTimeBoxForm(Result).MouseDown;
         end;
       TTimeBoxForm(Result).LTime:=TLabel.Create(Result);
       with TTimeBoxForm(Result).LTime do
        begin
          Parent:=TTimeBoxForm(Result).GTime; Font.Style:=[fsBold]; Caption:='00:00:00';
          Font.Name:='Comic Sans MS'; Font.Color:=clMaroon; Font.Size:=20;
          Font.Style:=[fsBold]; Layout:=tlCenter; Left:=12;
          ParentFont:=false; ShowHint:=true; Top:=-4; Transparent:=true;
          OnMouseDown:=TTimeBoxForm(Result).MouseDown;
        end;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
//////////////////////////// ВЫЗОВ ОКОН ТАЙМЕРОВ ///////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure TimerBox; /// Создание формы с таймером...
var
  Rect:TRect;
begin
  TimerBoxForm:=TimeBoxCreate;
  SystemParametersInfo(SPI_GETWORKAREA,0,@Rect,0);
  TimerBoxForm.Left:=Rect.Right-TimerBoxForm.Width;
  TimerBoxForm.Top:=Rect.Bottom-TimerBoxForm.Height;
end;

procedure TimesBox; /// Создание формы с системным временем...
var
  Rect:TRect;
begin
  TimesBoxForm:=TimeBoxCreate;
  SystemParametersInfo(SPI_GETWORKAREA,0,@Rect,0);
  TimesBoxForm.Left:=0;
  TimesBoxForm.Top:=0;
end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

initialization
{ Инициализация модуля }

  Tada:=Pointer(FindResource(hInstance,'play',RT_RCDATA));
  If Tada<>nil then
    begin
      Tada:=Pointer(LoadResource(hInstance,HRSRC(Tada)));
      if Tada<>nil then Tada:=LockResource(HGLOBAL(Tada));
    end;

finalization
{ Завершение работы модуля }


end.