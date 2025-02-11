# {...}: {
#   programs.ghostty = {
#     enable = true;
#     };
#
#     # enableZshIntegration = true;
#     #
#     # settings = {
#     #   shell-integration = "zsh";
#     #   font-family = "RobotoMono Nerd Font";
#     #   theme = "catppuccin-macchiato";
#     #
#     #   keybind = [
#     #     "ctrl+c=unbind"
#     #   ];
#     # };
#
# }


{...}: {
  # Install bat via home-manager module
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
