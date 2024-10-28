{ lib, pkgs, ... }:
{  
  home = {
    packages = with pkgs; [
      trash-cli
    ];

    username = "lhb";
    homeDirectory = "/home/lhb";

    stateVersion = "23.11";
  };

  modules = {
    fonts.enable = true;
    zsh.enable = true;
    yazi.enable = true;
    vscode.enable = false;

    homeManagerScripts = {
      enable = true;
      configDir = "/home/lhb/lhm";
      configuration = "work";
    };

    git = {
      enable = true;
      userName = "Lasse H. Bomholt";
      userEmail = "lasse@bomh.net";
    };
  };


  # Disable home manager news
  news.display = "silent";
  news.json = lib.mkForce { };
  news.entries = lib.mkForce [ ];
  
  programs = {
    home-manager.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };
   };
}
