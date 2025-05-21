{ config, pkgs, lib, ... }:
{
  imports = [
    ./default.nix
  ];

  virtualisation.incus.agent.enable = true;
}
