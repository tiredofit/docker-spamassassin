FROM tiredofit/alpine:3.6
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Disable Features From Base Image
   ENV ENABLE_SMTP=false

### Create User
   RUN addgroup spamassassin && \
       adduser -S \
               -D -G spamassassin \
               -h /var/lib/spamassassin/ \
           spamassassin && \

### Install Dependencies
       apk update && \
       apk add --no-cache \
               razor \
               spamassassin \
               && \

### Cleanup
       rm -rf /var/cache/apk/*

### Add Files
   ADD install /

### Networking Configuration
   EXPOSE 783
