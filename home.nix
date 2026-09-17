{ pkgs, inputs, ... }:

{
  home.username = "lain";
  home.homeDirectory = "/home/lain";
  home.stateVersion = "26.05";

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.kde.okular.desktop" ];
    };
  };

  programs.firefox = {
    enable = true;
    configPath = "/home/lain/.config/mozilla/firefox";


    profiles.default.extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
      ublock-origin
      bitwarden
      privacy-badger
      pywalfox
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
      };
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      "nfu" = "sudo nix flake update --flake /home/lain/nixos";
      "nrsf" = "sudo nixos-rebuild switch --flake /home/lain/nixos#";
    };
    oh-my-zsh.enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initContent = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}
