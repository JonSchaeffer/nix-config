{...}: {
  # Zsh shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      # k9s
      k9sdev = "k9s --context infra:dev-awsuse2 -n api-services";
      k9sstag = "k9s --context infra:stg-awsuse2 -n api-services";
      k9sprod = "k9s --context infra:prd-awsuse2 -n api-services";

      # Open Obisdian Notes
      notes="cd /Users/jon/Library/Mobile Documents/iCloud~md~obsidian/Documents";
      
      # Make a daily node
      day = "~/.config/scripts/day";

      # Make a new Weekly 1-1 note
      ooo = "~/.config/scripts/ooo";

      # Make a new note
      newnote = "~/.config/scripts/newnote";

      # Use bat over cat
      cat = "bat --paging=never";

      # User kubecolor over kubectl
      kubectl="kubecolor";

      # nvim
      v = "nvim";
      vi = "nvim";
      vim = "nvim";

      # github
      ghpr = "gh pr create --fill --template pull_request_template.md -draft";
    };
    initExtra = ''
      # Path to your oh-my-zsh installation.
      export EDITOR=nvim
      export ZSH="$HOME/.oh-my-zsh"
      export LIBVIRT_DEFAULT_URI=qemu:///system
      ZSH_THEME="agnoster"
      zstyle ':omz:update' mode auto      # update automatically without asking
      export INFRA_SERVER=infra.plat.k8s.secretcdn.net
      export INFRA_PROVIDER=okta
      export INFRA_SKIP_VERSION_CHECK=true

      plugins=(
        ansible
        copypath
        docker
        docker-compose
        encode64
        fluxcd
        gh
        git
        golang
        helm
        kubectl
        kubectx
        ssh
        tailscale
        zsh-autosuggestions
      )


      source $ZSH/oh-my-zsh.sh
      autoload -U +X bashcompinit && bashcompinit
      complete -o nospace -C /opt/homebrew/bin/terraform terraform

      # Kubectx config
      # right prompt
      RPS1='$(kubectx_prompt_info)'

      eval "$(zoxide init --cmd cd zsh)"
      source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    '';
  };
}
