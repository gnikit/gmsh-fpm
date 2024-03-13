#!/usr/bin/env bash

set -e
set -x

git clone https://gitlab.onelab.info/gmsh/gmsh.git gmsh

# Copy Fortran API
cp gmsh/api/gmsh.f90 src/gmsh.f90
# # Copy C API
# cp gmsh/api/gmshc.h src/gmshc.h

# Copy the Fortran tutorials
cp -rf gmsh/tutorials/fortran/* example/fortran/
cp -rf gmsh/tutorials/*.{png,pos,step,stl} example/

# Copy main files
cp -f gmsh/CHANGELOG.txt .
cp -f gmsh/CREDITS.txt .
cp -f gmsh/LICENSE.txt .

# Store the latest released tag, used for automatic releases of this package
# The Gmsh tag format is "gmsh_major_minor_patch"
pushd gmsh
git describe --tags `git rev-list --tags --max-count=1` > ../.github/latest_tag.txt
popd

rm -rf gmsh
