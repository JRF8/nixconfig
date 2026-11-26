{ inputs, pkgs, ... }:

let
  hyprPkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  # System packages
  environment.systemPackages = with pkgs; [
    brightnessctl
    pulseaudio
    playerctl
    # SDDM theme
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha"; # latte | frappe | macchiato | mocha
      accent = "mauve";
      font = "Noto Sans";
      fontSize = "9";
      # background = "${../wallpapers/login.png}";   # optional, path must be tracked in git
      # loginBackground = true;                      # optional, backdrop behind the login box
    })
    # hymission
    inputs.hymission.packages.${pkgs.stdenv.hostPlatform.system}.default
    # some icon theming
    papirus-icon-theme
    # some LSP stuff for neovim
    nixd
    nixfmt
    lua-language-server
    stylua
    ripgrep
    fd
    gcc
    tree-sitter
  ];

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true; # Recommended for systemd integration
    xwayland.enable = true;
    package = hyprPkgs.hyprland;
    portalPackage = hyprPkgs.xdg-desktop-portal-hyprland;
  };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # Set up dux-shell
  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
  };

  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    config = {
      user = {
        name = "jesse";
        email = "jesse.frazier.8@gmail.com";
      };
    };
  };

  # Neovim setup and LSP
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # zsh
  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
