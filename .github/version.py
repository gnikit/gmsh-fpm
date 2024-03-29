#!/usr/bin/env python3

from pathlib import Path

version_fpm = ""
version_tag = ""
dir_path = Path(__file__).resolve().parent


# Get the version from the fpm.toml
with open(dir_path.parent / "version.txt", encoding="utf-8") as f:
    version_fpm = f.readlines()[0]

# Get the version from the latest release, we cannot use the version stated
# in the API because the development cycle of Gmsh tends to first increment the
# version internally and then create a tag, which would cause our releases
# to contain the wrong API files for the corresponding tag.
with open(dir_path / "latest_tag.txt", encoding="utf-8") as f:
    version_tag = f.readlines()[0].strip()
    # The Gmsh tag format is "gmsh_major_minor_patch"
    version_tag = ".".join(version_tag.split("_")[1:])

if version_fpm != version_tag:
    # udpate the version.txt file
    with open(dir_path.parent / "version.txt", "w", encoding="utf-8") as f:
        f.write(version_tag)
    print(version_tag)
else:
    print("version is up to date!")
