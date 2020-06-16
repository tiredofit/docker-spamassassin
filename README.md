# hub.docker.com/r/tiredofit/spamassassin

[![Build Status](https://img.shields.io/docker/build/tiredofit/spamassassin.svg)](https://hub.docker.com/r/tiredofit/spamassassin)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/spamassassin.svg)](https://hub.docker.com/r/tiredofit/spamassassin)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/spamassassin.svg)](https://hub.docker.com/r/tiredofit/spamassassin)
[![Docker Layers](https://images.microbadger.com/badges/image/tiredofit/spamassassin.svg)](https://microbadger.com/images/tiredofit/spamassassin)


# Introduction

Dockerfile to build an [Spamassassin](https://spamassassin.apache.org) container image to scan mail messages for Spam.

* This Container uses a [customized Alpine Linux base](https://hub.docker.com/r/tiredofit/alpine) which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, nano, vim) for easier management. It also supports sending to external SMTP servers..


[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](https://github.com/tiredofit/)

# Table of Contents

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

# Prerequisites

This image doesn't do much on it's own, you must use a complemenary service to pass messages or data to it via port 783.


# Installation

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/spamassassin) and is the recommended method of installation.


```bash
docker pull tiredofit/spamassassin:(imagetag)
```

The following image tags are available:
* `latest` - Most recent release of Spamassassin w/ Alpine Linux

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

Upon starting the image will check for new/updated patterns and will download if none exist. Patterns are updated daily at 23h15 automatically.

# Configuration

### Data-Volumes

The following directories are used for configuration and can be mapped for persistent storage.

| Directory | Description |
|-----------|-------------|
| `/logs/` | Spamassassin Logs |
| `/config/` | Configuration |
| `/data/` | Volatile Data (Downloaded Patterns)
    
### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine),below is the complete list of available options that can be used to customize your installation.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `CHILD_MAX` | Max Children | `5` |
| `CHILD_MAX_CONNECTIONS` | Max connections per child | `200` |
| `CHILD_MAX_SPARE` | Max Spare Children | `2` |
| `CHILD_MIN` | Minimum Child Process | `1` |
| `CHILD_MIN_SPARE` | Minimum Spare Children | `1` |
| `CONFIG_PATH` | Config directory | `/config/` |
| `DATA_PATH` | Updates / Rulesets directory | `/data/` |
| `ENABLE_LEARNING` | Enable Learning/Reporting | `TRUE` |
| `ENABLE_ROUND_ROBIN` | Enable Roundrobin Forking for childs | `FALSE` |
| `ENABLE_UPDATES` | Enable Ruleset Updates | `TRUE` |
| `LISTEN_PORT` | TCP Listen Port | `783` |
| `LOG_FILE` | Log File | `spamassassin.log` |
| `LOG_PATH` | Log Logcation | `/logs/` |
| `PID_FILE` | PID File |`spamassassin.pid` |
| `PID_PATH` | PID Path | `/var/run/spamassassin/` |
| `TIMEOUT_CHILD` | Child Timeout in Seconds | `300` |
| `TIMEOUT_IDENT` | Ident Timeout in Seconds | `5` |
| `TIMEOUT_TCP` | TCP Timeout in Seconds | `30` |
| `UPDATE_PERIOD` | Cron Expression when to perform updates | `15 23 * * *` |

### Networking

| Port | Description |
|-----------|-------------|
| `783` | Spamassassin Listening Port |

# Maintenance

#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it (whatever your container name is e.g. spamassassin) bash
```

# References

* https://spamassassin.apache.org
