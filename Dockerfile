FROM ghcr.io/bryopsida/node-fips:main AS node_provider

FROM scratch AS runtime
COPY --from=node_provider /usr/local/bin/node /usr/local/bin/node
COPY --from=node_provider /lib/ld-musl-*.so.1 /lib/
COPY --from=node_provider /lib/libc.musl-*.so.1 /lib/
COPY --from=node_provider /usr/lib/libgcc_s.so.1 /lib/libgcc_s.so.1
COPY --from=node_provider /usr/lib/libstdc++.so.6 /lib/libstdc++.so.6
COPY --from=node_provider /usr/lib/ossl-modules/fips.so /usr/lib/ossl-modules/fips.so
COPY --from=node_provider /usr/ssl/fipsmodule.cnf /usr/ssl/fipsmodule.cnf
COPY --from=node_provider /usr/ssl/openssl.cnf /usr/ssl/openssl.cnf

ENV OPENSSL_CONF=/usr/ssl/openssl.cnf
ENV OPENSSL_MODULES=/usr/lib/ossl-modules/

