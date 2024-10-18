{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.tmux;
  extraConfig = (builtins.readFile ./extraConfig.sh);
in {
  options.modules.tmux = {
    enable = mkEnableOption "tmux.";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      mouse = true;
      extraConfig = extraConfig;
    };
  };
}



