
{
  description = "DWM (Dynamic Window Manager)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        name = "dwm";
        src = /path/to/your/dwm;  # Use the local path to your dwm source

        buildInputs = [ pkgs.xorg.libX11 pkgs.xorg.libXft pkgs.xorg.libXinerama ];

        installPhase = ''
          mkdir -p $out/bin
          make PREFIX=$out install
        '';
      };
    };
}
