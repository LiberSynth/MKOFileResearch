library MKOFileResearch;

uses
  System.SysUtils,
  System.IOUtils,
  uInterfaces in '..\..\MKOCommon\TaskManager\uInterfaces.pas',
  uTypes in '..\..\MKOCommon\TaskManager\uTypes.pas',
  Common.uConsts in '..\..\MKOCommon\Utils\Common.uConsts.pas',
  uConsts in 'Common\uConsts.pas',
  uMaskFileSearchTask in 'Tasks\uMaskFileSearchTask.pas',
  uFileContentResearchTask in 'Tasks\uFileContentResearchTask.pas',
  Common.uUtils in '..\..\MKOCommon\Utils\Common.uUtils.pas',
  uFileExplorer in '..\..\MKOCommon\Utils\uFileExplorer.pas';

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
