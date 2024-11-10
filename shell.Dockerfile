FROM ghcr.io/bryopsida/node-fips:main AS shell-env
RUN apk add --no-cache ldd
