{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
      nnn
    ];

    username = "lasse";
    homeDirectory = "/home/lasse";

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
