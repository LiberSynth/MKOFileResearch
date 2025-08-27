library MKOFileResearch;

uses
  System.SysUtils,
  System.IOUtils,
  Common.uConsts in '..\..\MKOCommon\Utils\Common.uConsts.pas',
  Common.uTypes in '..\..\MKOCommon\TaskManager\Common.uTypes.pas',
  Common.uInterfaces in '..\..\MKOCommon\TaskManager\Common.uInterfaces.pas',
  Common.uCustomTasks in '..\..\MKOCommon\TaskManager\Common.uCustomTasks.pas',
  Common.uUtils in '..\..\MKOCommon\Utils\Common.uUtils.pas',
  Common.uFileUtils in '..\..\MKOCommon\Utils\Common.uFileUtils.pas',
  Common.uFileExplorer in '..\..\MKOCommon\Utils\Common.uFileExplorer.pas',
  uConsts in 'Common\uConsts.pas',
  uMaskFileSearchTask in 'Tasks\uMaskFileSearchTask.pas',
  uFileContentResearchTask in 'Tasks\uFileContentResearchTask.pas';

{$R *.res}

procedure MKOTaskLibraryMarker;
begin
end;

procedure InitLibrary(MKOTaskLibrary: IMKOTaskLibrary); safecall;
begin

  with MKOTaskLibrary do
  begin

    RegisterTask(TMaskFileSearchTask.Create);
    RegisterTask(TFileContentResearchTask.Create);

  end;

end;

procedure FinLibrary; safecall;
begin
end;

exports

  MKOTaskLibraryMarker,
  InitLibrary,
  FinLibrary;

begin
end.
