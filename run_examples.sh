#!/usr/bin/env bash

set -e

if [[ -z "${FPM_LDFLAGS}" ]]; then
    LIB_GMSH=$(pwd)/sdk/lib
    export FPM_LDFLAGS="-L$LIB_GMSH -Wl,-rpath,$LIB_GMSH"
    echo "FPM_LDFLAGS not externally set, using default: ${FPM_LDFLAGS}"
else
    export FPM_LDFLAGS="${FPM_LDFLAGS}"
    echo "FPM_LDFLAGS is externally set: ${FPM_LDFLAGS}"
fi

# for loop for examples from 1..21
for EXAMPLE in $(seq 1 21); do
    EXAMPLE="t${EXAMPLE}"
    fpm run --profile debug --example ${EXAMPLE} --runner \
        cp -- example/fortran/
    pushd example/fortran/
    ./${EXAMPLE} -nopopup || {
        rm ${EXAMPLE}
        echo "FAILED: Tutorial ${EXAMPLE} exited unexpectedly."
        exit 1
    }
    rm ${EXAMPLE}
    popd
done
