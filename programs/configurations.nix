{ config, pkgs, lib, ... }:
# This module is imported into home manager
{
  # Git configuration to push to Github repo
  programs.git = {
    enable = true;
    userName = "Sunny";
    userEmail = "sun+nxisoftgithub@coinblock25.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  
  # Gnucash configuration to disable webkit (use if print invoices or reports come up blank)
  home.packages = with pkgs; [
    (pkgs.stdenv.mkDerivation {
      name = "gnucash-wrapper";
      buildInputs = [ pkgs.makeWrapper pkgs.gnucash ];

      unpackPhase = "true"; # nothing to unpack

      installPhase = ''
      mkdir -p $out/bin
      makeWrapper ${pkgs.gnucash}/bin/gnucash $out/bin/gnucash \
        --set WEBKIT_DISABLE_COMPOSITING_MODE 1
    '';
  })
  ];
}
