ARG TAG=local
FROM ghcr.io/bryopsida/node-fips:main AS node_installer
WORKDIR /libraries
COPY ./web-app-test/package*.json .
RUN npm ci --only=production --no-audit

FROM ghcr.io/bryopsida/node-scratch-fips:${TAG} AS runtime

USER 10001
WORKDIR /app
COPY ./web-app-test/webapp.js /app/webapp.js
COPY --from=node_installer /libraries/node_modules /app/node_modules
EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/node", "/app/webapp.js"]
