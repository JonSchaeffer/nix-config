{ 
  pkgs,
  outputs,
  userConfig,
  ... }:

{

  # Add machine-specific configurations here
  # Add nix-homebrew configuration
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "${userConfig.name}";
    autoMigrate = true;
  };
    # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Nix settings
  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  nix.optimise.automatic = true;

  nix.package = pkgs.nix;

  # Enable Nix daemon
  services.nix-daemon.enable = true;

  # User configuration
  users.users.${userConfig.name} = {
    name = "${userConfig.name}";
    home = "/Users/${userConfig.name}";
  };

  # Add ability to use TouchID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # System settings
  system = {
    defaults = { 
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        AppleInterfaceStyle = "Dark";
        "com.apple.swipescrolldirection" = true;
        };
        dock = {
          autohide = true;
          mru-spaces = false;
          orientation = "bottom";
          tilesize = 34;
          show-recents = false;
        };
        finder = {
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true;
          FXPreferredViewStyle = "clmv";
          ShowStatusBar = true;
        };
        WindowManager = {
          EnableStandardClickToShowDesktop = false;
        };
        screencapture = {
          location = "/Users/${userConfig.name}/Pictures/Screenshots";
          type = "png";
          disable-shadow = true;
        };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  # Zsh configuration
  programs.zsh.enable = true;

  # Fonts configuration
  fonts.packages = with pkgs; [
    roboto
  ];

  # Homebrew
  homebrew = {
    enable = true;
    casks = [
      "arc"
      "bruno"
      "chef-workstation"
      "flux"
      "ghostty"
      "google-cloud-sdk"
      "lm-studio"
      "meetingbar"
      "obsidian"
      "raycast"
      "spotify"
      "tableplus"
      "unnaturalscrollwheels"
      "zen-browser"
    ];
    brews = [ 
      "bash"
      "bat"
      "cfssl"
      "colima"
      "dagger"
      "docker"
      "docker-buildx"
      "docker-compose"
      "docker-credential-helper"
      "flux"
      "fzf"
      "gcc"
      "gh"
      "git"
      "glib"
      "go"
      "gpg"
      "helm"
      "infrahq/tap/infra"
      "jq"
      "k3d"
      "k9s"
      "kind"
      "kube-ps1"
      "kubecolor"
      "kubectx"
      "kubernetes-cli"
      "kubeseal"
      "lazygit"
      "minikube"
      "neovim"
      "ripgrep"
      "sshpass"
      "terraform"
      "tilt"
      "tmux"
      "tree"
      "vcluster"
      "wget"
      "yazi"
      "yq"
      "zoxide"
      "zsh-syntax-highlighting"
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;
}

