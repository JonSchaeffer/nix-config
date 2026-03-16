{
  ... }:

{
  imports = [
    ../common.nix
  ];

  # Machine-specific homebrew packages
  homebrew = {
    casks = [
      "discord"
      "flux"
      "orbstack"
      "plex"
    ];
    brews = [
      "age"
      "sops"
    ];
  };
}
