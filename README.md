[![marketplace](https://img.shields.io/badge/marketplace-grcov--express-blue?logo=github)](https://github.com/marketplace/actions/grcov-express)
[![CI](https://github.com/lpenz/ghaction-grcov-express/actions/workflows/ci.yml/badge.svg)](https://github.com/lpenz/ghaction-grcov-express/actions/workflows/ci.yml)
[![github](https://img.shields.io/github/v/release/lpenz/ghaction-grcov-express?include_prereleases&label=release&logo=github)](https://github.com/lpenz/ghaction-grcov-express/releases)
[![docker](https://img.shields.io/docker/v/lpenz/ghaction-grcov-express?label=release&logo=docker&sort=semver)](https://hub.docker.com/repository/docker/lpenz/ghaction-grcov-express)

# ghaction-grcov-express

This github action is a faster alternative to the standard
[actions-rs/grcov] github action.

The actions-rs/grcov action installs
[grcov](https://github.com/mozilla/grcov) in the local container
before executing it, which takes time. This action downloads a ~20MB
alpine-based container with grcov installed instead, and runs the tool
from there.


## Usage

Just run this action instead of the [actions-rs/grcov] github
action. This action even outputs a `report` parameter to maintain
compatibility, although the configuration file is supported.

```yml
on: [push]
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: nightly
          override: true
      - uses: actions-rs/cargo@v1
        with:
          command: test
          args: --all-features --no-fail-fast
        env:
          CARGO_INCREMENTAL: '0'
          RUSTFLAGS: '-Zprofile -Ccodegen-units=1 -Cinline-threshold=0 -Clink-dead-code -Coverflow-checks=off -Cpanic=abort -Zpanic_abort_tests'
          RUSTDOCFLAGS: '-Zprofile -Ccodegen-units=1 -Cinline-threshold=0 -Clink-dead-code -Coverflow-checks=off -Cpanic=abort -Zpanic_abort_tests'
      - uses: docker://lpenz/ghaction-grcov-express:0.1
```


## Outputs

- `report`: path to the report file

[actions-rs/grcov]: https://github.com/actions-rs/grcov

