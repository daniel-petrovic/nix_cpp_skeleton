{
  description = "my test project";

  inputs = {

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    utils = {
      url = "github:numtide/flake-utils";
    };
  };


  outputs = {nixpkgs, utils, ...}: utils.lib.eachDefaultSystem (system:

    let
      pkgs = import nixpkgs { inherit system; };
      llvm = pkgs.llvmPackages_latest;
      lib = nixpkgs.lib;

    in rec {

      devShell = pkgs.mkShell rec {
        name = "my-app";

        nativeBuildInputs = [
          # builder
          # p.gnumake
          # p.bear
          pkgs.cmake
          llvm.lldb

          # XXX: the order of include matters
          pkgs.clang-tools
          llvm.clang #clangd
        ];

        buildInputs = [
          llvm.libcxx
          pkgs.boost
        ];

        CPATH = builtins.concatStringsSep ":" [
          (lib.makeSearchPathOutput "dev" "include" [llvm.libcxx])
          (lib.makeSearchPath "resource-root/include" [llvm.clang])
        ];

        shellHook = ''
          CC=clang
          CXX=clang++
          PS1="(nix-shell):\w\n>"
        '';

      }; # {} devShell

    }
  );

}
