{ lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  
  home = {
    packages = with pkgs; [
      hello
      nnn
      dotnetCorePackages.sdk_8_0
      nodejs_20
      ffmpeg
      nodePackages.pnpm

      neovim
      trash-cli

      # Fonts
      (nerdfonts.override {fonts = ["FiraCode"];})
      fira-code
    ];

    username = "lasse";
    homeDirectory = "/home/lasse";

    stateVersion = "23.11";
  };

  lasse.homeManagerScripts = {
    enable = true;
    configDir = "/home/lasse/lhm";
    machine = "lasse";
  };

  lasse.zsh.enable = true;
  lasse.fonts.enable = true;
  lasse.yazi.enable = true;

  lasse.git = {
    enable = true;
    userName = "Lasse H. Bomholt";
    userEmail = "lasse@bomh.net";
  };

  # Disable home manager news
  news.display = "silent";
  news.json = lib.mkForce { };
  news.entries = lib.mkForce [ ];
  
  programs = {
    home-manager.enable = true;

    bash = {
      enable = true;
      initExtra = "exec zsh";
    };
   };
}
