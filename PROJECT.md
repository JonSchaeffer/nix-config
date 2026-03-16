# nix-config Audit

## Overview

This is a **nix-darwin + home-manager + Nix Flakes** configuration managing three Apple Silicon Macs:

| Machine | Host Config | HM Entry | Username | Purpose |
|---|---|---|---|---|
| `fast-mac` | `hosts/fast-mac/configuration.nix` | `home/jon.schaeffer/fast-mac.nix` | `jon.schaeffer` | Work (Fastly) |
| `dl-mac` | `hosts/dl-mac/configuration.nix` | `home/jon/dl-mac.nix` | `jon` | Personal laptop |
| `home-mac` | `hosts/home-mac/configuration.nix` | `home/jon/home-mac.nix` | `jon` | Home machine |

**Channels**: `nixpkgs-unstable` (primary), `nixpkgs-stable` 24.11 (available as `pkgs.stable` via overlay)

**Architecture**: flake.nix defines helper functions (`mkDarwinConfiguration`, `mkHomeConfiguration`) that wire up per-host system configs and per-user home-manager configs. A `users` attrset centralizes user metadata (name, email, fullName) and passes it via `specialArgs`.

---

## Changes Applied

All 20 issues from the audit have been addressed. Here's what was done:

### Bug Fixes

| # | Issue | Fix Applied |
|---|---|---|
| 1 | `"fozf"` typo in fast-mac | Fixed to `"fzf"` — resolved via host config refactor (fzf removed from homebrew entirely, now managed by `fzf.nix` HM module) |
| 2 | `systemd.user.startServices` on macOS | Removed from all three HM entry files (`fast-mac.nix`, `dl-mac.nix`, `home-mac.nix`) |
| 3 | `home-mac` missing `system.primaryUser` | Added via `hosts/common.nix` which sets `system.primaryUser = userConfig.name` for all hosts |
| 4 | Deprecated `services.nix-daemon.enable` | Removed from `dl-mac` and `home-mac` — no longer present in any host config |
| 5 | Hard-coded `/Users/jon/` in scripts | Replaced with `$HOME/` in `files/scripts/day`, `files/scripts/newnote`, `files/scripts/ooo` |
| 6 | Hard-coded `/Users/jon/` in `notes` alias | Changed to `cd "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents"` with proper quoting |
| 7 | `ghpr` alias `-draft` flag | Changed to `--draft` |
| 8 | Script aliases pointing to wrong path | Removed the `day`, `ooo`, `newnote` aliases entirely — the scripts are on `$PATH` via `scripts.nix` deploying to `~/.local/bin/` |

### Quality Fixes

| # | Issue | Fix Applied |
|---|---|---|
| 9 | `wl-copy` in fzf.nix | Changed to `pbcopy` (macOS native clipboard) |
| 10 | Catppuccin tmux theme conflict | Removed the TPM `catppuccin/tmux` plugin and all old `@catppuccin_flavour 'frappe'` settings from `extraConfig`. The nix catppuccin module (`catppuccin.tmux.enable = true` with `macchiato` flavor) is now the single source of truth |
| 11 | Duplicate tmux settings | Removed duplicate `set -g` lines for base-index, mode-keys, mouse, default-terminal, and prefix from `extraConfig`. These are now only set via HM module options. Added `prefix = "C-a"` to module options |
| 12 | Nix vs Homebrew package duplication | Removed `bat`, `fzf`, `git`, `go`, `lazygit`, `tmux`, `neovim`, `zsh-syntax-highlighting` from all Homebrew brews lists. These are now managed exclusively via home-manager modules |
| 13 | Unused `nixos-hardware` input | Removed from `flake.nix` |
| 14 | Redundant Go PATH entries | Removed `export PATH="$HOME/go/bin:$PATH"` from `zsh.nix`. Go PATH is now managed only by `go.nix` via `home.sessionPath` |

### Structural Improvements

