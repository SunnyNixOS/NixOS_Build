{ config, pkgs, lib, ... }:
  {
   programs.kitty = {
     enable = true;
     settings = {
       confirm_os_window_close = 0;
     }; 
     themeFile = "Catppuccin-Mocha";
   };
   
   catppucin.waybar = {
     enable = true;
     flavor = mocha;
   };


  }
