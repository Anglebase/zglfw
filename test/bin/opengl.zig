const glfw = @import("zglfw");
const std = @import("std");
const gl = @import("zgl");

fn framesize(width: i32, height: i32) void {
    gl.viewport(0, 0, @intCast(width), @intCast(height));
}

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
    try gl.loadGL(glfw.getProcAddress);

    window.enable_callback();
    window.when.frame_buffer_size = &framesize;
    gl.viewport(0, 0, 800, 600);
    while (!window.shouldClose()) {
        gl.clearColor(0.3, 0.4, 0.5, 1.0);
        gl.clear(gl.COLOR_BUFFER_BIT);
        window.swapBuffer();
        glfw.event.poll();
    }
}
