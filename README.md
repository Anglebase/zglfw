# zglfw

zglfw is a Zig-style wrapper for the GLFW library, offering Zig-idiomatic API naming and integrating Zig’s error handling mechanism.

## Usage

In your project directory, run the following command to add zglfw as a dependency:

```text
zig fetch [lib-url] --save
```

Available URLs include:

- [https://codeberg.org/Anglebase/zglfw/archive/v0.1.1.tar.gz](https://codeberg.org/Anglebase/zglfw/archive/v0.1.1.tar.gz)
- [https://codeberg.org/Anglebase/zglfw/archive/v0.1.1.zip](https://codeberg.org/Anglebase/zglfw/archive/v0.1.1.zip)

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

## Using with glfw.zig

[glfw.zig](https://github.com/tiawl/glfw.zig) is a GLFW version built with the Zig build system, making it easier to integrate with Zig's build system.
You can add it to your project with the following command:

```text
zig fetch [url] --save
```

Available URLs include:

- [https://github.com/tiawl/glfw.zig/archive/refs/tags/X11.zig-libXrandr-1.5.5.zip](https://github.com/tiawl/glfw.zig/archive/refs/tags/X11.zig-libXrandr-1.5.5.zip)
- [https://github.com/tiawl/glfw.zig/archive/refs/tags/X11.zig-libXrandr-1.5.5.tar.gz](https://github.com/tiawl/glfw.zig/archive/refs/tags/X11.zig-libXrandr-1.5.5.tar.gz)

as well as other possible mirror URLs. Since glfw.zig closely follows the latest GLFW releases, the URLs here may not be the most recent. You can find the latest glfw.zig URLs on the [glfw.zig tags page](https://github.com/tiawl/glfw.zig/tags).

glfw.zig exports a binary library artifact named `glfw` that can be linked into your project's executable. You can link it into your project as follows:

```zig
const exe = b.addExecutable(.{
    ...
});

const glfw_zig = b.dependency("glfw_zig", .{});
exe.linkLibrary(glfw_zig.artifact("glfw"));
```

If you have questions or suggestions, feel free to open an Issue in the project repository.
