const glfw = @import("zglfw");

pub fn main() !void {
    try glfw.init();
    defer glfw.deinit();

    var window = try glfw.Window.create(
        800,
        600,
        "GLFW for zege",
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
