{ ... }:
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

}
