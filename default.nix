{ stdenv
, fetchurl
, zstd
, source
}:

stdenv.mkDerivation {
  name = "proton-cachyos";
  version = "${source.version}";

  src = fetchurl {
    url = source.x86_64-linux.url;
    hash = source.x86_64-linux.hash;
  };

  nativeBuildInputs = [ zstd ];

  installPhase = ''
    mkdir ../proton-cachyos
    mv ./* ../proton-cachyos
    mv ../proton-cachyos .
    ls
    mkdir -p $out/share/steam/compatibilitytools.d
    mv proton-cachyos/ $out/share/steam/compatibilitytools.d/
    ln -s $out/share/steam/compatibilitytools.d/proton-cachyos/files/lib/wine/x86_64-unix/*.so $out/share/steam/compatibilitytools.d/proton-cachyos/files/lib/wine/
  '';

  meta = {
    description = "CachyOS Proton build with additional patches and optimizations";
    homepage = "https://github.com/CachyOS/proton-cachyos";
    platforms = [ "x86_64-linux" ];
  };
}
