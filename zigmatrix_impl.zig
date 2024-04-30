const windows = @cImport({
    @cInclude("windows.h");
});

const STD_OUTPUT_HANDLE = -11;

const HANDLE = windows.HANDLE;
const DWORD = windows.DWORD;
const BOOL = windows.BOOL;
const WORD = windows.WORD;
const COORD = windows.COORD;
const CONSOLE_SCREEN_BUFFER_INFO = windows.CONSOLE_SCREEN_BUFFER_INFO;

const GetStdHandle = windows.GetStdHandle;
const SetConsoleCursorPosition = windows.SetConsoleCursorPosition;
const WriteConsole = windows.WriteConsoleA;
const Sleep = windows.Sleep;
