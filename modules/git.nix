{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.git;
in {
  options.modules.git = {
    enable = mkEnableOption "git";

    userEmail = mkOption {
      type = types.str;
      description = "What email address to use for git.";
    };

    userName = mkOption {
      type = types.str;
      description = "Username to use for git.";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      
      userEmail = cfg.userEmail;
      userName = cfg.userName;

      difftastic.enable = true;
      
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}