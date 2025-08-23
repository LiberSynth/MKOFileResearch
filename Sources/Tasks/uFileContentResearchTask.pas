unit uFileContentResearchTask;

interface

uses
  { VCL }
  Winapi.Windows, System.SysUtils,
  { Common }
  uInterfaces,
  { MFR }
  uConsts, Common.uConsts, Common.uUtils, uTypes;

type

  TFileContentResearchTask = class(TInterfacedObject, IMKOTask)

  strict private

    { IMKOTask }
    function GetName: WideString; safecall;
    function GetCaption: WideString; safecall;
    function GetDescription: WideString; safecall;
    function GetParamsHelpText: WideString; safecall;
    function ValidateParams(const _Params: IMKOTaskParams): LongBool; safecall;
    function StartTask(const _Params: IMKOTaskParams): IMKOTaskInstance; safecall;

  end;

implementation

type

  TFileContentResearchTaskInstance = class(TInterfacedObject, IMKOTaskInstance)

  strict private

    FParams: IMKOTaskParams;
    FTerminated: Boolean;

    { IMKOTaskInstance }
    procedure Execute(const _OutputIntf: IMKOTaskOutput); safecall;
    procedure Terminate; safecall;

    property Params: IMKOTaskParams read FParams;
    property Terminated: Boolean read FTerminated;

  private

    constructor Create(const _Params: IMKOTaskParams);

  end;

{ TFileContentResearchTaskInstance }

constructor TFileContentResearchTaskInstance.Create(const _Params: IMKOTaskParams);
begin
  inherited Create;
  FParams := _Params;
end;

procedure TFileContentResearchTaskInstance.Execute(const _OutputIntf: IMKOTaskOutput);
var
  Counter: Integer;
begin

  Counter := 0;

  while not Terminated and (Counter < 10) do
  begin

    Sleep(800);
    Inc(Counter);

    _OutputIntf.WriteOut(

        ClassName + ': ' + Counter.ToString + '.',
        Counter * 10

    );

  end;

end;

procedure TFileContentResearchTaskInstance.Terminate;
begin
  FTerminated := True;
end;

{ TFileContentResearchTask }

function TFileContentResearchTask.GetName: WideString;
begin
  Result := SC_FILE_CONTENT_RESEARCH_NAME;
end;

function TFileContentResearchTask.GetCaption: WideString;
begin
  Result := SC_FILE_CONTENT_RESEARCH_CAPTION;
end;

function TFileContentResearchTask.GetDescription: WideString;
begin
  Result := SC_FILE_CONTENT_RESEARCH_DESCRIPTION;
end;

function TFileContentResearchTask.GetParamsHelpText: WideString;
begin
  Result := SC_FILE_CONTENT_RESEARCH_PARAMS_HELP_TEXT;
end;

function TFileContentResearchTask.ValidateParams(const _Params: IMKOTaskParams): LongBool;
const
  SC_FORMAT = '%s%s' + CRLF;
var
  EM: String;
begin

  with _Params do
  begin

    EM := '';

    if Count <> 2 then
      EM := Format(SC_FORMAT, [EM, SC_CONTENT_RESEARCH_TASK_PARAMS_COUNT_ERROR]);

    if (Count > 1) and not FileExists(_Params[1]) then
      EM := Format(SC_FORMAT, [EM, SC_CONTENT_RESEARCH_TASK_FILE_NOT_FOUND_ERROR]);

    Result := not CutStr(EM, 2);

    if not Result then
      ErrorMessage := EM;

  end;

end;

function TFileContentResearchTask.StartTask(const _Params: IMKOTaskParams): IMKOTaskInstance;
begin
  Result := TFileContentResearchTaskInstance.Create(_Params);
end;

end.
