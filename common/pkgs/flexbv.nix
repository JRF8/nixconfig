{ lib, stdenv, fetchurl, autoPatchelfHook, makeWrapper
, libGL, libglvnd, vulkan-loader, libdrm, llvmPackages
, zlib, fontconfig, freetype
, libx11, libxext, libxcursor, libxi, libxrandr, libxfixes
, wayland, libxkbcommon, gtk3, glib, alsa-lib }:

stdenv.mkDerivation {
  pname = "flexbv";
  version = "6.0394";

  src = fetchurl {
    url = "https://pldaniels.com/flexbv6/releases/flexbv-std-6.0394-linux-x86_64.tar.gz";
    hash = "sha256-pEQJx1mADyEgQlN8gUb1n8r/uJy383li3gyUoHlQiDE=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];
  buildInputs = [
    stdenv.cc.cc.lib zlib libGL fontconfig freetype
    vulkan-loader libdrm
    llvmPackages.libcxx llvmPackages.libunwind
    libx11 libxext libxcursor libxi libxrandr libxfixes
    wayland libxkbcommon gtk3 glib alsa-lib
  ];

  # dlopen'd at runtime
  runtimeDependencies = [ libGL libglvnd vulkan-loader libxkbcommon wayland ];

  autoPatchelfIgnoreMissingDeps = [ "libsteam_api.so" "libGLES_CM.so.1" ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -d $out/libexec/flexbv $out/bin
    install -m755 flexbv fbvpdf5 $out/libexec/flexbv/
    install -m755 libpdfium.so    $out/libexec/flexbv/

    makeWrapper $out/libexec/flexbv/flexbv $out/bin/flexbv \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ libGL libglvnd vulkan-loader ]}:$out/libexec/flexbv

    cp -r share $out/share
    sed -i "s|^Exec=.*|Exec=$out/bin/flexbv %f|" $out/share/applications/flexbv.desktop

    install -Dm644 LICENCE.txt $out/share/doc/flexbv/LICENCE.txt

    runHook postInstall
  '';

  meta = {
    description = "FlexBV boardview and schematic viewer";
    homepage = "https://pldaniels.com/flexbv";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "flexbv";
  };
}
