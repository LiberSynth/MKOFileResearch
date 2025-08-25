unit uFileContentResearchTask;

interface

uses
  { VCL }
  Winapi.Windows, System.SysUtils,
  { Common }
  Common.uConsts, Common.uTypes, Common.uUtils, Common.uInterfaces, Common.uCustomTasks,
  Common.uFileUtils,
  { MFR }
  uConsts;

type

  TFileContentResearchTask = class(TCustomTask)

  protected

    function GetName: WideString; override; safecall;
    function GetCaption: WideString; override; safecall;
    function GetDescription: WideString; override; safecall;
    function GetParamsHelpText: WideString; override; safecall;
    function ValidateParams(const _Params: IMKOTaskParams): LongBool; override; safecall;
    function StartTask(const _Params: IMKOTaskParams): IMKOTaskInstance; override; safecall;

  end;

implementation

type

  TFileContentResearchTaskInstance = class(TCustomMKOTaskInstance)

  strict private

    FPattern: TBlob;
    FPath: String;
    FFileData: TBlob;
    FDataLength: LongInt;
    FPatternLength: Integer;
    FOccurenceCount: LongInt;

    procedure ReadFile;
    procedure ProcessData;
    function ComparePattern(_Pos: LongInt): Boolean;

    property Pattern: TBlob read FPattern;
    property Path: String read FPath;
    property FileData: TBlob read FFileData;
    property DataLength: LongInt read FDataLength;
    property PatternLength: Integer read FPatternLength;
    property OccurenceCount: LongInt read FOccurenceCount;

  protected

    procedure Execute(const _OutputIntf: IMKOTaskOutput); override; safecall;
    procedure Init(const _OutputIntf: IMKOTaskOutput); override;

  end;

{ TFileContentResearchTaskInstance }

function TFileContentResearchTaskInstance.ComparePattern(_Pos: LongInt): Boolean;
var
  i: Integer;
begin

  for i := 1 to PatternLength do
    if FileData[_Pos + i - 1] <> Pattern[i] then
      Exit(False);

  Result := True;

end;

procedure TFileContentResearchTaskInstance.Execute(const _OutputIntf: IMKOTaskOutput);
begin

  inherited Execute(_OutputIntf);

  WriteOut(SC_CONTENT_RESEARCH_TASK_PREPARING_MESSAGE, -1);
  ReadFile;

  if Terminated then
    Exit;

  WriteOut(SC_CONTENT_RESEARCH_TASK_PROCESSING_MESSAGE, -1);
  ProcessData;

  WriteOut(Format(SC_CONTENT_RESEARCH_TASK_COMPLETE_MESSAGE, [DataLength, OccurenceCount]), -1);

end;

procedure TFileContentResearchTaskInstance.Init(const _OutputIntf: IMKOTaskOutput);
begin

  inherited Init(_OutputIntf);

  FPattern := TBlob(AnsiString(Params[0]));
  FPath := Params[1];

  FPatternLength := Length(Pattern);

end;

procedure TFileContentResearchTaskInstance.ProcessData;
var
  i, L: LongInt;
  Progress: ShortInt;
begin

  L := DataLength - PatternLength;
  for i := 1 to L + 1 do
  begin

    Progress := Round(i / L * 100);

    if ComparePattern(i) then
    begin

      WriteOut(Format(SC_CONTENT_RESEARCH_TASK_PATTERN_FOUND_MESSAGE, [i]), Progress);
      Inc(FOccurenceCount);

    end
    else WriteOut('', Progress);

  end;

end;

procedure TFileContentResearchTaskInstance.ReadFile;
begin

  FFileData := FileToBLOB(Path);
  FDataLength := Length(FileData);

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
