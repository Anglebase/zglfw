# zglfw

zglfw is a [GLFW](https://www.glfw.org/) wrapper written in Zig, providing a GLFW encapsulation with Zig coding style. This library does not include the platform-specific APIs from GLFW (glfw3native.h) and support for Vulkan. These may be added in the future.

## Usage

In your project directory, run the following command to add zglfw as a dependency:

```text
zig fetch [lib-url] --save
```

You can obtain a valid `lib-url` from the [Releases page](https://codeberg.org/Anglebase/zglfw/releases), or use any available mirror URL.

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

zglfw does not assume how you link GLFW, you can freely choose static linking or dynamic linking. zglfw itself does not include the implementation of the GLFW library. You can download the GLFW runtime from the [GLFW official download page](https://www.glfw.org/download.html) or elsewhere, and link them into your project:

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

You can obtain a valid `url` from the [Releases page](https://github.com/tiawl/glfw.zig/tags) of glfw.zig, or use other possible mirror URLs.

glfw.zig exports a binary library artifact named `glfw` that can be linked into your project's executable. You can link it into your project as follows:

```zig
const exe = b.addExecutable(.{
    ...
});

const glfw_zig = b.dependency("glfw_zig", .{});
exe.linkLibrary(glfw_zig.artifact("glfw"));
```

If you have questions or suggestions, feel free to open an Issue in the project repository.
