#!/bin/sh
# Lay out an installed axshell-gamma under $1 with the prefix /usr, from a release build.
# The release tarball is made from this tree.
set -eu
dest=${1:?usage: stage.sh DEST}
cd "$(dirname "$0")/.."

install -Dm755 target/release/axshell-gamma "$dest/usr/bin/axshell-gamma"
install -Dm644 assets/org.axshell.Gamma.service "$dest/usr/share/dbus-1/services/org.axshell.Gamma.service"
sed -i 's|@out@|/usr|' "$dest/usr/share/dbus-1/services/org.axshell.Gamma.service"
install -Dm644 LICENSE "$dest/usr/share/licenses/axshell-gamma/LICENSE"
