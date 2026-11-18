# axshell-gamma built from this checkout
{ pkgs, lib ? pkgs.lib }:

pkgs.rustPlatform.buildRustPackage {
  pname = "axshell-gamma";
  version = (lib.importTOML ../Cargo.toml).package.version;

  src = lib.fileset.toSource {
    root = ./..;
    fileset = lib.fileset.unions [ ../Cargo.toml ../Cargo.lock ../src ../protocols ../assets ../LICENSE ];
  };
  cargoLock.lockFile = ../Cargo.lock;

  postInstall = ''
    install -Dm644 assets/org.axshell.Gamma.service $out/share/dbus-1/services/org.axshell.Gamma.service
    substituteInPlace $out/share/dbus-1/services/org.axshell.Gamma.service --replace-fail @out@ $out
  '';

  meta = {
    description = "Display temperature, brightness and gamma over D-Bus on Wayland";
    homepage = "https://github.com/mora1ss/axshell-gamma";
    license = lib.licenses.agpl3Plus;
    mainProgram = "axshell-gamma";
    platforms = lib.platforms.linux;
  };
}
