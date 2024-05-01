const windows = @cImport({
    @cInclude("windows.h");
});

const std = @import("std");
const RndGen = std.rand.DefaultPrng;

pub fn main() void {
    const time = std.time.milliTimestamp();
    var rnd = RndGen.init(@intCast(time));
    var random_num = rnd.random().int(u32);
    random_num = @abs(random_num);
    var buffer: [20]u8 = undefined;
    const str_num = std.fmt.bufPrint(&buffer, "{}", .{random_num}) catch unreachable;
    const usable_digit = str_num[0] - '0';
    std.debug.print("{}\n", .{usable_digit});
}
