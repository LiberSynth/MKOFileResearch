unit uMaskFileSearchTask;

interface

uses
  { VCL }
  Winapi.Windows, System.SysUtils,
  { MFR }
  uInterfaces, uConsts, uTypes, Common.uConsts, Common.uUtils, uFileExplorer;

type

  TMaskFileSearchTask = class(TInterfacedObject, IMKOTask)

  protected

    function GetName: WideString; safecall;
    function GetCaption: WideString; safecall;
    function GetDescription: WideString; safecall;
    function GetParamsHelpText: WideString; safecall;
    function ValidateParams(const _Params: IMKOTaskParams): LongBool; safecall;
    function StartTask(const _Params: IMKOTaskParams): IMKOTaskInstance; safecall;

  end;

implementation

type

  TMaskFileSearchTaskInstance = class(TInterfacedObject, IMKOTaskInstance)

  strict private

    FParams: IMKOTaskParams;
    FTerminated: Boolean;
    FOutputIntf: IMKOTaskOutput;
    FPath: String;
    FMasks: String;
    FFileCount: Integer;
    FProcessedCount: Integer;
    FMatchingCount: Integer;
    FProgress: Byte;

    { IMKOTaskInstance }
    procedure Execute(const _OutputIntf: IMKOTaskOutput); safecall;
    procedure Terminate; safecall;

    procedure InitResearch(const _OutputIntf: IMKOTaskOutput);
    procedure CountFiles;
    procedure ProcessFiles;
    procedure WriteOut(const _Value: WideString; _Progress: Integer);

    property Params: IMKOTaskParams read FParams;
    property Terminated: Boolean read FTerminated;
    property OutputIntf: IMKOTaskOutput read FOutputIntf;
    property Path: String read FPath;
    property Masks: String read FMasks;
    property FileCount: Integer read FFileCount;
    property ProcessedCount: Integer read FProcessedCount;
    property MatchingCount: Integer read FMatchingCount;
    property Progress: Byte read FProgress write FProgress;

  private

    constructor Create(const _Params: IMKOTaskParams);

  end;

{ TMaskFileSearchTaskInstance }

constructor TMaskFileSearchTaskInstance.Create(const _Params: IMKOTaskParams);
begin
  inherited Create;
  FParams := _Params;
end;

procedure TMaskFileSearchTaskInstance.CountFiles;
begin

  ExploreFiles(

      Path,
      Masks,
      True,
      procedure (const _File: String; _MaskMatches: Boolean; var _Terminated: Boolean)
      begin

        if Terminated then
          _Terminated := True
        else
          Inc(FFileCount);

      end

  );

end;

procedure TMaskFileSearchTaskInstance.ProcessFiles;
begin

  ExploreFiles(

      Path,
      Masks,
      True,
      procedure (const _File: String; _MaskMatches: Boolean; var _Terminated: Boolean)
      begin

        if Terminated then

          _Terminated := True

        else
        begin

          Inc(FProcessedCount);
          Progress := Round(ProcessedCount / FileCount * 100);

          if _MaskMatches then
          begin

            {$IFDEF DEBUG}
            Sleep(100);
            {$ENDIF}
            Inc(FMatchingCount);
            WriteOut(_File, Progress);

          end
          else
            WriteOut('', Progress);

          if Terminated then
            _Terminated := True;

        end;

      end

  );

end;

procedure TMaskFileSearchTaskInstance.Execute(const _OutputIntf: IMKOTaskOutput);
begin

  InitResearch(_OutputIntf);

  WriteOut(SC_FILE_SEARCH_TASK_PREPARING_MESSAGE, -1);
  CountFiles;

  if Terminated then
    Exit;

  WriteOut(SC_FILE_SEARCH_TASK_PROCESSING_MESSAGE, -1);
  ProcessFiles;

  WriteOut(Format(SC_FILE_SEARCH_TASK_COMPLETE_MESSAGE, [FileCount, MatchingCount]), -1);

end;

procedure TMaskFileSearchTaskInstance.InitResearch(const _OutputIntf: IMKOTaskOutput);
begin

  FOutputIntf := _OutputIntf;

  if Params.Count = 2 then
  begin

    FMasks := Params[0];
    FPath := Params[1];

  end
  else
  begin

    FMasks := '';
    FPath := Params[0];

  end

end;

procedure TMaskFileSearchTaskInstance.Terminate;
begin
  FTerminated := True;
end;

procedure TMaskFileSearchTaskInstance.WriteOut(const _Value: WideString; _Progress: Integer);
begin
  if not Terminated then
    OutputIntf.WriteOut(_Value, _Progress);
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

function TMaskFileSearchTask.ValidateParams(const _Params: IMKOTaskParams): LongBool; safecall;
const
  SC_FORMAT = '%s%s' + CRLF;
var
  EM: String;
begin

  with _Params do
  begin

    EM := '';

    if not Count in [1, 2] then
      EM := Format(SC_FORMAT, [EM, SC_FILE_SEARCH_TASK_PARAMS_COUNT_ERROR]);

    if

        ((Count = 1) and not DirectoryExists(_Params[0])) or
        ((Count = 2) and not DirectoryExists(_Params[1]))

    then EM := Format(SC_FORMAT, [EM, SC_FILE_SEARCH_TASK_DIRECTORY_NOT_FOUND_ERROR]);

    Result := not CutStr(EM, 2);

    if not Result then
      ErrorMessage := EM;

  end;

end;

function TMaskFileSearchTask.StartTask(const _Params: IMKOTaskParams): IMKOTaskInstance; safecall;
begin
  Result := TMaskFileSearchTaskInstance.Create(_Params);
end;

end.
