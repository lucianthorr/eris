# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, libs, pkgs, inputs, user, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "eris"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  users.users.jaylward = {
    isNormalUser = true;
    description = "Jason Aylward";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      wget
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/IUDCnv2fWHXFbZVuEb/O94wqzdvjqSrOHj6dmg/a8GjbWtoHm1HjAMwyxLHU/asKzVcrG9CJsCu8KuUB/kxD2XAyQwACVmIxntTyRGB/03MbhKMfCk1V7M7L14E6+jR5MyzNz1SMls2V5gme+3EgBOTTJ3P8Q0sq77YrBVN0uY1ssOY14R8uH9e1TgRr2IK29L0AG0R4LLk4AO0Mr0OYWKL083PkClgL43lzohVH6NpCtU009Nv/fj+y3VU6BT6f3B7sC2Hf5vsrbWf3d0P3tYhBsjusLKaoR66HpRJeaxspyeAbMZvzRPnbDeOuMRbQ3mY0olAqKWyY/iovOEKUGDn4UHw1YXbO/5pSzNIo7bRChiucLXY/iBLo2x4yeY9aRabkBw8+7+dZHcaC00UODfKnsGK0JPSM6ksnc71mk8zslpqC/YgFNJGCYzvsgakaJ/6kTLi0sArgz+OcWdNkJbDFl3qEMu63XmoHDfkK58E7nBXGZK8hZtEwwzTgGGYIlkMJBm7sPTAgI7SjV38rywKzOpYeSp/XgH6RBas2TZBaZxwA5ybGI8ekxc0vixYQLjz+4N9eDu2azzmL8LjTtl0+Cx1Ealbzr6vsuPzyiA9zNqqi2sLeIn0YtOeiLyi3kRfUM89MCHTkNk1cIR3RDjo+HM43LgfCJf6pnoYnuQ== jason.aylward@gmail.com" ];
  };

  security.sudo.wheelNeedsPassword = false;
  
  environment.systemPackages = with pkgs; [
    wget
    git
    (vim_configurable.customize {
      vimrcConfig.customRC = ''
	syntax on
	set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
      '';
    })
  ];


  services.openssh.enable = true;
  services.openssh.allowSFTP = true;
  services.sshd.enable = true;


  system.stateVersion = "22.05";  

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

}
