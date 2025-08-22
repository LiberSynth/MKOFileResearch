unit uFileContentResearchTask;

interface

uses
  { VCL }
  Winapi.Windows,
  { Common }
  uInterfaces,
  { MFR }
  uConsts, Common.uConsts;

type

  TFileContentResearchTask = class(TInterfacedObject, IMKOTask)

  strict private

    { IMKOTask }
    function GetName: WideString; safecall;
    function GetCaption: WideString; safecall;
    function GetDescription: WideString; safecall;
    function GetParamsHelpText: WideString; safecall;
    procedure ValidateParams(var _Params: WideString); safecall;
    function StartTask(const _Params: WideString): IMKOTaskInstance; safecall;

  end;

implementation

type

  TFileContentResearchTaskInstance = class(TInterfacedObject, IMKOTaskInstance)

  strict private

    FParams: String;
    FTerminated: Boolean;

    { IMKOTaskInstance }
    procedure Execute(_WriteOutIntf: IMKOTaskWiteOut); safecall;
    procedure Terminate; safecall;

    property Params: String read FParams;
    property Terminated: Boolean read FTerminated;

  private

    constructor Create(const _Params: String);

  end;

{ TFileContentResearchTaskInstance }

constructor TFileContentResearchTaskInstance.Create(const _Params: String);
begin
  inherited Create;
  FParams := _Params;
end;

procedure TFileContentResearchTaskInstance.Execute(_WriteOutIntf: IMKOTaskWiteOut);
begin

  while not Terminated do
    Sleep(200);

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

procedure TFileContentResearchTask.ValidateParams(var _Params: WideString);
begin

end;

function TFileContentResearchTask.StartTask(const _Params: WideString): IMKOTaskInstance;
begin
  Result := TFileContentResearchTaskInstance.Create(_Params);
end;

end.
