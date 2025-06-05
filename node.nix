{
  description = "node+pnpm";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          pkgs.nodejs_24
          pkgs.corepack_24
        ];
        shellHook = ''
          mkdir -p "$PWD/.node/bin"

          export COREPACK_HOME="$PWD/.corepack"
          export npm_config_store_dir="$PWD/.pnpm/store"
          export npm_config_cache_dir="$PWD/.pnpm/cache"
          export npm_config_state_dir="$PWD/.pnpm/state"
          export npm_config_global_dir="$PWD/.pnpm/global"
          export npm_config_global_bin_dir="$PWD/.pnpm/global/bin"
          export PNPM_HOME="$PWD/.pnpm/home"
          export PATH="$npm_config_global_bin_dir:$PATH"
          export PATH="$PWD/.node/bin:$PATH"
          corepack enable --install-directory "$PWD/.node/bin"
          corepack prepare pnpm@latest --activate

          # install vercel cli
          # pnpm install -g vercel
        '';
      };
    });
}
