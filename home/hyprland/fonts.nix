{ config, pkgs, lib, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.nerd-fonts.caskaydia-cove
  ];

}
