const std = @import("std");

pub fn build(b: *std.Build) !void {
    const allocator = std.heap.smp_allocator;
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const zglfw = b.dependency("zglfw", .{});
    const glfw_zig = b.dependency("glfw_zig", .{});

    const names = [_][]const u8{
        "window",
    };
    for (names) |name| {
        const exe = b.addExecutable(.{
            .name = name,
            .root_module = b.createModule(.{
                .root_source_file = b.path(try std.fmt.allocPrint(
                    allocator,
                    "bin/{s}.zig",
                    .{name},
                )),
                .target = target,
                .optimize = optimize,
                .imports = &.{
                    .{ .name = "zglfw", .module = zglfw.module("zglfw") },
                },
            }),
        });
        exe.linkLibC();
        exe.linkLibrary(glfw_zig.artifact("glfw"));
        b.installArtifact(exe);

        const step = b.step(name, try std.fmt.allocPrint(
            allocator,
            "Run test file: {s}.zig",
            .{name},
        ));
        const run = b.addRunArtifact(exe);
        step.dependOn(&run.step);
        run.step.dependOn(b.getInstallStep());
    }
}
