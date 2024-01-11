{
  description = "An Overengineered Notes Set:: For slacking off on my thesis/Coursework";
  outputs =
    { self, ... }@inputs:
    inputs.parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      imports = with inputs; [
        pch.flakeModule
        treefmt.flakeModule
      ];
      perSystem =
        {
          self',
          config,
          pkgs,
          fetches,
          ...
        }:
        {
          _module.args = {
            fetches = pkgs.callPackage ./_sources/generated.nix { };
            pkgs = import inputs.nixpkgs {
              system = "x86_64-linux";
              overlays = [
                (self: super: {
                  tinymist = self'.packages.tinymist-unwrapped;
                  lib = super.lib.extend (
                    fl: pl: {
                      typstHelper = import ./lib.nix {
                        pkgs = self;
                        inherit fetches;
                      };
                    }
                  );
                })
              ];
            };
          };
          #TODO:: l.fix this
          packages = {
            typst-lsp-wrapped = pkgs.lib.typstHelper.makeWrapper { package = "typst-lsp"; };
            typst-wrapped = pkgs.lib.typstHelper.makeWrapper { package = "typst"; };
            tinymist-wrapped = pkgs.lib.typstHelper.makeWrapper {
              package = "tinymist";
              flags = [ "--root ./." ];
            };
            tinymist-unwrapped = pkgs.rustPlatform.buildRustPackage {
              #pname = "tinymist";
              #version = "0.12.0";
              inherit (fetches.tinymist) pname src version;
              doCheck = false;
              logLevel = "debug";
              cargoDeps = pkgs.rustPlatform.importCargoLock {
                inherit (fetches.tinymist.cargoLock."Cargo.lock") lockFile outputHashes;
              };
            };
            allFonts = pkgs.symlinkJoin {
              name = "typst-fonts";
              paths = with pkgs; [ victor-mono ];
            };
          } // (pkgs.lib.typstHelper.import' ./src self pkgs);

          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
              statix.enable = true;
            };
          };

          pre-commit = {
            settings = {
              hooks = {
                treefmt = {
                  package = config.treefmt.build.wrapper;
                  enable = true;
                };
              };
            };
          };

          devShells = {
            default = pkgs.mkShell {
              name = "Awooga!";
              buildInputs = builtins.attrValues {
                inherit (self'.packages)
                  typst-wrapped
                  tinymist-wrapped
                  ;
                inherit (pkgs) nvfetcher;
              };
              inputsFrom = with config; [
                treefmt.build.devShell
                pre-commit.devShell
              ];
              packages = builtins.attrValues {
                inherit (pkgs)
                  just
                  typstyle
                  websocat
                  ;
              };
              TYPST_FONTS = self'.packages.allFonts;
              TYPST_FONT_PATHS = self'.packages.allFonts;
            };
          };
        };
    };
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
    #TODO:: ->> NvFetcher
    # typst-packages = {
    #   url = "github:typst/packages";
    #   flake = false;
    # };
    # tinymist = {
    #   url = "github:Myriad-Dreamin/tinymist";
    #   flake = false;
    # };
  };
}
