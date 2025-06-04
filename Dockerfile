FROM alpine AS certs
RUN apk update && apk add --no-cache ca-certificates # Use --no-cache for smaller image size

FROM busybox:stable-musl

ARG TARGETOS
ARG TARGETARCH

COPY --from=certs /etc/ssl/certs /etc/ssl/certs

WORKDIR /app

COPY dist/Topicgram_${TARGETOS}_${TARGETARCH} ./Topicgram
RUN chmod +x ./Topicgram

VOLUME ["/app/config.json"]

EXPOSE 8080

ENTRYPOINT ["/app/Topicgram", "--config", "/app/config.json"]
