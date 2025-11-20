{ config, lib, pkgs, ... }:
{
  programs.nvchad = {
    enable = true;

    # Optional: extra NVChad packages (LSP servers, tools, etc.)
    extraPackages = with pkgs; [
      nodePackages.bash-language-server
      dockerfile-language-server-nodejs
      (python3.withPackages (ps: with ps; [ python-lsp-server ]))
    ];

    # Optional: custom NvChad config
    extraConfig = ''
      -- Lua config here, loaded *after* the default chadrc
      vim.g.mapleader = " "
    '';

    # Optional: provide your own chadrc.lua entirely
    # chadrcConfig = builtins.readFile ./path/to/your/chadrc.lua;

    # Optional: turn off copying config from Nix store on every generation
    hm-activation = true;

    # Optional: disable backups (nvchad module by default backs up existing ~/.config/nvim)
    backup = false;
  };


}