
{
  description = "DWM flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.dwm.overrideAttrs (old: {
      src = ./.;
    });
  };
}
