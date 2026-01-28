const glfw = @import("glfw.zig");
const std = @import("std");

pub const Window = @import("Window.zig");
pub const Monitor = @import("Monitor.zig");
pub const input = @import("input.zig");
pub const Image = @import("Image.zig");
pub const Cursor = @import("Cursor.zig");

pub const Pos = struct { x: i32, y: i32 };
pub const f64Pos = struct { x: f64, y: f64 };
pub const Rectangle = struct { x: i32, y: i32, width: u32, height: u32 };
pub const Rectangle2 = struct { left: i32, top: i32, right: i32, bottom: i32 };
pub const Size = struct { width: u32, height: u32 };
pub const Scale = struct { x: f32, y: f32 };

pub fn init() error{PlatformUnavailable}!void {
    const ret = glfw.init();
    if (ret == glfw.FALSE) {
        @branchHint(.cold);
        glfw.check() catch |err| switch (err) {
            error.PlatformUnavailable => return err,
            else => unreachable,
        };
    }
}

pub inline fn deinit() void {
    glfw.terminate();
}

pub const event = struct {
    pub inline fn poll() void {
        glfw.pollEvents();
    }

    pub inline fn wait() void {
        glfw.waitEvents();
    }

    pub inline fn waitTimeout(timeout: f64) void {
        glfw.waitEventsTimeout(timeout);
    }

    pub inline fn postEmpty() void {
        glfw.postEmptyEvent();
    }
};

pub inline fn setCilpboard(string: []const u8) void {
    glfw.setClipboardString(null, string);
}

pub fn getClipborad() error{FormatUnavailable}!?[]const u8 {
    const str = glfw.getClipboardString(null);
    if (str == null) {
        @branchHint(.cold);
        glfw.check() catch |err| switch (err) {
            error.FormatUnavailable,
            error.NotInitialized,
            error.PlatformError,
            => return err,
            else => unreachable,
        };
        return null;
    }
    return str[0..std.mem.len(str)];
}

pub inline fn getTime() f64 {
    return glfw.getTime();
}

pub fn setTime(time: f64) error{InvalidValue}!void {
    glfw.setTime(time);
    glfw.check() catch |err| switch (err) {
        error.InvalidValue => return err,
        else => unreachable,
    };
}

pub inline fn getTimerValue() u64 {
    return glfw.getTimerValue();
}

pub inline fn getTimerFrequency() u64 {
    return glfw.getTimerFrequency();
}

pub const Platform = enum(c_int) {
    win32 = glfw.PLATFORM_WIN32,
    cocoa = glfw.PLATFORM_COCOA,
    wayland = glfw.PLATFORM_WAYLAND,
    x11 = glfw.PLATFORM_X11,
    null = glfw.PLATFORM_NULL,
};

pub fn getPlatform() Platform {
    const p = glfw.getPlatform();
    if (p == 0) {
        glfw.check() catch unreachable;
        unreachable;
    }
    return @enumFromInt(p);
}

pub fn getPlatformSupport(platform: Platform) bool {
    return glfw.platformSupported(@intFromEnum(platform)) == glfw.TRUE;
}
