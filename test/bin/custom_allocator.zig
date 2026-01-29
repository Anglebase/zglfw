const glfw = @import("zglfw");
const std = @import("std");

pub fn main() !void {
    var allocator = std.heap.DebugAllocator(.{}){};
    defer _ = allocator.deinit();
    try glfw.init(allocator.allocator(), .{});
    defer glfw.deinit();

    var window = try glfw.Window.create(
        800,
        600,
        "zglfw",
        .{
            .context_version_major = 3,
            .context_version_minor = 3,
            .opengl_profile = .core,
        },
    );
    defer window.destroy();

    window.makeContextCurrent();

    while (!window.shouldClose()) {
        window.swapBuffer();
        glfw.event.poll();
    }
}
