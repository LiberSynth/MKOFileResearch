unit uMaskFileSearchTask;

interface

uses
  { VCL }
  Winapi.Windows,
  { Common }
  uCustomTasks,
  { MFR }
  uConsts, uTypes, Common.uConsts;

type

  TMaskFileSearchTask = class(TCustomMKOTask)

  protected

    function GetName: WideString; override; safecall;
    function GetCaption: WideString; override; safecall;
    function GetDescription: WideString; override; safecall;
    function GetParamsHelpText: WideString; override; safecall;
    procedure ValidateParams(const _Params: TArray<String>); override;
    procedure Start(const _Params: TArray<String>); override;
    procedure Cancel; override; safecall;

  end;

implementation

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

  if Length(_Params) <> 2 then
    raise EMKOLibException.Create('Params error');

end;

procedure TMaskFileSearchTask.Start(const _Params: TArray<String>);
begin
  MessageBox(0, PWideChar(

      'TMaskFileSearchTask started. Params:' + CRLFx2 +
      _Params[0] + CRLF +
      _Params[1] + CRLF),

  PWideChar('Info'), 1);

end;

procedure TMaskFileSearchTask.Cancel;
begin

end;

end.
