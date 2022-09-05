import fileinput
import os
import sys

# Get the version from the fpm.toml
version_fpm = ""
version_api = ""
dir_path = os.path.dirname(os.path.realpath(__file__))

# Get the version from the API version
with open(os.path.join(dir_path, "src", "gmsh.f90"), "r") as f:
    for line in f:
        if "public :: GMSH_API_VERSION =" in line:
            version_api = line.split("GMSH_API_VERSION =")[1].strip().strip('"')
            break

# Get the version from the fpm.toml
with fileinput.input(os.path.join(dir_path, "fpm.toml"), inplace=True) as f:
    for line in f:
        if line.startswith("version = "):
            version_fpm = line.split("=")[1].strip().strip('"')
            # If the version is out of date, update it
            if version_fpm != version_api:
                new_line = line.replace(version_fpm, version_api)
                print(new_line, end="")
            else:
                print(line, end="")
        else:
            print(line, end="")

if version_fpm != version_api:
    print("A new Gmsh version is available! Create a new release!")
    print("fpm version: ", version_fpm)
    print("remote version: ", version_api)
    os.environ["GMSH_API_VERSION"] = version_api
    sys.exit(1)
else:
    print("fpm version: ", version_fpm)
    print("Gmsh fpm API is up to date!")
    sys.exit(0)
