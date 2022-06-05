# nix-common

Some common utilities that I use.


## Passing inputs to NixOS or home-manager

```nix
# flake.nix
{
  inputs= {
    nixpkgs.url = "github:NixOS/nixpkgs/<your-branch>";

    home-manager.url = "github:nix-community/home-manager/<your-branch>";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-common.url = "github:viperML/nix-common";
    nix-common.inputs.nixpkgs.follows = "nixpkgs";

    # ...
  };

  outputs = inputs @ {self, nixpkgs, home-manager, ...}: {
    nixosConfigurations."HOSTNAME" = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      # ...
    };

    homeConfigurations."USER@HOSTNAME" = home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = {
        inherit inputs;
      };
      # ...
    };
  };
}
```
