{ config, pkgs, lib, ... }:
{
  imports = [
    ./default.nix
  ];

  virtualisation.incus.agent.enable = true;

  system.nixos.tags = [ "with-incus-agent" ];
}
