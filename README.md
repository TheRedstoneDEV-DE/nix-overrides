# Nix Overrides
Packages that I overwrote or added for *myself* and maybe others that want to use them.

## How to use?
1. Setup flakes on your system, if you haven't already.
2. Add this to your flake inputs:
```nix
inputs = {
  # ...
  custom-overrides = {
    url = "github:TheRedstoneDEV-DE/nix-overrides";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  # ...
}

outputs = { custom-overrides, ... }@inputs: # add your stuff to those imports as well, don't replace it
{
  nixosConfiguration.default = nixpkgs.lib.nixosSystem {
    # ...
    modules = [
      {
        nixpkgs.overlays = [ custom-overrides.overrides ];
      }
      ./configuration.nix # change this if your entrypoint isn't named "configuration.nix"
      # ...
    ];
    # ...
  }
}
```
3. Run a `sudo nixos-rebuild switch --flake /etc/nixos/#default` to rebuild your system.

## Known issues / non documented features
- does not replace / add the packages to your standard nix-shell (needs more configuration)
- the `idtech4` package does not build, due to using code I'm unsure being able to publish (idtech4 source-code from idTech4A++)
- `tutka-qt6` does still have some segfaults and requires a restart after exporting as a MIDI file
