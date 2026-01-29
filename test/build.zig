const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // 3rd-party
    const zglfw = b.dependency("zglfw", .{});
    const glfw_zig = b.dependency("glfw_zig", .{});

    // window.zig
    const exe_window = b.addExecutable(.{
        .name = "window",
        .root_module = b.createModule(.{
            .root_source_file = b.path("bin/window.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "zglfw", .module = zglfw.module("zglfw") },
            },
        }),
    });
    exe_window.linkLibC();
    exe_window.linkLibrary(glfw_zig.artifact("glfw"));
    b.installArtifact(exe_window);

    const step_window = b.step("window", "Run test file: window.zig");
    const run_window = b.addRunArtifact(exe_window);
    step_window.dependOn(&run_window.step);
    run_window.step.dependOn(b.getInstallStep());

    // full_screen.zig
    const exe_full_screen = b.addExecutable(.{
        .name = "full_screen",
        .root_module = b.createModule(.{
            .root_source_file = b.path("bin/full_screen.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "zglfw", .module = zglfw.module("zglfw") },
            },
        }),
    });
    exe_full_screen.linkLibC();
    exe_full_screen.linkLibrary(glfw_zig.artifact("glfw"));
    b.installArtifact(exe_full_screen);

    const step_full_screen = b.step("full_screen", "Run test file: full_screen.zig");
    const run_full_screen = b.addRunArtifact(exe_full_screen);
    step_full_screen.dependOn(&run_full_screen.step);
    run_full_screen.step.dependOn(b.getInstallStep());

    // custom_allocator.zig
    const exe_custom_allocator = b.addExecutable(.{
        .name = "custom_allocator",
        .root_module = b.createModule(.{
            .root_source_file = b.path("bin/custom_allocator.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "zglfw", .module = zglfw.module("zglfw") },
            },
        }),
    });
    exe_custom_allocator.linkLibC();
    exe_custom_allocator.linkLibrary(glfw_zig.artifact("glfw"));
    b.installArtifact(exe_custom_allocator);

    const step_custom_allocator = b.step("custom_allocator", "Run test file: custom_allocator.zig");
    const run_custom_allocator = b.addRunArtifact(exe_custom_allocator);
    step_custom_allocator.dependOn(&run_custom_allocator.step);
    run_custom_allocator.step.dependOn(b.getInstallStep());
}
