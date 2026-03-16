{
  ... }:

{
  imports = [
    ../common.nix
  ];

  # Override dock tilesize for this machine
  system.defaults.dock.tilesize = 27;

  # Machine-specific homebrew packages
  homebrew = {
    casks = [
      "orbstack"
    ];
    brews = [
      "age"
      "ansible"
      "flux"
      "hugo"
      "istioctl"
      "python@3.12"
      "qemu"
      "sops"
      "tailscale"
      "tmux-fingers"
    ];
  };
}
