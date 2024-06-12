ARG DISTRO=alpine
ARG DISTRO_VARIANT=3.20

FROM docker.io/tiredofit/${DISTRO}:${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV CONTAINER_ENABLE_MESSAGING=FALSE

RUN source /assets/functions/00-container && \
    set -x && \
    addgroup -g 783 spamassassin && \
    adduser -S -D -G spamassassin -u 783 -h /var/lib/spamassassin/ spamassassin && \
    \
    package update && \
    package upgrade && \
    package install  .spamassassin-run-deps \
           razor \
           spamassassin=3.4.6-r4 \
           && \
   \
    mkdir -p /assets/spamassassin && \
    cp -R /etc/mail/spamassassin/* /assets/spamassassin && \
    \
    rm -rf /etc/mail/spamassassin \
           /var/lib/spamassassin

EXPOSE 783

COPY install /
