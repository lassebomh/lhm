{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  module = baseNameOf ./.;
  cfg = config.modules.${module};
  extraConfig = (builtins.readFile ./extraConfig.sh);
in {
  options.modules.${module} = {
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



