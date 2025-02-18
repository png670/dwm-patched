{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              dwmJD = prev.dwm.overrideAttrs (oldAttrs: rec {
                version = "main";
                src = ./.;
              });
            })
          ];
        };
      in
      rec {
        apps = {
          dwm = {
            type = "app";
            program = "${defaultPackage}/bin/st";
          };
        };

        packages.dwmJD = pkgs.dwmJD;
        defaultApp = apps.dwm;
        defaultPackage = pkgs.dwmJD;

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [ xorg.libX11 xorg.libXft xorg.libXinerama gcc bear ];
        };
      }
    );
}
