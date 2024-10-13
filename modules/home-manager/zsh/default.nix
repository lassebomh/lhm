{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.lasse.zsh;
in {
  options.lasse.zsh = {
    enable = mkEnableOption "zsh configuration.";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh.enable = true;

      plugins = [
        {
          name = "gruvbox-powerline";
          file = "gruvbox.zsh-theme";
          src = ./gruvbox-powerline;
        }
        {
          name = "zsh-completions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-completions";
            rev = "0.34.0";
            sha256 = "1c2xx9bkkvyy0c6aq9vv3fjw7snlm0m5bjygfk5391qgjpvchd29";
          };
        }
      ];
    };
  };
}