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
  console.keyMap = "br-abnt2";
  networking.hostName = lib.mkForce "nixos-laptop";
}
