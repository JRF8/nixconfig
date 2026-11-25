{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.printing = {
    enable = true;
    drivers = [ pkgs.epson-escpr2 ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # only needed if connecting over USB
  services.ipp-usb.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Enable SDDM with Wayland greeter support
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "catppuccin-mocha-mauve";
  };

  # List services that you want to enable:
  services.upower.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  services.syncthing = {
    enable = true;
    user = "jesse";
    group = "users";
    dataDir = "/home/jesse";
    configDir = "/home/jesse/.config/syncthing";
    openDefaultPorts = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
