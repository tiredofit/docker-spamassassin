# github.com/tiredofit/docker-spamassassin

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-spamassassin?style=flat-square)](https://github.com/tiredofit/docker-spamassassin/releases/latest)
[![Build Status](https://img.shields.io/github/actions/workflow/status/tiredofit/docker-spamassassin/main.yml?branch=main&style=flat-square)](https://github.com/tiredofit/docker-spamassassin/actions)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/spamassassin.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/spamassassin/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/spamassassin.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/spamassassin/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)


## About

This will build a Docker Image for [Spamassassin](https://spamassassin.apache.org) - A message content scanner for spam.
## Maintainer

- [Dave Conroy](https://github.com/tiredofit/)

## Table of Contents

- [Introduction](#introduction)
    - [Changelog](CHANGELOG.md)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Data Volumes](#data-volumes)
    - [Environment Variables](#environmentvariables)
- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
   - [References](#references)

## Prerequisites and Assumptions

- This image doesn't do much on it's own, you must use a complemenary service to pass messages or data to it via port 783.

## Installation
### Build from Source
Clone this repository and build the image with `docker build -t (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/spamassassin) and is the recommended method of installation.

```bash
docker pull tiredofit/spamassassin:(imagetag)
```
The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Container OS | Tag       |
| ------------ | --------- |
| Alpine       | `:latest` |

#### Multi Architecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`

## Configuration

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory  | Description                         |
| ---------- | ----------------------------------- |
| `/logs/`   | Spamassassin Logs                   |
| `/config/` | Configuration                       |
| `/data/`   | Volatile Data (Downloaded Patterns) |

* * *
### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`,`vim`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/) | Customized Image based on Alpine Linux |

| Parameter               | Description                             | Default                  |
| ----------------------- | --------------------------------------- | ------------------------ |
| `CHILD_MAX`             | Max Children                            | `5`                      |
| `CHILD_MAX_CONNECTIONS` | Max connections per child               | `200`                    |
| `CHILD_MAX_SPARE`       | Max Spare Children                      | `2`                      |
| `CHILD_MIN`             | Minimum Child Process                   | `1`                      |
| `CHILD_MIN_SPARE`       | Minimum Spare Children                  | `1`                      |
| `CONFIG_PATH`           | Config directory                        | `/config/`               |
| `DATA_PATH`             | Updates / Rulesets directory            | `/data/`                 |
| `ENABLE_LEARNING`       | Enable Learning/Reporting               | `TRUE`                   |
| `ENABLE_ROUND_ROBIN`    | Enable Roundrobin Forking for childs    | `FALSE`                  |
| `ENABLE_UPDATES`        | Enable Ruleset Updates                  | `TRUE`                   |
| `LISTEN_PORT`           | TCP Listen Port                         | `783`                    |
| `LOG_FILE`              | Log File                                | `spamassassin.log`       |
| `LOG_PATH`              | Log Logcation                           | `/logs/`                 |
| `PID_FILE`              | PID File                                | `spamassassin.pid`       |
| `PID_PATH`              | PID Path                                | `/var/run/spamassassin/` |
| `TIMEOUT_CHILD`         | Child Timeout in Seconds                | `300`                    |
| `TIMEOUT_IDENT`         | Ident Timeout in Seconds                | `5`                      |
| `TIMEOUT_TCP`           | TCP Timeout in Seconds                  | `30`                     |
| `UPDATE_PERIOD`         | Cron Expression when to perform updates | `15 23 * * *`            |

### Networking

| Port  | Description                 |
| ----- | --------------------------- |
| `783` | Spamassassin Listening Port |

## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is) bash
```

## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) personalized support.
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.

## References

* https://spamassassin.apache.org
