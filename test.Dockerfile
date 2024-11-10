ARG TAG=local
FROM ghcr.io/bryopsida/node-scratch-fips:${TAG} AS runtime

USER 10001
WORKDIR /app
COPY app.js /app/app.js
EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/node", "/app/app.js"]