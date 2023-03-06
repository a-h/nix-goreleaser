{ config, lib, pkgs, fetchFromGitHub, ... }:

pkgs.buildGoModule rec {
  pname = "goreleaser";
  version = "v1.15.2";
  src = pkgs.fetchFromGitHub {
    owner = "goreleaser";
    repo = "goreleaser";
    rev = version;
    sha256 = "";
  };
  vendorSha256 = "";
}
