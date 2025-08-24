unit uConsts;

interface

uses
  { Common }
  Common.uConsts;

const

  SC_MASK_FILE_SEARCH_NAME             = 'MaskFileSearch';
  SC_MASK_FILE_SEARCH_CAPTION          = 'Поиск файлов по маске';
  SC_MASK_FILE_SEARCH_DESCRIPTION      = 'Функциональность поиска списка файлов по маске и стартовому каталогу.';
  SC_MASK_FILE_SEARCH_PARAMS_HELP_TEXT =

      'Параметр 1 - маска для поиска файла. Например, "*.txt|*.doc". Необязательный.' + CRLF +
      'Параметр 2 - корневой каталог. Например, "P:\Documents".';

  SC_FILE_SEARCH_TASK_PARAMS_COUNT_ERROR        = 'Для этой задачи требуется один или два параметра.';
  SC_FILE_SEARCH_TASK_DIRECTORY_NOT_FOUND_ERROR = 'Капталог по указанному пути не найден.';
  SC_FILE_SEARCH_TASK_PREPARING_MESSAGE         = 'Подготовка к выполнению задачи.';
  SC_FILE_SEARCH_TASK_PROCESSING_MESSAGE        = 'Выполнение задачи.';
  SC_FILE_SEARCH_TASK_COMPLETE_MESSAGE          = 'Процесс завершен. Всего файлов: %d, соответствуют маске: %d.';

  SC_FILE_CONTENT_RESEARCH_NAME             = 'FileContentResearch';
  SC_FILE_CONTENT_RESEARCH_CAPTION          = 'Поиск строки в файле';
  SC_FILE_CONTENT_RESEARCH_DESCRIPTION      = 'Функциональность поиска вхождений последовательности символов в файле.';
  SC_FILE_CONTENT_RESEARCH_PARAMS_HELP_TEXT =

      'Параметр 1 - шаблон для поиска вхождения в файле. Например, "libsec".' + CRLF +
      'Параметр 2 - имя и путь файла. Например, "P:\Dumps\BigFile.bin".';

  SC_CONTENT_RESEARCH_TASK_PARAMS_COUNT_ERROR    = 'Для этой задачи требуется два параметра.';
  SC_CONTENT_RESEARCH_TASK_FILE_NOT_FOUND_ERROR  = 'Файл по указанному пути не найден.';
  SC_CONTENT_RESEARCH_TASK_PREPARING_MESSAGE     = 'Подготовка к выполнению задачи.';
  SC_CONTENT_RESEARCH_TASK_PROCESSING_MESSAGE    = 'Выполнение задачи.';
  SC_CONTENT_RESEARCH_TASK_COMPLETE_MESSAGE      = 'Процесс завершен. Размер файла: %d, найдено вхождений: %d.';
  SC_CONTENT_RESEARCH_TASK_PATTERN_FOUND_MESSAGE = 'Найдено вхождение шаблона, позиция %d.';

implementation

end.
