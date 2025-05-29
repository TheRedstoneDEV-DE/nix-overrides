{ 
  stdenv, lib, pkg-config
,  fetchFromGitHub
,  libjack2
,  alsa-lib
,  libsndfile
,  liblo
,  lv2
,  qt6
,  xorg
}:

stdenv.mkDerivation rec {
  pname = "tutka-qt6";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "TheRedstoneDEV-DE";
    repo = "tutka-qt6";
    rev = "3eef48fc6b0a610b085e2ea5169584059193bd93";
    sha256 = "sha256-uBMQfHi/+tnQg7kudkmuuCQ2KONCLyloLLW7PAYP54g=";
  };

  buildInputs = [
    libjack2
    alsa-lib
    libsndfile
    liblo
    lv2
    xorg.libX11
    qt6.qtbase
    qt6.qtwayland
    qt6.qtsvg
    qt6.qttools
  ];
  
  enableParallelBuilding = true; 


  configurePhase = ''
   qmake
  '';

  installPhase = ''
    make install INSTALL_ROOT=$out
  '';


  nativeBuildInputs = [ pkg-config qt6.qttools qt6.wrapQtAppsHook ];
  
  meta = with lib; {
    description = "Old-school drum-kit sampler synthesizer with stereo fx";
    mainProgram = "tutka";
    homepage = "http://drumkv1.sourceforge.net/";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = [ maintainers.goibhniu ];
  };
}

