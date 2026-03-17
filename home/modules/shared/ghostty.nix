{...}: {
  # Ghostty terminal configuration (currently disabled)
  programs.ghostty = {
    enable = false;
    enableZshIntegration = true;
    settings = {
      shell-integration = "zsh";
      font-family = "RobotoMono Nerd Font";
      theme = "catppuccin-macchiato";

      keybind = [
        "ctrl+c=unbind"
      ];
    };
  };
}
