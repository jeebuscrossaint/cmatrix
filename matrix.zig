const windows = @cImport({
    @cInclude("windows.h");
});

const std = @import("std");

pub fn main() void {
    std.debug.print("Hello, World\n", .{});
}
