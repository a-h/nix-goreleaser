{ pkgs, stdenv, fetchurl, autoPatchelfHook }:

let
  mapPlatformToName = platform:
    if platform.isDarwin then "Darwin"
    else if platform.isLinux then "Linux"
    else platform.parsed.kernel.name;

  suffixToHash = {
    # Use `print-hashes.sh` to generate the list below
    Linux_x86_64 = "19n5ywhg8gdav611w0iil1drnr4l1ba7akb8andi9fk54h8r70a9";
    Linux_arm64 = "0j28cddj5vvw6ni0hpgzazsn5qmg4pmmm23vqlrw535xvixi40jw";
    Darwin_x86_64="0mfsv7r2gm8zichc3rgfx45ivwfcvw6yjnl19rwmh0damir5c6yr";
    Darwin_arm64 = "1z6na7q4ws1mxbyiimp8vagb0wvfl9pqd4pvcisz62hw7wkza2fr";
  };

  mapPlatformToArchitecture = platform: {
    "x86_64" = "x86_64";
    "aarch64" = "arm64";
  }.${platform.parsed.cpu.name} or (throw "Unsupported CPU ${platform.parsed.cpu.name}");

  version = "v1.16.0";

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
