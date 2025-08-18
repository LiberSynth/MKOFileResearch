unit uConsts;

interface

uses
  { Common }
  Common.uConsts;

const

  SC_MASK_FILE_SEARCH_NAME = 'MaskFileSearch';
  SC_MASK_FILE_SEARCH_CAPTION = 'Поиск файлов по маске';
  SC_MASK_FILE_SEARCH_DESCRIPTION = 'Функционал поиска списка файлов по маске и стартовой папке поиска.';
  SC_MASK_FILE_SEARCH_PARAMS_HELP_TEXT =

      'Параметр 1 - маска для поиска файла. Например, "*.txt|*.doc".' + CRLF +
      'Параметр 2 - корневой каталог. Например, "P:\Documents".';

  SC_FILE_CONTENT_RESEARCH_NAME = 'FileContentResearch';
  SC_FILE_CONTENT_RESEARCH_CAPTION = 'Поиск строки в файле';
  SC_FILE_CONTENT_RESEARCH_DESCRIPTION = 'Функционал поиска вхождений последовательности символов в файле.';
  SC_FILE_CONTENT_RESEARCH_PARAMS_HELP_TEXT =

      'Параметр 1 - шаблон для поиска вхождения в файле. Например, "libsec".' + CRLF +
      'Параметр 2 - имя и путь файла. Например, "P:\Dumps\BigFile.bin".';

implementation

end.
