{ inputs, ... }:
{
  home.username = "jesse";
  home.homeDirectory = "/home/jesse";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  # alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 12.0;
      window.opacity = 0.9;
    };
  };

  # hyprland
  xdg.configFile."hypr".source = inputs.hypr;

  # zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";

    initContent = ''
      PS1='%F{cyan}%n@%m%f %F{yellow}%~%f %# '
    '';
  };

}
