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
    enable = mkEnableOption "Enable my fonts, namely fira-code with nerdfonts. Note that this is required for modules that use the nerdfont icons to function properly.";
  };

  config = mkIf cfg.enable {
    # Allows installed fonts to be discoverable by OS
    fonts.fontconfig.enable = true;

    # Set fonts
    xdg.configFile = {
      "fontconfig/fonts.conf".text = ''
        <alias>
        	<family>monospace</family>
        	<prefer>
        		<family>FiraCode Nerd Font</family>
        		<family>Inconsolata</family>
        		<family>DejaVu Sans Mono</family>
        	</prefer>
        </alias>
      '';
    };

    home.packages = with pkgs; [
      # Fonts
      (nerdfonts.override {fonts = ["FiraCode"];})
      fira-code
    ];
  };
}