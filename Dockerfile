FROM tiredofit/alpine:3.11-latest
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Disable Features From Base Image
ENV ENABLE_SMTP=false

### Create User
RUN set -x && \
   addgroup -g 737 spamassassin && \
   adduser -S -D -G spamassassin -u 737 -h /var/lib/spamassassin/ spamassassin && \
   \
### Install Dependencies
   apk update && \
   apk add --no-cache \
           razor \
           spamassassin \
           && \
   \
### Cleanup
   rm -rf /var/cache/apk/*

### Networking Configuration
EXPOSE 737

### Add Files
ADD install /
