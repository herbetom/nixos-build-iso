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

  isoImage.isoName = lib.mkForce "${config.isoImage.isoBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}-${config.networking.hostName}.iso";

  boot.kernelPackages = pkgs.linuxPackages_6_10;
  boot.supportedFilesystems = [ "bcachefs" ];
  environment.systemPackages = with pkgs; [ bcachefs-tools ];

}
