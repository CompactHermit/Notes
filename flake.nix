{
  description = "An Overengineered Notes Set:: For slacking off on my thesis";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    parts.url = "github:hercules-ci/flake-parts";
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pch = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    typst = {
      url = "github:typst/typst";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    typst-packages = {
      url = "github:/typst/packages";
      flake = false;
    };
  };
  outputs = {self, ...} @ inputs:
    inputs.parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];
      debug = true;
      imports = with inputs;
        [
          pch.flakeModule
          treefmt.flakeModule
        ]
        ++ [
          ./lib.nix
        ];
      perSystem = {
        self',
        lib,
        config,
        pkgs,
        ...
      }: {
        packages =
          {
            typst-lsp-wrapped = self.lib.makeWrapper "typst-lsp";
            typst-wrapped = self.lib.makeWrapper "typst";
            typst-dev-wrapped = self.lib.makeWrapper "typst-dev";
          }
          // (self.lib.import' ./src self pkgs);

        treefmt = {
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
            statix.enable = true;
          };
        };

        pre-commit = {
          settings = {
            settings = {
              treefmt.package = config.treefmt.build.wrapper;
            };
            hooks = {
              treefmt.enable = true;
              typstfmt = {
                enable = true;
                name = "Typst Fmt Hook";
                entry = "typstfmt";
                files = "\.typ$";
                types = ["text"];
                excludes = ["\.age"];
                language = "system";
              };
            };
          };
        };

        devShells = {
          default = pkgs.mkShell {
            name = "Awooga!";
            buildInputs = with pkgs; [typst-fmt] ++ (with self'.packages; [typst-lsp-wrapped typst-dev-wrapped typst-wrapped]);
            inputsFrom = with config; [
              treefmt.build.devShell
              pre-commit.devShell
            ];
          };
        };
      };
    };
}
