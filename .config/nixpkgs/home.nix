{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config.allowUnfree = true; };
in
{
  programs = {
    home-manager.enable = true;
    alacritty = import ./alacritty.nix { inherit pkgs; };

    git = {
      enable = true;
      userName = "Aakodal";
      userEmail = "neshelldev" + "@" +"gmail.com";
      signing = {
        key = "1ADE44794B82AE0C";
        signByDefault = true;
      };
    };
  };

  nixpkgs.overlays = [
    (self: super: {
      discord-canary = super.discord-canary.overrideAttrs (_: {
        src = builtins.fetchTarball
          "https://discord.com/api/download/canary?platform=linux&format=tar.gz";
      });
    })
  ];

  home = {
    username = "aakodal";
    homeDirectory = "/home/aakodal";

    packages = with pkgs; [
      # Utilities
      wget curl zip unzip screenfetch feh bat brightnessctl gnupg neofetch findutils

      # Fonts
      powerline-fonts roboto source-code-pro dejavu_fonts noto-fonts-emoji jetbrains-mono ubuntu_font_family lato

      # Terminal & shell
      alacritty zsh

      # Editors
      unstable.vscodium

      # Dev
      unstable.nodejs-16_x

      # Browser
      firefox ungoogled-chromium

      # Chat
      discord-canary hexchat
    ];
  };

  services = {
    redshift = {
      enable = true;
      temperature = {
        day = 4600;
        night = 4600;
      };
      latitude = "48.1";
      longitude = "11.6";
    };

    gpg-agent = {
      enable = true;
    };
  };

  home.stateVersion = "20.09";
}
