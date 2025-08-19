unit uMaskFileSearchTask;

interface

uses
  { VCL }
  Winapi.Windows,
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

  TMaskFileSearchTaskInstance = class(TInterfacedObject, IMKOTaskInstance)

  strict private

    FParams: TArray<String>;
    FTerminated: Boolean;

    { IMKOTaskInstance }
    procedure Execute; safecall;
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

procedure TMaskFileSearchTaskInstance.Execute;
begin

  while not Terminated do

    MessageBox(0, PWideChar(

        'TMaskFileSearchTask started. Params:' + CRLFx2 +
        Params[0] + CRLF +
        Params[1] + CRLF),

    PWideChar('Info'), 1);

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

  {TODO 2 -oVasilevSM : Здесь же нужно нормализовывать параметры до общего для задачи вида. Триммить тоже
    здесь. Вообще, параметры могут быть любыми, поэтому их приведение в порядок - дело конкретной задачи. }
  if Length(_Params) <> 2 then
    raise EMKOLibException.Create('Params error');

end;

function TMaskFileSearchTask.StartTask(const _Params: TArray<String>): IMKOTaskInstance;
begin
  Result := TMaskFileSearchTaskInstance.Create(_Params);
end;

end.
