{
  lib,
  fetchFromGitHub,
  rustPlatform,
  testers,
  tuxedo-rs,
}:
rustPlatform.buildRustPackage rec {
  pname = "tuxedo-rs";
  version = "0.3.1";

  # NOTE: This src is shared with tailor-gui.
  # When updating, the tailor-gui.cargoDeps hash needs to be updated.
  src = fetchFromGitHub {
    owner = "TheRedstoneDEV-DE";
    repo = "tuxedo-rs";
    rev = "ab90b1f8a097b50e229452b3c1dea1d930be3d38";
    hash = "sha256-DHSsknk8keEY6w8OgDui8fGFDM3aZRhwfKVGLHUn8jM=";
  };

  # Some of the tests are impure and rely on files in /etc/tailord
  doCheck = false;

  useFetchCargoVendor = true;
  cargoHash = "sha256-EkTLL7thZ/bBpY7TwfEsPOjJxzQ3vpxDi+sYPNAK6og=";

  passthru.tests.version = testers.testVersion {
    package = tuxedo-rs;
    command = "${meta.mainProgram} --version";
    version = version;
  };

  postInstall = ''
    install -Dm444 tailord/com.tux.Tailor.conf -t $out/share/dbus-1/system.d
  '';

  meta = with lib; {
    description = "Rust utilities for interacting with hardware from TUXEDO Computers";
    longDescription = ''
      An alternative to the TUXEDO Control Center daemon.

      Contains the following binaries:
      - tailord: Daemon handling fan, keyboard and general HW support for Tuxedo laptops
      - tailor: CLI
    '';
    homepage = "https://github.com/AaronErhardt/tuxedo-rs";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [
      mrcjkb
      xaverdh
    ];
    platforms = platforms.linux;
    mainProgram = "tailor";
  };
}
