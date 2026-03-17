{pkgs, ...}: {
  imports = [
    ../shared
    ./opencode.nix
  ];

  home.packages = [
    pkgs.python312
  ];
}
