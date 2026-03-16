{
  ... }:

{
  imports = [
    ../common.nix
  ];

  # Machine-specific homebrew packages
  homebrew = {
    casks = [
      "chef-workstation"
      "raycast"
      "spotify"
      "zen-browser"
    ];
    brews = [
      "colima"
      "docker"
      "docker-buildx"
      "docker-compose"
      "docker-credential-helper"
      "gpg"
      "infrahq/tap/infra"
    ];
  };
}
