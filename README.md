# zglfw

zglfw is a Zig-style wrapper for the GLFW library, offering Zig-idiomatic API naming and integrating Zig’s error handling mechanism.

## Usage

In your project directory, run the following command to add zglfw as a dependency:

```text
zig fetch [lib-url] --save
```

Available URLs include:

- [https://codeberg.org/Anglebase/zglfw/archive/v0.1.0.tar.gz](https://codeberg.org/Anglebase/zglfw/archive/v0.1.0.tar.gz)
- [https://codeberg.org/Anglebase/zglfw/archive/v0.1.0.zip](https://codeberg.org/Anglebase/zglfw/archive/v0.1.0.zip)

as well as other possible mirror URLs.

Then, include the dependency in your build script:

```zig
const zglfw = b.dependency("zglfw");
```

The package exposes a module named `zglfw`, which exports all GLFW APIs. You can import it into your own module as follows:

```zig
const mod = b.addModule("...", .{
    ...
    .imports = &.{
        .{ .name = "zglfw", .module = zglfw.module("zglfw") },
    },
});
```

After importing, you can use it like any regular module. Here’s a simple GLFW example:

```zig
const glfw = @import("zglfw");

pub fn main() !void {
    _ = glfw.init();
    glfw.windowHint(glfw.CONTEXT_VERSION_MAJOR, 3);
    glfw.windowHint(glfw.CONTEXT_VERSION_MINOR, 3);
    glfw.windowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE);

    const window = glfw.createWindow(
        800,
        600,
        "zGLFW",
        null,
        null,
    );
    glfw.makeContextCurrent(window);

    while (glfw.windowShouldClose(window) == 0) {
        glfw.swapBuffers(window);
        glfw.pollEvents();
    }

    glfw.terminate();
}
```

zglfw does not include the actual GLFW function implementations; it only provides the interface to interact with GLFW3. Therefore, you still need to download the corresponding version of the GLFW library (GLFW3) from the [GLFW official website](https://www.glfw.org/download.html) or elsewhere, and link it to your project:

```zig
const exe = b.addExecutable(...);
exe.addLibraryPath(b.path("path/to/glfw3dir"));
exe.linkSystemLibrary("glfw3");
```

If you have questions or suggestions, feel free to open an Issue in the project repository.
