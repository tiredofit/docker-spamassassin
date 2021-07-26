FROM tiredofit/alpine:3.14
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

### Disable Features From Base Image
ENV ENABLE_SMTP=false

### Create User
RUN set -x && \
    addgroup -g 783 spamassassin && \
    adduser -S -D -G spamassassin -u 783 -h /var/lib/spamassassin/ spamassassin && \
    \
### Install Dependencies
    apk update && \
    apk upgrade && \
    apk add -t .spamassassin-run-deps \
           razor \
           spamassassin \
           && \
   \
    mkdir -p /assets/spamassassin && \
    cp -R /etc/mail/spamassassin/* /assets/spamassassin && \
    \
### Cleanup
    rm -rf /etc/mail/spamassassin && \
    rm -rf /var/lib/spamassassin && \
    rm -rf /var/cache/apk/*

### Networking Configuration
EXPOSE 783

### Add Files
ADD install /
