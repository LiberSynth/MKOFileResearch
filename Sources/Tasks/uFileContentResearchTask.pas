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
    procedure ValidateParams(const _Params: WideString); safecall;
    procedure Start(const _Params: WideString); safecall;
    procedure Cancel; safecall;

  end;

implementation

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

procedure TFileContentResearchTask.ValidateParams(const _Params: WideString);
begin

end;

procedure TFileContentResearchTask.Start(const _Params: WideString);
begin
  MessageBox(0, PWideChar('TFileContentResearchTask started. Params:' + CRLFx2 + _Params), PWideChar('Info'), 1);
end;

procedure TFileContentResearchTask.Cancel;
begin

end;

end.
