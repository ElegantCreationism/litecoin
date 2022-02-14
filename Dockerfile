# STAGE 1
FROM debian:stable-slim as stage-one

ENV LITECOIN_VERSION=0.18.1

RUN apt-get update -y \
  	&& apt-get install -y curl gnupg ca-certificates \
  	&& set -ex \
    && for key in \
      B42F6819007F00F88E364FD4036A9C25BF357DD4 \
      FE3348877809386C \
    ; do \
      gpg --no-tty --keyserver pgp.mit.edu --recv-keys "$key" || \
      gpg --no-tty --keyserver keyserver.pgp.com --recv-keys "$key" || \
      gpg --no-tty --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
      gpg --no-tty --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
    done

RUN curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz \
	&& curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
  	&& gpg --verify litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
  	&& grep $(sha256sum litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz | awk '{ print $1 }') litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
    && mkdir -p /home/litecoin \
  	&& tar --strip=2 -xzf *.tar.gz -C /home/litecoin


# STAGE 2
FROM ubuntu:20.04

ENV LITECOIN_DATA=/home/litecoin/.litecoin

RUN apt update -y

COPY --from=stage-one /home/litecoin /usr/local/bin

VOLUME ["/home/litecoin/.litecoin"]

CMD ["litecoind"]
