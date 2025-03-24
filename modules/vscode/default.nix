{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  module = baseNameOf ./.;
  cfg = config.modules.${module};
  keybindings = pkgs.lib.importJSON ./keybindings.json;
  userSettings = pkgs.lib.importJSON ./settings.json;
  extensions = import ./extensions.nix {inherit pkgs;};
in {
  options.modules.${module} = {
    enable = mkEnableOption "visual studio code.";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      profiles.default = {
        keybindings = keybindings;
        userSettings = userSettings;
        extensions = extensions;
      };
    };
  };
}
