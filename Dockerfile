# Copyright (C) 2021 Leandro Lisboa Penz <lpenz@lpenz.org>
# This file is subject to the terms and conditions defined in
# file 'LICENSE', which is part of this source code package.

FROM rust:1.53-alpine AS build
RUN set -e -x; \
    apk update; \
    apk add --no-cache musl-dev; \
    cargo install grcov

FROM alpine:3.14
RUN set -e -x; \
    apk update; \
    apk add --no-cache bash; \
    rm -rf /var/cache/apk/*
COPY --from=build /usr/local/cargo/bin/grcov /usr/local/bin/
COPY entrypoint /usr/local/bin
CMD ["entrypoint"]
