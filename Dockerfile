FROM ubuntu:18.04 as build
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /quake3e

# Install prerequisites
RUN apt-get update
RUN apt-get install -y gcc git libc6-dev make pkg-config


# Get and build
RUN git clone https://github.com/ec-/Quake3e.git quake3e 
WORKDIR /quake3e/quake3e
RUN make "BUILD_CLIENT=0"

FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y moreutils sudo nano less screen

RUN adduser quake3esrv --disabled-password --disabled-login --group --system
RUN usermod -a -G sudo quake3esrv

COPY --chown=quake3esrv --from=build /quake3e/quake3e/build/release-linux-arm/quake3e.ded.arm /home/quake3esrv/quake3e/

USER quake3esrv

RUN mkdir -p ~/.q3a/baseq3

COPY scripts/start.sh /

EXPOSE 27960/udp
ENTRYPOINT ["/start.sh"]
