{...}: {
  # Install and configure Golang via home-manager module
  programs.go = {
    enable = true;
    env = {
      GOBIN = "$HOME/go/bin";
      GOPATH = "$HOME/go";
    };
  };

  # Ensure Go bin in the PATH
  home.sessionPath = [
    "$HOME/go/bin"
  ];
}
