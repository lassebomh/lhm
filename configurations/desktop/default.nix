{
  lib,
  pkgs,
  ...
}: let
  username = "lasse";
  homeDirectory = "/home/lasse";
  configDir = "/home/lasse/lhm";

  fullname = "Lasse H. Bomholt";
  email = "lasse@bomh.net";
in {
  home = {
    inherit username;
    inherit homeDirectory;

    stateVersion = "23.11";

    packages = with pkgs; [
      nmap
      pipx
      kanata
    ];

    sessionPath = [
      "${homeDirectory}/.local/bin"
    ];
  };

  modules = {
    terminal-tools = {
      enable = true;
      configName = baseNameOf ./.;
      inherit configDir;
    };

    zsh.enable = true;
    fonts.enable = true;
    yazi.enable = true;
    vscode.enable = true;
    tmux.enable = true;

    git = {
      enable = true;
      inherit fullname;
      inherit email;
    };
  };

  programs = {
    home-manager.enable = true;
    go.enable = true;
    zsh.initExtra = ''
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      PATH=$PATH:${homeDirectory}/.local/bin
    '';

    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
