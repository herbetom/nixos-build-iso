# This module defines a small NixOS installation CD. It does not
# contain any graphical stuff.
{ config, pkgs, lib, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>

    ./common.nix
  ];

  image.fileName = lib.mkForce "${config.image.baseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}-${config.networking.hostName}.iso";

}
