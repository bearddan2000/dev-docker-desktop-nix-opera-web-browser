FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

ENV NIX_CHANNEL nixpkgs

ENV NIX_CHANNEL_URL https://nixos.org/channels/nixos-24.05

ENV NIX_PKG opera

ENV NIXPKGS_ALLOW_UNFREE 1

ENV NIX_PKG_EXEC blender

WORKDIR /app

RUN apt update

RUN apt-get install -y --no-install-recommends \
    apt-transport-https \
    software-properties-common \
    nix

RUN nix-channel --add $NIX_CHANNEL_URL $NIX_CHANNEL \
    && nix-channel --update \
    && nix-env -iA $NIX_CHANNEL.$NIX_PKG \
    && nix-build --impure "<${NIX_CHANNEL}>" -A $NIX_PKG

CMD "./result/bin/${NIX_PKG_EXEC}"