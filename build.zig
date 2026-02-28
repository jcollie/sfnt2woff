// SPDX-FileCopyrightText: © 2026 Jeffrey C. Ollie
// SPDX-License-Identifier: MIT

const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    {
        const sfnt2woff_exe = b.addExecutable(.{
            .name = "sfnt2woff",
            .root_module = b.createModule(.{
                .target = target,
                .optimize = optimize,
                .link_libc = true,
            }),
        });
        sfnt2woff_exe.root_module.addIncludePath(b.path("."));
        sfnt2woff_exe.root_module.addCSourceFiles(.{
            .root = b.path("."),
            .files = &.{
                "sfnt2woff.c",
                "woff.c",
            },
        });
        sfnt2woff_exe.root_module.linkSystemLibrary("z", .{});
        b.installArtifact(sfnt2woff_exe);
    }

    {
        const woff2sfnt_exe = b.addExecutable(.{
            .name = "woff2sfnt",
            .root_module = b.createModule(.{
                .target = target,
                .optimize = optimize,
                .link_libc = true,
            }),
        });
        woff2sfnt_exe.root_module.addIncludePath(b.path("."));
        woff2sfnt_exe.root_module.addCSourceFiles(.{
            .root = b.path("."),
            .files = &.{
                "woff2sfnt.c",
                "woff.c",
            },
        });
        woff2sfnt_exe.root_module.linkSystemLibrary("z", .{});
        b.installArtifact(woff2sfnt_exe);
    }

    {
        const woffmetadata_exe = b.addExecutable(.{
            .name = "woffmetadata",
            .root_module = b.createModule(.{
                .target = target,
                .optimize = optimize,
                .link_libc = true,
            }),
        });
        woffmetadata_exe.root_module.addIncludePath(b.path("."));
        woffmetadata_exe.root_module.addCSourceFiles(.{
            .root = b.path("."),
            .files = &.{
                "woffmetadata.c",
                "woff.c",
            },
        });
        woffmetadata_exe.root_module.linkSystemLibrary("z", .{});
        b.installArtifact(woffmetadata_exe);
    }
}
