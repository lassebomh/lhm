{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  module = baseNameOf ./.;
  cfg = config.modules.${module};
in {
  options.modules.${module} = {
    enable = mkEnableOption "zsh configuration.";
  };

  config = mkIf cfg.enable {

    programs.starship = {
      enable = true;
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
      initExtra = "exec zsh";
    };

    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh.enable = true;

      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
          };
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
