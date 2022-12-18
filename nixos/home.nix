{ config, lib, pkgs, user, ... }:

{

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      httpie
      htop
      go
    ];
    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };
  #services = {
  #};
}
