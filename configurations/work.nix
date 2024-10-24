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
      machine = "work";
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
      enableZshIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };
        
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = "exec zsh";
    };

    neovim = {
      enable = true;
      defaultEditor = true;
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
