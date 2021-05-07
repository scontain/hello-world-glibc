#!/bin/bash
docker build -t registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-c-ubuntu .
docker push registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-c-ubuntu