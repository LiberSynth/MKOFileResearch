library MKOFileResearch;

uses
  System.SysUtils,
  System.IOUtils,
  uInterfaces in '..\..\MKOCommon\TaskManager\uInterfaces.pas',
  uConsts in 'Common\uConsts.pas';

{$R *.res}

procedure MKOTaskLibraryMarker;
begin
end;

procedure InitLibrary(MKOTaskLibrary: IMKOTaskLibrary); safecall;
begin

  with MKOTaskLibrary do
  begin

    RegisterTask(

        SC_MASK_FILE_SEARCH_NAME,
        SC_MASK_FILE_SEARCH_CAPTION,
        SC_MASK_FILE_SEARCH_DESCRIPTION

    );

    RegisterTask(

        SC_FILE_CONTENT_RESEARCH_NAME,
        SC_FILE_CONTENT_RESEARCH_CAPTION,
        SC_FILE_CONTENT_RESEARCH_DESCRIPTION

    );

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
