{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./default.nix
    ../hardware/laptop.nix
  ];
  console.keyMap = "br-abnt2";
  networking.hostName = lib.mkForce "nixos-laptop";
}
