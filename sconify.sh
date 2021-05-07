#!/bin/bash

docker run -it --rm \
            -v /var/run/docker.sock:/var/run/docker.sock \
            registry.scontain.com:5050/sconecuratedimages/iexec-sconify-image:5.3.3-glibc sconify_iexec \
            --base="ubuntu:20.04" \
            --name=c_session_name \
            --from=registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-c-ubuntu \
            --to=hello-world-c-scone-glibc \
            --binary-fs \
            --fs-dir=/app \
            --binary="/app/hello-world" \
            --heap="64M" \
            --dlopen="2" \
            --no-color \
            --verbose \
            --command="/app/hello-world"