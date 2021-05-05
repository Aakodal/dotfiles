{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nebula";

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  hardware.nvidia.prime = {
    sync.enable = true;
    nvidiaBusId = "PCI:4:0:0";
    intelBusId = "PCI:0:2:0";
  };

  nixpkgs.config.allowUnfree = true;

  location = {
    latitude = 48.1;
    longitude = 11.6;
  };

  services = {
    printing.enable = true;

    xserver = {
      enable = true;
      libinput.enable = true;

      videoDrivers = [ "nvidia" ];

      layout = "fr";
      xkbOptions = "eurosign:e";

      displayManager.lightdm.enable = true;
      desktopManager.cinnamon.enable = true;
    };

    redshift = {
      enable = true;
      temperature = {
        day = 4600;
        night = 4600;
      };
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  fonts.fontconfig = {
    enable = true;
    defaultFonts.emoji = [ "Noto Color Emoji" "Twitter Color Emoji" ];
  };

  users.users.aakodal = {
    isNormalUser = true;
    description = "Aakodal";
    createHome = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    promptInit = ''
      export GPG_TTY=$(tty)
      prompt_context() {}
      prompt_status() {
        local -a symbols
        [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
        [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
        [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

        [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
      }
    '';

    ohMyZsh = {
      enable = true;
      theme = "agnoster";
    };
  };

  environment.systemPackages = with pkgs; [ vim git ];

  system.stateVersion = "20.09";
}
