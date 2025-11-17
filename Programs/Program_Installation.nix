{ config, lib, pkgs, ... }:

{
# List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
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
     firefox
  ];
}
