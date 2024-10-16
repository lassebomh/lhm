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
    # zsh.enable = true;
    fonts.enable = true;
    yazi.enable = true;
    vscode.enable = true;

    homeManagerScripts = {
      enable = true;
      configDir = "/home/lasse/lhm";
      machine = "lasse";
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
      # initExtra = "exec zsh";
    };

    tmux = {
      enable = true;
      mouse = true;
      extraConfig = ''
        # Change the prefix key to C-a
        unbind C-b
        set -g prefix C-a
        bind C-a send-prefix

        # Use Alt-arrow keys without prefix key to switch panes
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # Shift arrow to switch windows
        bind -n S-Left  previous-window
        bind -n S-Right next-window

        # Use | and - to split windows
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # Kill without confirmation
        bind-key x kill-pane
      '';
    };
   };
}
