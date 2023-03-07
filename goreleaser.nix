{ pkgs, stdenv, fetchurl, autoPatchelfHook }:

let
  mapPlatformToName = platform:
    if platform.isDarwin then "Darwin"
    else if platform.isLinux then "Linux"
    else platform.parsed.kernel.name;

  suffixToHash = {
    # Use `print-hashes.sh` to generate the list below
    Linux_x86_64 = "1a9a70y5f0phpymcvdk2i9mb42i01rmfflk7qcjhgn2nax2w8c0p";
    Linux_arm64 = "0s4ipd8743vfbxlj78vd2hd3cvk68sjskhny3qp4bvmm5vx0mgs1";
    Darwin_x86_64 = "0p9kbl3556mqrdjqbd5sasvmy263npskrp7kizri7fapz8jv3x2l";
    Darwin_arm64 = "1hzx6ng8n85z7b08v20mhri2asqy96lb96l2sg05h5whavvsg8w7";
  };

  mapPlatformToArchitecture = platform: {
    "x86_64" = "x86_64";
    "aarch64" = "arm64";
  }.${platform.parsed.cpu.name} or (throw "Unsupported CPU ${platform.parsed.cpu.name}");

  version = "v1.15.2";

  mapPlatformToSuffix = platform: "${mapPlatformToName platform}_${mapPlatformToArchitecture platform}";

  suffix = mapPlatformToSuffix stdenv.hostPlatform;
in
stdenv.mkDerivation {
  pname = "goreleaser";
  version = version;
  src = fetchurl {
    url = "https://github.com/goreleaser/goreleaser/releases/download/${version}/goreleaser_${suffix}.tar.gz";
    sha256 = suffixToHash.${suffix} or (throw "Missing hash for suffix ${suffix}");
  };
  sourceRoot = "."; # goreleaser doesn't have a folder in the tar.gz file.
  nativeBuildInputs = if pkgs.stdenv.isLinux
    then [ autoPatchelfHook ]
    else [];
  installPhase = ./install.sh;
  system = builtins.currentSystem;
}
