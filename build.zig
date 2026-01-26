const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.createModule(.{
        .root_source_file = b.path("src/glfw_gen.zig"),
        .target = target,
        .optimize = optimize,
    });
    mod.addIncludePath(b.path("include/"));

    const gen = b.addExecutable(.{
        .name = "glfw_gen",
        .root_module = mod,
    });
    gen.linkLibC();

    const run_gen = b.addRunArtifact(gen);
    const step = b.step("run", "Generator GLFW Warpper");
    step.dependOn(&run_gen.step);

    const glfw = b.addModule("zglfw", .{
        .root_source_file = b.path("src/glfw.zig"),
        .target = target,
        .optimize = optimize,
    });
    glfw.addIncludePath(b.path("include/"));
}
