<!-- markdownlint-disable MD003 MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2024-05-13

### Changed

- Updated image to Ubuntu 24.04
- Updated references to `1000`, `vscode` user is now `1001`

## [1.0.0] - 2024-04-16

### Changed

- Updated Dockerfile syntax

- Switch to using snippets instead of inline HereDoc

## [0.0.6] - 2024-04-08

### Changed

- Switch to `uname --machine`

## [0.0.5] - 2024-02-13

### Added

- Automatically source `.sh` files in `/home/vscode/.dotfiles`

## [0.0.4] - 2024-02-08

### Changed

- Ensure Python Pip installed and up-to-date

## [0.0.3] - 2024-02-01

### Added

- Checkov skips for `CKV_DOCKER_2` and `CKV_DOCKER_3`

## [0.0.2] - 2024-01-31

### Changed

- Updated workflows

## [0.0.1] - 2024-01-25

### Added

- Initial release of image
