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
    };
}

