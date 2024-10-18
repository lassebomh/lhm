{ lib, pkgs, ... }:
{  
  home = {
    packages = with pkgs; [
      trash-cli

      # Fonts
      (nerdfonts.override {fonts = ["FiraCode"];})
      fira-code
    ];

    username = "lasse";
    homeDirectory = "/home/lasse";

    stateVersion = "23.11";
  };

  modules = {
    zsh.enable = true;
    fonts.enable = true;
    yazi.enable = true;
    vscode.enable = true;
    tmux.enable = true;

    homeManagerScripts = {
      enable = true;
      configDir = "/home/lasse/lhm";
      machine = "desktop";
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

    direnv = {
      enable = true;
      enableBashIntegration = true;
    };
        
    fzf = {
      enable = true;
      enableZshIntegration = false;
    };

    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = "exec zsh";
    };
   };
}
