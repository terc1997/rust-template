FROM rust:1.85 as builder
WORKDIR /usr/src/app
COPY ./image .
RUN cargo install --path .

FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y extra-runtime-dependencies && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/app /usr/local/bin/app
CMD ["rust-app"]
