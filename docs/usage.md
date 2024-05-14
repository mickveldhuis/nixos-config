# Using My Personal NixOS Configuration

## Installation

- Clone the repository to the desired folder, e.g.
```
$ git clone https://github.com/mickveldhuis/nixos-config.git .dotfiles
``` 
- Enable `flakes` and `nix-command`:
```
$ export NIX_CONFIG="experimental-features = nix-command flakes"
```
- Update `flake.lock`:
```
$ nix flake update
```

### Home-Manager

This configuration requires home-manager, which is installed as a standalone package by running the following three commands:

```
$ nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
$ nix-channel --update
$ nix-shell '<home-manager>' -A install 
```

This example follows the 23.11 Nixpkgs release, please adjust appropriately.

## Updating the System

To update the system's configurations, run:
```
$ sudo nixos-rebuild switch --flake .#mick
```

To update the home configuration, run:
```
$ home-manager switch --flake .
```

To update the flake inputs, run:
```
$ nix flake update
```

