# NixOS Configuration

## Usage

Ensure that flakes are enables on a bare system! Refer to the [NixOS wiki entry on Flakes](https://nixos.wiki/wiki/Flakes).

Make sure `flake.lock` is up-to-date with:
```
nix flake update
```

To install any changes, run:
```
sudo nixos-rebuild switch --flake .#mick
```

### Home Manager

Home Manager can be used as a module and in standalone mode as well -- convenient for use with non-NixOS machines. When using the standalone setup, updating Home Manager happens with:
```
nix flake update home-manager
home-manager switch --flake .#mick
```
