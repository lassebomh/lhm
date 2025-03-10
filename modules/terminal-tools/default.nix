{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let

  module = baseNameOf ./.;

  cfg = config.modules.${module};
  configDir =
    if (cfg.configDir != null)
    then cfg.configDir
    else "${config.xdg.configHome}/home-manager";

  hm-clean = pkgs.writeShellApplication {
    name = "hm-clean";
    text = ''
      # Delete old home-manager profiles
      home-manager expire-generations '-30 days' &&
      # Delete old nix profiles
      nix profile wipe-history --older-than 30d &&
      # Optimize space
      nix store gc &&
      nix store optimise
    '';
  };

  hm-help = pkgs.writeShellApplication {
    name = "hm-help";
    text = "man home-configuration.nix";
  };

  hm-update = pkgs.writeShellApplication {
    name = "hm-update";
    text = ''
      nix flake update --flake ${configDir}
    '';
  };

  hm-upgrade = pkgs.writeShellApplication {
    name = "hm-upgrade";
    text = ''
      # Update, switch to new config, and cleanup
      ${hm-update}/bin/hm-update &&
      ${hm-rebuild}/bin/hm-rebuild &&
      ${hm-clean}/bin/hm-clean
    '';
  };

  hm-rebuild = pkgs.writeShellApplication {
    name = "hm-rebuild";
    text = ''
      # Switch configuration, backing up files
      pushd ${configDir}
      git add -A
      home-manager switch -b backup --flake .#${cfg.configName}
      popd
    '';
  };

  hm-rollback = pkgs.writeShellApplication {
    name = "hm-rollback";
    runtimeInputs = [pkgs.fzf];
    text = ''
      gen=$(home-manager generations | grep -P "^[0-9]{4}-[0-9]{2}-[0-9]{2}" | fzf)
      genPath=$(echo "$gen" | grep -oP "/nix/store/.*")

      echo -e '\033[1mActivating selected generation:\n\033[0m'
      "$genPath"/activate
    '';
  };
in {
  options.modules.${module} = {
    enable = mkEnableOption ''
      Home manager scripts. Gives access to command-line scripts that make
      managing home-manager easier. These scripts are lean bash scripts that
      compose a couple of nix and home-manager commands:

      - `hm-update`: Updates the available packages, usually, you don't need
        to run this, but the other scripts use it.
      - `hm-clean`: Cleans up older configurations and garbage collects the
        nix store, cleaning up unused packages and freeing up harddisk space
      - `hm-rebuild`: Builds your configuration. Backs up files; if you
        fx have a `.bashrc` and home-manager needs to overwrite it, the old
        `.bashrc` is renamed to `.bashrc.bck`
      - `hm-upgrade`: Updates all packages, rebuilds and finally older
        configurations/garbage collects
      - `hm-rollback`: Use this command to roll back to a previous working
        home manager configuration.

    '';

    configDir = mkOption {
      type = types.nullOr types.path;
      # modules are evaluated as follows: imports, options, config
      # you don't want to refer to config. from options as they haven't been evaluated yet.
      default = null;
      description = ''
        Path to the home-manager configuration. If not set, will default to:
        `''${config.xdg.configHome}/home-manager`.
      '';
    };

    configName = mkOption {
      type = types.nullOr types.str;
      description = "**REQUIRED!** Path to the home-manager configuration.";
    };
  };

  config = mkIf cfg.enable {
    
    programs = {
      direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
        silent = true;
      };
          
      fzf = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    };

    news.display = "silent";
    news.json = lib.mkForce { };
    news.entries = lib.mkForce [ ];
    
    home.packages = [
      hm-update
      hm-upgrade
      hm-rebuild
      hm-clean
      hm-rollback
      hm-help

      pkgs.trash-cli
    ];
  };
}
