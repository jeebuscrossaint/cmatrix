// Import basic stuff and declarations.

const windows = @cImport({
    @cInclude("windows.h");
});
const std = @import("std");
const thread_rng = std.rand.thread_rng;
const STD_OUTPUT_HANDLE = 0xFFFFFFF5;

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

// yo actual code?

pub fn main() void {
    const std_out_handle = GetStdHandle(STD_OUTPUT_HANDLE);
    if (std_out_handle == windows.INVALID_HANDLE_VALUE) {
        return;
    }

    const clear_screen = "\x1b[2J";
    const clear_screen_len = clear_screen.len;
    var written: DWORD = undefined;
    const success = WriteConsole(std_out_handle, clear_screen, clear_screen_len, &written, null);
    if (success == 0) {
        return;
    }

    // ok now we are really in the matrix guys i think like we might just be dodging bullets like how i went from a 35 to an 88 in calculus two this semester ending with an A- ngl i am jsut crazy wit it
    const green_text = "\x1b[32m";
    const green_text_len = green_text.len;
    const success2 = WriteConsole(std_out_handle, green_text, green_text_len, &written, null);
    if (success2 == 0) {
        return;
    }

    // ok now we are in the matrix
    const rng_state = std.rand.DefaultPrng.init(1234); // 1234 is the seed

    while (true) {
        const char = 'a' + std.rand.scalar(rng_state, u8) % 26;
        var pos: COORD = undefined;
        pos.X = std.rand.scalar(rng_state, u16) % 80;
        pos.Y = std.rand.scalar(rng_state, u16) % 25;

        SetConsoleCursorPosition(std_out_handle, pos);
        const success3 = WriteConsole(std_out_handle, &char, 1, &written, null);
        if (success3 == 0) {
            return;
        }

        Sleep(100);
    }
}
