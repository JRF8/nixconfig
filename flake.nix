{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.2.0";
      inputs.nixpkgs.follows = "nixpkgs";
      #   inputs.rust-overlay.follows = "rust-overlay";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # my hyprland configuration
    hypr = {
      url = "github:jrf8/hypr";
      flake = false;
    };
    # actual hyprland url
    hyprland.url = "github:hyprwm/Hyprland/v0.57.2";
    hymission = {
      url = "github:gfhdhytghd/hymission";
      inputs.hyprland.follows = "hyprland";
    };
  };
  outputs =
    {
      lanzaboote,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations.thinkp71 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./common/configuration.nix
          ./hosts/thinkp71/boot.nix
          ./hosts/thinkp71/hardware-configuration.nix
          ./hosts/thinkp71/hostname.nix
          ./hosts/thinkp71/nvidia.nix
        ];
      };
      nixosConfigurations.x1carbon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          lanzaboote.nixosModules.lanzaboote
          ./common/configuration.nix
          ./hosts/x1carbon/boot.nix
          ./hosts/x1carbon/hardware-configuration.nix
          ./hosts/x1carbon/hostname.nix
        ];
      };
    };
}
