{ config, pkgs, ... }:

{

  # System packages
  environment.systemPackages = with pkgs; [
    brightnessctl
    pulseaudio
    playerctl
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