| # | Issue | Fix Applied |
|---|---|---|
| 15 | Host config duplication | Created `hosts/common.nix` with all shared configuration (nix-homebrew, nixpkgs, nix settings, system defaults, fonts, common homebrew packages). Each host's `configuration.nix` now imports `common.nix` and only defines machine-specific homebrew packages and setting overrides |
| 16 | Manual oh-my-zsh management | Migrated to `programs.zsh.oh-my-zsh` HM module with `enable = true`, `theme = "agnoster"`, and all plugins defined declaratively. Removed manual `ZSH=`, `ZSH_THEME=`, `plugins=(...)`, and `source $ZSH/oh-my-zsh.sh` from `initExtra` |
| 17 | Syntax highlighting via Homebrew | Enabled `programs.zsh.syntaxHighlighting.enable = true` in HM module. Removed manual `source /opt/homebrew/share/zsh-syntax-highlighting/...` line and `zsh-syntax-highlighting` from all Homebrew brews lists |
| 18 | No garbage collection | Added `nix.gc` config in `hosts/common.nix`: automatic weekly GC on Sundays at 2am, deleting generations older than 30 days |
| 19 | ghostty.nix dead code | Removed the commented-out block at the top of the file |
| 20 | Neovim in limbo | Re-enabled `neovim.nix` import in `home/modules/common.nix` and removed `neovim` from all Homebrew brews lists. The nix module installs neovim with LSP packages (gopls, shellcheck, yaml-language-server, etc.) and symlinks the lua config from `files/configs/nvim/` |

---

## Architecture After Changes

### File Structure

```
hosts/
  common.nix                    # NEW: shared nix-darwin config for all machines
  fast-mac/configuration.nix    # Imports common.nix + work-specific homebrew
  dl-mac/configuration.nix      # Imports common.nix + personal-specific homebrew
  home-mac/configuration.nix    # Imports common.nix + home-specific homebrew

home/
  modules/
    common.nix                  # Imports all HM modules, catppuccin config
    bat.nix                     # bat with catppuccin
    fzf.nix                     # fzf with pbcopy binding
    git.nix                     # git + delta + catppuccin
    ghostty.nix                 # ghostty (disabled)
    go.nix                      # Go toolchain + PATH
    lazygit.nix                 # lazygit + delta pager
    neovim.nix                  # neovim + LSP packages + lua config
    scripts.nix                 # deploys scripts to ~/.local/bin
    tmux.nix                    # tmux + TPM + catppuccin (nix module only)
    zsh.nix                     # zsh + oh-my-zsh (HM module) + syntax highlighting
  jon.schaeffer/fast-mac.nix    # HM entry for work machine
  jon/dl-mac.nix                # HM entry for personal laptop
  jon/home-mac.nix              # HM entry for home machine
```

### Package Management Split

**Managed by Nix (home-manager modules):**
bat, fzf, git, go, lazygit, neovim, tmux, zsh-syntax-highlighting

**Managed by Homebrew (all hosts via `hosts/common.nix`):**
bash, cfssl, dagger, gcc, gh, glib, helm, jq, k3d, k9s, kind, kube-ps1, kubecolor, kubectx, kubernetes-cli, kubeseal, minikube, ripgrep, sshpass, terraform, tilt, tree, vcluster, wget, yazi, yq, zoxide

**Managed by Homebrew (per-host):**
- fast-mac: colima, docker, docker-buildx, docker-compose, docker-credential-helper, gpg, infrahq/tap/infra
- dl-mac: age, ansible, flux, hugo, istioctl, python@3.12, qemu, sops, tailscale, tmux-fingers
- home-mac: age, flux, sops

---

## Remaining Notes

- `dl-mac.nix` and `home-mac.nix` (home-manager entries) are still identical — this is fine as a placeholder for future machine-specific HM config
- The `zoxide` integration is still manual (`eval "$(zoxide init --cmd cd zsh)"`) since it's a Homebrew-managed tool. Could be migrated to `programs.zoxide` HM module in the future
- Run `nix flake update` after these changes to refresh the lock file (the removed `nixos-hardware` input should be cleaned from `flake.lock`)
- After switching, run `prefix-I` in tmux to reinstall TPM plugins (the catppuccin TPM plugin was removed, but other plugins remain)
