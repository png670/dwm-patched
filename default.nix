{ stdenv, lib, fetchurl, libX11, libXft, libXinerama }:
with lib;

stdenv.mkDerivation {
  name = "dwm";

  src = builtins.filterSource
    (path: type: (toString path) != (toString ./.git)) ./.;

  buildInputs = [ libX11 libXft libXinerama ];

  prePatch = ''
    substituteInPlace config.mk --replace '/usr/local' $out
  '';

  meta = {
    description = "Dynamic window manager that suck less";
    homepage = https://dwm.suckless.org/;
    license = licenses.mit;
    platforms = platforms.all;
  };
}
