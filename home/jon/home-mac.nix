{ ... }:

{
  imports = [
    ../modules/home-mac
  ];

   # Enable home-manager
  programs.home-manager.enable = true;

  # Ensure homebrew is in the PATH
  home.sessionPath = [
    "/opt/homebrew/bin/"
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
