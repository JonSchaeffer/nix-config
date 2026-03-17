{pkgs, ...}: {
  # Neovim text editor configuration
  # NOTE: The lua config in files/configs/nvim/ is managed manually (not via nix)
  # because lazy.nvim needs write access to lazy-lock.json in ~/.config/nvim/
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    extraPackages = with pkgs; [
      golangci-lint
      gopls
      gotools
      markdownlint-cli
      shellcheck
      yaml-language-server
    ];
  };
}
