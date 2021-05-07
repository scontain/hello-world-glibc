#!/bin/bash
set -e
source sgx_device.sh

echo "Start sconification..."
# we ues && to ensure that all commands finish before run next one
determine_sgx_device &&\
echo "Run sconified image..." && \
docker run -it --rm --network=host $MOUNT_SGXDEVICE \
-eSCONE_VERSION=1 \
-eSCONE_MODE=hw \
-eSCONE_LOG="WARNINGS" \
-ePATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
hello-world-c-scone-glibc /app/hello-world
