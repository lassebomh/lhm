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
    enable = mkEnableOption "git";

    email = mkOption {
      type = types.str;
      description = "What email address to use for git.";
    };

    fullname = mkOption {
      type = types.str;
      description = "Username to use for git.";
    };
  };

  config = mkIf cfg.enable {
    
    programs.gh = {
      enable = true;
    };

    programs.git = {
      enable = true;
      
      userEmail = cfg.email;
      userName = cfg.fullname;

      difftastic.enable = true;
      
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}