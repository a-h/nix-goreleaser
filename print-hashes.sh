#!/usr/bin/env bash
set -euo pipefail

nix-prefetch-url https://github.com/goreleaser/goreleaser/releases/download/v1.16.0/goreleaser_Linux_x86_64.tar.gz
nix-prefetch-url https://github.com/goreleaser/goreleaser/releases/download/v1.16.0/goreleaser_Linux_arm64.tar.gz

nix-prefetch-url https://github.com/goreleaser/goreleaser/releases/download/v1.16.0/goreleaser_Darwin_x86_64.tar.gz
nix-prefetch-url https://github.com/goreleaser/goreleaser/releases/download/v1.16.0/goreleaser_Darwin_arm64.tar.gz
