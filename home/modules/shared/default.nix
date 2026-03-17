{outputs, ...}: {
imports = [
  ./bat.nix
  ./fzf.nix
  ./git.nix
  ./go.nix
  ./ghostty.nix
  ./home.nix
  ./lazygit.nix
  ./neovim.nix
  ./scripts.nix
  ./tmux.nix
  ./zsh.nix
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

# Catppuccin flavor and accent
catppuccin = {
  flavor = "macchiato";
  accent = "lavender";
  };
}
