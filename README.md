# NixOS Configuration

## Usage

Ensure that flakes are enables on a bare system! Refer to the [NixOS wiki entry on Flakes](https://nixos.wiki/wiki/Flakes).

Make sure `flake.lock` is up-to-date with:
```
nix flake update
```

To install any changes, run:
```
sudo nixos-rebuild switch --flake .#desktop
```

### Home Manager

Home Manager can be used as a [module](https://nix-community.github.io/home-manager/index.xhtml#sec-install-nixos-module) and in [standalone mode](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone) as well -- convenient for use with non-NixOS machines. When using the standalone setup, update Home Manager with:
```
nix flake update home-manager
home-manager switch --flake .#desktop
```
