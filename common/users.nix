{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jesse = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      tmux
      rofi
      alacritty
      ripgrep
      htop
      btop
      google-chrome
      flameshot
      hyprshot
      (callPackage ./pkgs/flexbv.nix { })
      localsend
      obsidian
      spotify
      discord
      fastfetch
      cava
    ];
  };
}
