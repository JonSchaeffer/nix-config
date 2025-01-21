{ config, pkgs, ... }:

{
  imports = [
    ../modules/common.nix
    # Add other relevant modules
  ];

   # Enable home-manager
  programs.home-manager.enable = true;

  # Ensure homebrew is in the PATH
  home.sessionPath = [
    "/opt/homebrew/bin/"
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  # Add user-specific configurations here
}
