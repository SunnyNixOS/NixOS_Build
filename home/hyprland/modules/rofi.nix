{ config, pkgs, lib, ... }:

let
  # Create a Rofi .rasi theme file for Catppuccin
  catppuccinRasi = builtins.toFile "rofi-catppuccin.rasi" ''
    * {
      rosewater: #f5e0dc;
      flamingo: #f2cdcd;
      pink: #f5c2e7;
      mauve: #cba6f7;
      red: #f38ba8;
      maroon: #eba0ac;
      peach: #fab387;
      yellow: #f9e2af;
      green: #a6e3a1;
      teal: #94e2d5;
      sky: #89dceb;
      sapphire: #74c7ec;
      blue: #89b4fa;
      lavender: #b4befe;
      text: #cdd6f4;
      subtext1: #bac2de;
      subtext0: #a6adc8;
      overlay2: #9399b2;
      overlay1: #7f849c;
      overlay0: #6c7086;
      surface2: #585b70;
      surface1: #45475a;
      surface0: #313244;
      base: #1e1e2e;
      mantle: #181825;
      crust: #11111b;
    }
    
    /* Now apply the theme to rofi GUI elements */
    @theme "catppuccin-custom"

    * {
      background-color: @base;
      foreground-color: @text;
      border-color: @overlay1;
      border-width: 2px;
      padding: 8px;
      element-border: 2px;
      element-background: @surface1;
      element-foreground: @subtext1;
      element-border-color: @overlay0;
      element-border-radius: 4px;
    }

    /* Example for selected element */
    "#element.selected" {
      background-color: @peach;
      text-color: @base;
    }

    /* Input (prompt) section */
    "#inputbar" {
      children: [ "prompt" "entry" ];
    }

    "#textbox-prompt-colon" {
      expand: false;
      str: ":";
      margin: 0px 0.3em 0px 0px;
      text-color: @peach;
    }
  '';
in
{
  programs.rofi = {
    enable = true;

    # Point rofi.theme to our generated Rasi file
    theme = catppuccinRasi;

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      font = "JetBrains Mono 12";
    };
  };
}
