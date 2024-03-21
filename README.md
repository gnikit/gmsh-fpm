# gmsh-fpm

![GitHub Release](https://img.shields.io/github/v/release/gnikit/gmsh-fpm?logo=github&label=Release)
[![Examples](https://github.com/gnikit/gmsh-fpm/actions/workflows/examples.yml/badge.svg)](https://github.com/gnikit/gmsh-fpm/actions/workflows/examples.yml)
[![Update API](https://github.com/gnikit/gmsh-fpm/actions/workflows/main.yml/badge.svg)](https://github.com/gnikit/gmsh-fpm/actions/workflows/main.yml)

Adds the [Gmsh](https://gmsh.info/) finite element mesh generator library to the
[Fortran Package Manager (fpm)](https://fpm.fortran-lang.org/en/index.html).

> This repository automatically downloads the Gmsh API every hour from the upstream repo
> <https://gitlab.onelab.info/gmsh/gmsh.git>.
> Releases are automatically authored based on the upstream repository.

## Features

The repository provides:

- Access to the Fortran F2018 API of Gmsh
- Examples of how to use the Fortran API
- A Fortran compiled executable for Gmsh itself

## Usage

To use `gmsh-fpm` within your fpm project, add the following to your `fpm.toml` file:

Pin to a specific version **(Recommended)**:

```toml
[dependencies]
gmsh = { git="https://github.com/gnikit/gmsh-fpm.git", tag = "4.12.2" }
```

or live at head:

```toml
[dependencies]
gmsh = { git="https://github.com/gnikit/gmsh-fpm.git" }
```

## Build

To build the `gmsh` executable and all the examples, run:

```bash
fpm build --link-flag "-L/path/to/gmsh/lib"
```

or by setting the `FPM_LDFLAGS=-L/path/to/gmsh-sdk/lib` environment variable.

To run any of the examples or the Gmsh executable itself, you need to add the `lib`
directory to the `LD_LIBRARY_PATH`.
You can do that only for `fpm` via:

<!-- ```bash
export LD_LIBRARY_PATH=/path/to/gmsh/lib:$LD_LIBRARY_PATH
fpm run --link-flag "-L/path/to/gmsh/lib"
```

or in a more compact manner -->

```bash
export FPM_LDFLAGS="-L/path/to/gmsh/lib -Wl,-rpath,/path/to/gmsh/lib"
fpm run
```

### Running the examples

With `FPM_LDFLAGS` defined as above, normally one can run the examples in the usual way:

```bash
fpm run --example t1
```

If the example requires input files, one will need to change to the
example directory and run the executable from there:

```bash
fpm run --example t13 --runner cp -- example/fortran/; pushd example/fortran/; ./t13; rm t13; popd
```

For the fpm feature request that would simplify the above command see Issue
[#410](https://github.com/fortran-lang/fpm/issues/410).

## Requirements

- `libgmsh.so` or `libgmsh.a`, see [Installing Gmsh](#installing-gmsh)
- A Fortran compiler with F2018 support, [Compiler](#compiler) section

### Installing Gmsh

This `fpm` package requires `libgmsh` to be already installed on your system.
You can download relevant Software Development Kit (SDK) from the [Gmsh website](https://gmsh.info/#Download).

| ❗ Important | Download the same Gmsh SDK version as the one used in `gmsh-fpm` |
| ------------ | ---------------------------------------------------------------- |

For building Gmsh from source, instead of downloading an SDK, checkout the Gmsh
[repository](https://gitlab.onelab.info/gmsh/gmsh) or
[source distributions](https://gmsh.info/src/) and follow the relevant instructions.

<!--
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

-->

### Compiler

The API uses `optional` arguments in C interoperable procedures, a feature available
in the F2018 standard. The following Fortran compilers are known to work:

| Vendor                                                                                        | Compiler       |
| --------------------------------------------------------------------------------------------- | -------------- |
| [GNU](https://gcc.gnu.org/wiki/GFortran)                                                      | `gfortran`     |
| [Intel](https://www.intel.com/content/www/us/en/developer/tools/oneapi/fortran-compiler.html) | `ifort`, `ifx` |
| [NAG](https://www.nag.com/)                                                                   | `nagfor`       |
