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
     #vivaldi
     #vivaldi-ffmpeg-codecs
     prismlauncher
     mullvad-vpn
     davinci-resolve-studio
     gimp3
     dconf-editor
     anki
     gnome-tweaks
     whitesur-gtk-theme
     brave
     gnucash
     rclone
     flameshot
  ];
}
