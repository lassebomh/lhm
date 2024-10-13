{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.vscode;
  keybindings = (pkgs.lib.importJSON ./keybindings.json);
  userSettings = (pkgs.lib.importJSON ./settings.json);
  extensions = import ./extensions.nix { inherit pkgs; };
in {
  options.modules.vscode = {
    enable = mkEnableOption "visual studio code.";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      keybindings = keybindings;
      userSettings = userSettings;
      extensions = extensions;
    };
  };
}