{
  pkgs,
  lib,
  outputs,
  userConfig,
  ... }:

{
  # nix-homebrew configuration
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "${userConfig.name}";
    autoMigrate = true;
    onActivation.cleanup = "uninstall";
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

  # Garbage collection
  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; Hour = 2; Minute = 0; };
    options = "--delete-older-than 30d";
  };

  # User configuration
  users.users.${userConfig.name} = {
    name = "${userConfig.name}";
    home = "/Users/${userConfig.name}";
  };

  # System settings
  system = {
    primaryUser = userConfig.name;
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
        tilesize = lib.mkDefault 34;
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

  # Homebrew — common packages across all machines
  # Machine-specific packages are added in each host's configuration.nix
  homebrew = {
    enable = true;
    casks = [
      "bruno"
      "ghostty"
      "google-cloud-sdk"
      "meetingbar"
      "obsidian"
      "tableplus"
      "unnaturalscrollwheels"
    ];
    brews = [
      "bash"
      "cfssl"
      "dagger"
      "gcc"
      "gh"
      "glib"
      "helm"
      "jq"
      "k3d"
      "k9s"
      "kind"
      "kube-ps1"
      "kubecolor"
      "kubectx"
      "kubernetes-cli"
      "kubeseal"
      "minikube"
      "ripgrep"
      "sshpass"
      "terraform"
      "tilt"
      "tree"
      "vcluster"
      "wget"
      "yazi"
      "yq"
      "zoxide"
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;
}
