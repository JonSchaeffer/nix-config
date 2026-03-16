{
  ... }:

{
  imports = [
    ../common.nix
  ];

  # Machine-specific homebrew packages
  homebrew = {
    casks = [
      "1password"
      "discord"
      "flux"
      "orbstack"
      "plex"
      "raycast"
      "spotify"
    ];
    brews = [
      "age"
      "flux"
      "sops"
    ];
  };
}
