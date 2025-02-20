{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              dwm = prev.dwm.overrideAttrs (oldAttrs: rec {
                version = "mainr";
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

        packages.dwm = pkgs.dwm;
        defaultApp = apps.dwm;
        defaultPackage = pkgs.dwm;

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [ xorg.libX11 xorg.libXft xorg.libXinerama gcc bear ];
        };
      }
    );
}
