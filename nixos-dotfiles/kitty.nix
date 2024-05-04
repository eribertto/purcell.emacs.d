{ lib
, config
, ...
}:
let
  inherit (lib) types mkIf mkOption mkBefore getExe;

  cfg = config.custom.terminal.kitty;
in
{
  options.custom.terminal.kitty = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Kitty terminal";
    };
  };

  config = mkIf cfg.enable {
    # custom.gnome = {
      #   # Add desktop entry to gnome favorites
      #   favorites = mkBefore [ "kitty.desktop" ];
      # };

      programs.kitty = {
        enable = true;

        # Enable shell completions (etc) for kitty command
        shellIntegration.enableBashIntegration = true;
        # shellIntegration.enableFishIntegration = true;

        # TODO define theme somewhere in config
        theme = "Catppuccin-Mocha";

        keybindings = {
          "ctrl+c" = "copy_and_clear_or_interrupt";
          "ctrl+shift+c" = "copy_to_clipboard";
        };

        # TODO use fonts defined in nix config
        font = {
          name = "FiraCode";
          size = 18;
        };
      };
  };
}
