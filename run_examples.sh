#!/usr/bin/env bash

set -e

SDK_LIB=$(pwd)/sdk/lib
export FPM_LDFLAGS="-L$SDK_LIB -Wl,-rpath,$SDK_LIB"

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
