{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
      nnn
      dotnetCorePackages.sdk_8_0
      nodejs_20
      ffmpeg
      nodePackages.pnpm
    ];

    username = "lasse";
    homeDirectory = "/home/lasse";

    stateVersion = "23.11";
  };

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      # oh-my-zsh = {
      #   enable = true;
      #   plugins = [];
      #   theme = "agnoster";
      # };
    };
  };
}
