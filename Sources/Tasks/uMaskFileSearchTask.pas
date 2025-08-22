unit uMaskFileSearchTask;

interface

uses
  { VCL }
  Winapi.Windows, System.SysUtils,
  { Common }
  uCustomTasks,
  { MFR }
  uInterfaces, uConsts, uTypes, Common.uConsts;

type

  TMaskFileSearchTask = class(TCustomMKOTask)

  protected

    function GetName: WideString; override; safecall;
    function GetCaption: WideString; override; safecall;
    function GetDescription: WideString; override; safecall;
    function GetParamsHelpText: WideString; override; safecall;
    procedure ValidateParams(const _Params: TArray<String>); override;
    function StartTask(const _Params: TArray<String>): IMKOTaskInstance; override;

  end;

implementation

type

  {TODO 2 -oVasilevSM : Ќу уж, раз начал кастомные классы делать, то и дл€ этого тоже нужен. }
  TMaskFileSearchTaskInstance = class(TInterfacedObject, IMKOTaskInstance)

  strict private

    FParams: TArray<String>;
    FTerminated: Boolean;

    { IMKOTaskInstance }
    procedure Execute(_WriteOutIntf: IMKOTaskWiteOut); safecall;
    procedure Terminate; safecall;

    property Params: TArray<String> read FParams;
    property Terminated: Boolean read FTerminated;

  private

    constructor Create(const _Params: TArray<String>);

  end;

{ TMaskFileSearchTaskInstance }

constructor TMaskFileSearchTaskInstance.Create(const _Params: TArray<String>);
begin
  inherited Create;
  FParams := _Params;
end;

procedure TMaskFileSearchTaskInstance.Execute(_WriteOutIntf: IMKOTaskWiteOut);
var
  Counter: Integer;
begin

  Counter := 0;

  while not Terminated and (Counter < 3) do
  begin

    MessageBox(0, PWideChar(

        'TMaskFileSearchTask started. Params:' + CRLFx2 +
        Params[0] + CRLF +
        Params[1] + CRLF),

    PWideChar('Info'), 1);

    _WriteOutIntf.WriteOut(ClassName + ': ' + Counter.ToString + '.');

    Inc(Counter);

  end;

end;

procedure TMaskFileSearchTaskInstance.Terminate;
begin
  FTerminated := True;
end;

{ TMaskFileSearchTask }

function TMaskFileSearchTask.GetCaption: WideString;
begin
  Result := SC_MASK_FILE_SEARCH_CAPTION;
end;

function TMaskFileSearchTask.GetName: WideString;
begin
  Result := SC_MASK_FILE_SEARCH_NAME;
end;

function TMaskFileSearchTask.GetDescription: WideString;
begin
  Result := SC_MASK_FILE_SEARCH_DESCRIPTION;
end;

function TMaskFileSearchTask.GetParamsHelpText: WideString;
begin
  Result := SC_MASK_FILE_SEARCH_PARAMS_HELP_TEXT;
end;

procedure TMaskFileSearchTask.ValidateParams(const _Params: TArray<String>);
begin

  {TODO 2 -oVasilevSM : «десь же нужно нормализовывать параметры до общего дл€ задачи вида. “риммить тоже
    здесь. ¬ообще, параметры могут быть любыми, поэтому их приведение в пор€док - дело конкретной задачи. }
  if Length(_Params) <> 2 then
    raise EMKOLibException.Create('Params error');

end;

function TMaskFileSearchTask.StartTask(const _Params: TArray<String>): IMKOTaskInstance;
begin
  Result := TMaskFileSearchTaskInstance.Create(_Params);
end;

end.
