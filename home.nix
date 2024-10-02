{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
    ];

    username = "lasse";
    homeDirectory = "/home/lasse";

    stateVersion = "23.11";
  };
}