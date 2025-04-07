{outputs, ...}: {
imports = [
  ../modules/bat.nix
  ../modules/fzf.nix
  ../modules/git.nix
  ../modules/go.nix
  ../modules/ghostty.nix
  ../modules/home.nix
  ../modules/lazygit.nix
  #../modules/neovim.nix
  ../modules/scripts.nix
  ../modules/tmux.nix
  ../modules/zsh.nix
];

# Nixpkgs configuration
nixpkgs = {
  overlays = [
    outputs.overlays.stable-packages
  ];

  config = {
    allowUnfree = true;
  };
};

# Catpuccin flavor and accent
catppuccin = {
  flavor = "macchiato";
  accent = "lavender";
  };
}
