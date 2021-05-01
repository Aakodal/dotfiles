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
      wget curl zip unzip screenfetch feh bat brightnessctl gnupg neofetch findutils pulseaudio-ctl intltool

      # Image
      gimp

      # DE utils
      unstable.gnome3.file-roller unstable.cinnamon.xviewer vlc

      # Fonts
      powerline-fonts roboto source-code-pro noto-fonts-emoji dejavu_fonts jetbrains-mono ubuntu_font_family lato twitter-color-emoji

      # Terminal & shell
      alacritty zsh

      # Editors
      unstable.vscodium unstable.jetbrains.idea-ultimate unstable.jetbrains.webstorm
      # unstable.jetbrains.clion

      # Dev
      unstable.nodejs-16_x unstable.python39 adoptopenjdk-bin

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
