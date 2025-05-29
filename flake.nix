# flake.nix
{
  description = "Custom Nix repository with overridden packages";

  # Define inputs (dependencies), including Nixpkgs and your custom repository
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";  # Replace with your Nixpkgs branch
  };

  outputs = { self, nixpkgs, ... }:
    let
      # Import Nixpkgs and apply the overlay from your custom repository
      overlay =  ( self: super: {
        tuxedo-rs = super.callPackage ./pkgs/tuxedo-rs/package.nix { };
        drumkv1 = super.callPackage ./pkgs/drumkv1/default.nix { };
        idtech4 = super.callPackage ./pkgs/idtech4/package.nix { };
      });

      pkgs = import nixpkgs {
        system = "x86_64-linux";  # Adjust for your target system
        overlays = [
          overlay
        ];
      };
    in
    # Return the package set (including overrides)
    {
      overrides = overlay;
      packages.x86_64-linux.tuxedo-rs = pkgs.tuxedo-rs;
      packages.x86_64-linux.drumkv1 = pkgs.drumkv1;
      packages.x86_64-linux.idtech4 = pkgs.idtech4;
    };
}

