unit uConsts;

interface

uses
  { Common }
  Common.uConsts;

const

  SC_MASK_FILE_SEARCH_NAME = 'MaskFileSearch';
  SC_MASK_FILE_SEARCH_CAPTION = '����� ������ �� �����';
  SC_MASK_FILE_SEARCH_DESCRIPTION = '���������� ������ ������ ������ �� ����� � ��������� ����� ������.';
  SC_MASK_FILE_SEARCH_PARAMS_HELP_TEXT =

      '�������� 1 - ����� ��� ������ �����. ��������, "*.txt|*.doc".' + CRLF +
      '�������� 2 - �������� �������. ��������, "P:\Documents".';

  SC_FILE_CONTENT_RESEARCH_NAME = 'FileContentResearch';
  SC_FILE_CONTENT_RESEARCH_CAPTION = '����� ������ � �����';
  SC_FILE_CONTENT_RESEARCH_DESCRIPTION = '���������� ������ ��������� ������������������ �������� � �����.';
  SC_FILE_CONTENT_RESEARCH_PARAMS_HELP_TEXT =

      '�������� 1 - ������ ��� ������ ��������� � �����. ��������, "libsec".' + CRLF +
      '�������� 2 - ��� � ���� �����. ��������, "P:\Dumps\BigFile.bin".';

implementation

end.
