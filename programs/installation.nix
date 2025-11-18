{ config, lib, pkgs, ... }:
# This module is imported into configuration.nix main file
{
  # Look up the NixOS Package Search Repository to add packages down below to add them on the system
  environment.systemPackages = with pkgs; [
     git
     vesktop
     steam
     xivlauncher
     obsidian
     vscode
     obs-studio
     audacity
     bitwarden-desktop
     gearlever
     prismlauncher
     mullvad-vpn
     davinci-resolve-studio
     gimp3
     dconf-editor
     anki
     gnome-tweaks
     whitesur-gtk-theme
     gnucash
     rclone
     flameshot
     streamcontroller
     qbittorrent
     brave
  ];
  # Enable your installed stuff here
  services.mullvad-vpn.enable = true;
  programs.steam.enable = true;
  
  # Write Chromium rules
  programs.chromium = {
    enable = true;
  # Automatically Install Extensions on all Chromium Browsers
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "cfhdojbkjhnklbpkdaibdccddilifddb" # Adblock Plus
      "gphhapmejobijbbhgpjhcjognlahblep" # GNOME Shell Integration
    ];
   };
}
