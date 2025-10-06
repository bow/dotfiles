{
  description = "Personal dotfiles";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      ...
    }:
    {
      files = {
        alacritty = ./alacritty;
        bash = ./bash;
        bat = ./bat;
        clang-format = ./clang-format;
        conda = ./conda;
        dig = ./dig;
        direnv = ./direnv;
        elixir = ./elixir;
        environment.d = ./environment.d;
        ghostty = ./ghostty;
        gitconfig = ./gitconfig;
        gitignore = ./gitignore;
        i3 = ./i3;
        ignore = ./ignore;
        ncmpcpp = ./ncmpcpp;
        nvim = ./nvim;
        ocaml = ./ocaml;
        picom = ./picom;
        polybar = ./polybar;
        postgresql = ./postgresql;
        r = ./r;
        rofi = ./rofi;
        readline = ./readline;
        redshift = ./redshift;
        ripgrep = ./ripgrep;
        sqlite = ./sqlite;
        starship = ./starship;
        systemd = ./systemd;
        tmux = ./tmux;
        xorg = ./xorg;
        xterm = ./xterm;
        xdg = ./xdg;
        yazi = ./yazi;
        zathura = ./zathura;
      };
    }
    // (
      let
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
        forAllSystems = nixpkgs-unstable.lib.genAttrs systems;
      in
      {
        devShells = forAllSystems (system: {
          default =
            let
              pkgs = import nixpkgs-unstable { inherit system; };
            in
            pkgs.mkShellNoCC {
              packages = with pkgs; [
                nixfmt-rfc-style
                deadnix
                statix
              ];
            };
        });
        formatter = forAllSystems (system: nixpkgs-unstable.legacyPackages.${system}.nixfmt-rfc-style);
      }
    );
}
