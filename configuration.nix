{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking
  networking.hostName = "lainix";
  networking.networkmanager.enable = true;

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # networking.firewall.enable = false;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # time / locale
  time.timeZone = "Asia/Hong_Kong";

  i18n.defaultLocale = "zh_HK.UTF-8";
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
  };

  i18n.inputMethod.fcitx5 = {
    waylandFrontend = true;

    addons = with pkgs; [
      kdePackages.fcitx5-chinese-addons
      fcitx5-table-extra
      fcitx5-mozc
    ];

    ignoreUserConfig = true;

    settings.globalOptions."Hotkey/TriggerKeys"."0" = "Alt+Shift_L";
    settings.inputMethod = {
      "Groups/0" = {
        "Name" = "Default";
        "Default Layout" = "us";
        "DefaultIM" = "keyboard-us";
      };

      "Groups/0/Items/0" = {
        "Name" = "keyboard-us";
        "Layout" = "us";
      };

      "Groups/0/Items/1" = {
        "Name" = "cangjie3";
        "Layout" = "us";
      };

      "GroupOrder" = {
        "0" = "Default";
      };
    };
  };

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  security.pam.services = {
    sudo.fprintAuth = true;
    login.fprintAuth = true;
  };

  # user accounts, set password with ‘passwd’.
  users.users.lain = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
    ];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  };

  # services
  services.fprintd.enable = true;
  services.greetd.enable = true;
  services.libinput.enable = true;
  services.openssh.enable = true;
  services.pipewire.enable = true;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = true;
  services.ntp.enable = true;

  # services.dunst.enable = true;

  services.greetd.settings.default_session = {
    command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --remember --cmd mango";
    user = "greeter";
  };

  services.pipewire.pulse.enable = true;

  services.ntp.servers = [
    "time.hko.hk"
    "stdtime.gov.hk"
  ];

  # programs
  programs.bat.enable = true;
  programs.firefox.enable = true;
  programs.foot.enable = true;
  programs.git.enable = true;
  programs.localsend.enable = true;
  programs.mango.enable = true;
  programs.nano.enable = false;
  programs.steam.enable = true;
  programs.neovim.enable = true;
  programs.vim.enable = true;
  programs.vscode.enable = true;
  # programs.waybar.enable = true;
  programs.zsh.enable = true;

  # system packages (https://search.nixos.org/)
  environment.systemPackages = with pkgs; [

    discord

    jq
    file
    sioyek

    # clipboard
    wl-clipboard
    wl-clip-persist 
    cliphist

    bibata-cursors  
    brightnessctl
    btop
    chezmoi
    dragon-drop
    fastfetch
    fuzzel
    fzf
    rofi
    imgbrd-grabber
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.okular
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    kdePackages.polkit-kde-agent-1
    libreoffice

    mako
    libnotify

    grim
    slurp

    mpv
    nixd
    nixfmt
    ntfs3g
    obsidian
    pywal16
    pywalfox-native
    qalculate-qt
    qbittorrent
    rclone
    swaybg
    tree
    wget
    xournalpp
    yazi
    inputs.waybar-git.packages.${pkgs.system}.default
  ];

  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.iosevka
    nerd-fonts.fira-code
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  nixpkgs.config.allowUnfree = true;

  # environment variables
  environment.variables.EDITOR = "nvim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];
  

  nix.settings.substituters = [
    "https://mirror.sjtu.edu.cn/nix-channels/store" # Shanghai Jiao Tong University - best for Asia
    "https://mirrors.ustc.edu.cn/nix-channels/store" # USTC backup mirror
    "https://cache.nixos.org" # Official global cache
    "https://nix-community.cachix.org" # Community packages
  ];

  nix.settings.use-xdg-base-directories = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
