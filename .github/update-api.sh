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

rm -rf gmsh
