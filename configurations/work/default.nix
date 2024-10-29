{ lib, pkgs, ... }:
let
  username = "lhb";
  homeDirectory = "/home/lhb";
  configDir = "/home/lhb/lhm";
  
  fullname = "Lasse H. Bomholt";
  email = "lasse@bomh.net";
in
{
  
  home = {
    inherit username;
    inherit homeDirectory;

    stateVersion = "23.11";
  };

  modules = {
    
    terminal-tools = {
      enable = true;
      configName = baseNameOf ./.;
      inherit configDir;
    };

    zsh.enable = true;
    yazi.enable = true;
    tmux.enable = true;

    git = {
      enable = true;
      inherit fullname;
      inherit email;
    };
  };

  programs = {
    home-manager.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };
   };
}
