{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };
  outputs = { self, nixpkgs }: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.thinkp71 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
      ./common/configuration.nix
      ./hosts/thinkp71/hardware-configuration.nix
      ./hosts/thinkp71/hostname.nix
      ./hosts/thinkp71/nvidia.nix
       ];
    };
    nixosConfigurations.x1carbon = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
      ./common/configuration.nix
      ./hosts/x1carbon/hardware-configuration.nix
      ./hosts/x1carbon/hostname.nix
       ];
    };
  };
}
