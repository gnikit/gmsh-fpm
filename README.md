# gmsh-fpm

Adds the [Gmsh](https://gmsh.info/) finite element mesh generator library to the
[Fortran Package Manager (fpm)](https://fpm.fortran-lang.org/en/index.html).

## Features

The repository provides:

- Access to the Fortran F2018 API of Gmsh
- Examples of how to use the Fortran API
- A Fortran compiled executable for Gmsh itself

## Usage

To build Gmsh executable and all the examples, run:

```bash
fpm build --link-flag "-L/path/to/gmsh/lib"
```

or by setting the `FPM_LDFLAGS=-L/path/to/gmsh-sdk/lib` environment variable.

To run any of the examples or the Gmsh executable itself, you need to add the `lib`
directory to the `LD_LIBRARY_PATH`

```bash
export LD_LIBRARY_PATH=/path/to/gmsh/lib:$LD_LIBRARY_PATH
fpm run --link-flag "-L/path/to/gmsh/lib"
```

### Note 📝️

For `gfortran` you can remove explicitly having to link to `libgmsh` by adding
the `lib` directory into your `LIBRARY_PATH` environment variable for `gfortran`
to search before compiling e,g.

```bash
export LIBRARY_PATH=/path/to/gmsh-sdk/lib:$LIBRARY_PATH
fpm build
```

## Requirements

- `libgmsh.so` or `libgmsh.a`, see [Installing Gmsh](#installing-gmsh)
- A Fortran compiler with F2018 support, [Compiler](#compiler) section

### Installing Gmsh

This `fpm` package requires `libgmsh` to be already installed on your system.
There are 3 ways in which you can get `libgmsh`:

#### 1. Download the Software Development Kit (SDK)

The Gmsh SDK is available for download on the [Gmsh website](https://gmsh.info/#Download).
Once downloaded and unzipped, simply include the path to the `lib` directory in
your `fpm` command, e.g.:

```bash
fpm run --link-flag "-L/path/to/gmsh-sdk/lib"
```

#### 2. Compile from source

Download the latest source code from the [Gmsh website](https://gmsh.info/#Download)
and unzip it. Then follow the instructions in the `INSTALL` file to compile Gmsh

```bash
cmake -B build -DENABLE_BUILD_DYNAMIC=1 -DCMAKE_INSTALL_PREFIX=/path/to/gmsh-inst
cmake --build build --parallel 16
cmake --install build --config Release
```

#### 3. Compile from git

```bash
git clone https://gitlab.onelab.info/gmsh/gmsh.git
cd gmsh
cmake -B build -DENABLE_BUILD_DYNAMIC=1 -DCMAKE_INSTALL_PREFIX=/path/to/gmsh-inst
cmake --build build --parallel 16
cmake --install build --config Release
```

| 📝️ Note | You might need to install [FLTK](https://github.com/fltk/fltk) and [OpenCASCADE](https://dev.opencascade.org/release) to get the full functionality of the library. |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

### Compiler

The API uses `optional` arguments in C interoperable procedures, a feature available
in the F2018 standard. The following Fortran compilers are known to work:

| Vendor                                                                                        | Compiler       |
| --------------------------------------------------------------------------------------------- | -------------- |
| [GNU](https://gcc.gnu.org/wiki/GFortran)                                                      | `gfortran`     |
| [Intel](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html) | `ifort`, `ifx` |
| [NAG](https://www.nag.com/)                                                                   | `nagfor`       |
