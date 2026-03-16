{...}: {
  # Zsh shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "ansible"
        "copypath"
        "docker"
        "docker-compose"
        "encode64"
        "fluxcd"
        "gh"
        "git"
        "golang"
        "helm"
        "kubectl"
        "kubectx"
        "ssh"
        "tailscale"
        "zsh-autosuggestions"
      ];
    };

    shellAliases = {
      # k9s
      k9sdev = "k9s --context infra:dev-awsuse2 -n api-services";
      k9sstag = "k9s --context infra:stg-awsuse2 -n api-services";
      k9sprod = "k9s --context infra:prd-awsuse2 -n api-services";

      # Open Obsidian Notes
      notes = "cd \"$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents\"";

      # Use bat over cat
      cat = "bat --paging=never";

      # Use kubecolor over kubectl
      kubectl = "kubecolor";

      # nvim
      v = "nvim";
      vi = "nvim";
      vim = "nvim";

      # github
      ghpr = "gh pr create --fill --template pull_request_template.md --draft";

      # search shell history
      hs = "history | grep";
    };

    initExtra = ''
      export EDITOR=nvim
      export GPG_TTY=$(tty)
      export LIBVIRT_DEFAULT_URI=qemu:///system
      zstyle ':omz:update' mode auto
      export INFRA_SERVER=infra.plat.k8s.secretcdn.net
      export INFRA_PROVIDER=okta
      export INFRA_SKIP_VERSION_CHECK=true
      export ANTHROPIC_DEFAULT_SONNET_MODEL="arn:aws:bedrock:us-east-2:635784355978:inference-profile/global.anthropic.claude-sonnet-4-5-20250929-v1:0"
      export ANTHROPIC_MODEL="arn:aws:bedrock:us-east-2:635784355978:inference-profile/global.anthropic.claude-opus-4-5-20251101-v1:0"
      # Bedrock
      export AWS_PROFILE=bedrock
      export AWS_REGION=us-east-2

      # OpenCode-specific env vars
      export GOOGLE_VERTEX_PROJECT=vertexai-core-products-6970
      export GOOGLE_VERTEX_LOCATION=global

      # Krew plugin support
      export PATH="''${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

      # Opencode
      export PATH=$HOME/.opencode/bin:$PATH

      # Kubectx right prompt
      RPS1='$(kubectx_prompt_info)'

      autoload -U +X bashcompinit && bashcompinit
      complete -o nospace -C /opt/homebrew/bin/terraform terraform

      eval "$(zoxide init --cmd cd zsh)"
    '';
  };
}
