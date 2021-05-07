FROM ubuntu:20.04

WORKDIR /app
COPY ./hello-world.c .

RUN apt-get update && apt-get install -y build-essential && \
    cc -pie -o hello-world hello-world.c

CMD [ "/app/hello-world" ]
