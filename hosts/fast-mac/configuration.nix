{
  ... }:

{
  imports = [
    ../common.nix
  ];

  # Machine-specific homebrew packages
  homebrew = {
    casks = [
      "chef-workstation"
      "gcloud-cli"
      "session-manager-plugin"
      "zed"
    ];
    brews = [
      "awscli"
      "cmctl"
      "colima"
      "docker"
      "docker-buildx"
      "docker-compose"
      "docker-credential-helper"
      "envoy"
      "findutils"
      "golangci-lint"
      "gpg"
      "hashicorp/tap/vault"
      "infrahq/tap/infra"
      "k6"
      "mkcert"
      "nats-io/nats-tools/nats"
      "node"
      "tilt-dev/tap/ctlptl"
      "watch"
      "worktrunk"
      "yamlfmt"
    ];
  };
}
