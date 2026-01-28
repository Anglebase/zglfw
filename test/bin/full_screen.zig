const glfw = @import("zglfw");
const std = @import("std");

pub fn main() !void {
    try glfw.init(null, .{});
    defer glfw.deinit();

    var m = glfw.Monitor.getPrimaryMonitor().?;
    const name = m.getName();
    std.debug.print("{s}", .{name});

    const r = m.getWorkarea();

    var window = try glfw.Window.create(
        r.width,
        r.height,
        "zglfw",
        .{
            .context_version_major = 3,
            .context_version_minor = 3,
            .opengl_profile = .core,
            .monitor = m,
        },
    );
    defer window.destroy();

    window.makeContextCurrent();

    while (!window.shouldClose()) {
        window.swapBuffer();
        glfw.event.poll();
    }
}
