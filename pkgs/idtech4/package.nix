{
  lib,
  stdenv,
  fetchzip,
  cmake,
  directx-shader-compiler,
  libGLU,
  libpng,
  libjpeg_turbo,
  autoPatchelfHook,
  openal,
  rapidjson,
  SDL2,
  alsa-lib,
  vulkan-headers,
  vulkan-loader,
  zlib,
}:

stdenv.mkDerivation rec {
  pname = "idtech4";
  version = "1.0";

  src = fetchzip {
    url = "http://localhost:8000/idTechNix.zip";
    hash = "sha256-6pUUQ+v6gGeRBMq0ygU/eSQkSVuG+crz10iKWs7TfNw="; 
  };

  nativeBuildInputs = [
    cmake
    directx-shader-compiler
    autoPatchelfHook
  ];

  buildInputs = [
    libGLU
    libpng
    libjpeg_turbo
    openal
    rapidjson
    SDL2
    alsa-lib
    vulkan-headers
    vulkan-loader
    zlib
  ];

  cmakeDir = "../neo";
  cmakeFlags = [
    "-DFFMPEG=OFF"
    "-DBINKDEC=ON"
    "-DUSE_SYSTEM_LIBGLEW=ON"
    "-DUSE_SYSTEM_LIBPNG=ON"
    "-DUSE_SYSTEM_LIBJPEG=ON"
    "-DUSE_SYSTEM_RAPIDJSON=ON"
    "-DUSE_SYSTEM_ZLIB=ON"
  ];

  # it caused build failure
  hardeningDisable = [ "fortify3" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/lib
    install Quake4 $out/bin/Quake4
    install Doom3 $out/bin/Doom3
    install Prey $out/bin/Prey
    install libcdoom.so $out/lib/
    install libd3le.so $out/lib/
    install libd3xp.so $out/lib/
    install libfraggingfree.so $out/lib/
    install libgame.so $out/lib/
    install libhardcorps.so $out/lib/
    install libhardqore.so $out/lib/
    install libhexeneoc.so $out/lib/
    install liblibrecoop.so $out/lib/
    install liblibrecoopxp.so $out/lib/
    install liboverthinked.so $out/lib/
    install libperfected_roe.so $out/lib/
    install libperfected.so $out/lib/
    install libpreygame.so $out/lib/
    install libq4game.so $out/lib/
    install librivensin.so $out/lib/
    install libsabot.so $out/lib/
    install libtfphobos.so $out/lib/

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "-";
    description = "IdTech4 Engine (including Quake4 support)";
    mainProgram = "Quake4";
    license = licenses.gpl3;
    platforms = platforms.unix;
  };
}
