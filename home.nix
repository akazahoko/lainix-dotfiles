{ pkgs, inputs, ... }:

{
  home.username = "lain";
  home.homeDirectory = "/home/lain";
  home.stateVersion = "26.05";

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style.name = "kvantum";
  };

  programs.firefox = {
    enable = true;
    configPath = "/home/lain/.config/mozilla/firefox";

    profiles.default.extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
      ublock-origin
      bitwarden
      privacy-badger
      pywalfox
      stylus
    ];
  };

  programs.vscode = {
    enable = true;

    mutableExtensionsDir = true;

    profiles.default = {
      extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
        bbenoist.nix
        jnoortheen.nix-ide
        ms-ceintl.vscode-language-pack-zh-hant
        # dlasagno.wal-theme (disabled mutablity issue)
      ];
      userSettings = {
        "workbench.colorTheme" = "Wal";
        "locale" = "zh-tw";
        "editor.tabSize" = 4;
        "editor.insertSpaces" = true;
        "editor.fontFamily" = "FiraCode Nerd Font Mono";
        "editor.fontSize" = 14;
      };
    };
  };
}
