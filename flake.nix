{
  description = "Minimal JS/TS fullstack dev shell (sqlite + postgres clients)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { 
		inherit system; 
		config = {
				allowUnfree = true;
		};  
	};
    nodePkgs = pkgs.nodePackages;
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "js-ts-fullstack";

      buildInputs = with pkgs; [
        go
		gopls
        sqlite                   # sqlite3 CLI + lib
        postgresql               
        git
        curl
        gcc                      # for building native npm modules if needed
      ];

      # helpful environment variables for node-gyp / native builds
		shellHook = ''
		echo "🧰 go shell — go, sqlite, & postgresql clients available"
        echo "Run: nix develop  → then: go/sqlite/curl"
      '';
    };
  };
}
