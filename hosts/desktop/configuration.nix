{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../common/configuration.nix
    ./hardware-configuration.nix
  ];
  networking.hostName = lib.mkForce "nixos-desktop";
}
