# Create the standard environment.
source $stdenv/setup
# Extract the source code.
mkdir -p $out/opt/goreleaser
tar -C $out/opt/goreleaser -xzf $src
# Create place to store the binaries.
mkdir -p $out/bin
# Make symlinks to the binaries.
ln -s $out/opt/goreleaser/goreleaser $out/bin/goreleaser
