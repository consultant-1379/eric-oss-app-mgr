# OSS APP MGR

[TOC]

## Introduction

This repo contains the OSS Application Manager chart and its associated tests and CI. Please follow this documentation
for further details.

### Repo Structure

This is the directory structure of the repo. Below is a description of the contents of each of the upper level
directories.

```
oss-app-mgr/
├── bob
├── charts
│ └── eric-oss-app-mgr
│     ├── charts
│     └── templates
├── ci
│ ├── jenkinsfiles
│ ├── rulesets
│ └── scripts
├── dev
├── docs
└── testsuite
├── helm-chart-validator
│ └── src
└── schematests
  └── tests
     ├── negative
     └── positive
```

#### Bob

This is a submodule and contains the latest ADP BOB tool used to power the CI automation See
the [ADP BOB Documentation](https://gerrit.ericsson.se/plugins/gitiles/adp-cicd/bob).

#### Charts

This directory contains the OSS APP MGR Integration Chart. See the [OSS APP MGR Docs](docs/oss_app_mgr_chart.md)
for more details

#### CI

This directory contains the jenkinsfiles and bob rulesets used to run the CI automation for this repository.

#### Dev

This directory contains useful utility scripts for developers when contributing to this repo. See
the [OSS APP MGR Dev Docs](docs/dev/developer_guide.md)
for more details.

#### Docs

This directory contains all the documentation describing this repository.

#### Testsuite

This directory contains the tests created for the OSS APP MGR See
the [OSS APP MGR Testsuite Docs](docs/testsuite/test_overview.md)
for more details.

## Release Notes

## Community

### Key people of the project

- PO: Andres Leal <Andres.Leal@ericsson.com>
- Guardians:
    - Team Outcast

### Contact

- PDLOUTCAST@pdl.internal.ericsson.com

### Contributing

We're an inner source project and welcome contributions. See our [Contribution Guide](CONTRIBUTION_GUIDE.md) for more
details.


