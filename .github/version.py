#!/usr/bin/env python3

import fileinput
import os

# Get the version from the fpm.toml
version_fpm = ""
version_api = ""
dir_path = os.path.dirname(os.path.realpath(__file__))

# Get the version from the API version, this version can be different from the
# latest tag version, since Gmsh dev cycle tends to increment the version number
# first and release the tag later once done.
with open(os.path.join(dir_path, "..", "src", "gmsh.f90"), "r") as f:
    for line in f:
        if "public :: GMSH_API_VERSION =" in line:
            version_api = line.split("GMSH_API_VERSION =")[1].strip().strip('"')
            break

# Get the version from the fpm.toml
with open(os.path.join(dir_path, "version.txt"), "r") as f:
    version_fpm = f.readlines()[0]


if version_fpm != version_api:
    print(version_api)
else:
    print("version is up to date!")
