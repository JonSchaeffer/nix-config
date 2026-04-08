# nix-config

## Machines

| Machine    | Username        | Purpose         |
| ---------- | --------------- | --------------- |
| `fast-mac` | `jon.schaeffer` | Work (Fastly)   |
| `dl-mac`   | `jon`           | Personal laptop |
| `home-mac` | `jon`           | Home machine    |

## Daily Usage

After making changes to this repo, apply them with both commands:

```sh
# System-level config (homebrew, system defaults, fonts, nix settings)
sudo darwin-rebuild switch --flake .#<machine>

# User-level config (zsh, git, tmux, neovim, bat, fzf, go, etc.)
home-manager switch --flake .#<user>@<machine>
```

### fast-mac (work)

```sh
sudo darwin-rebuild switch --flake .#fast-mac
home-manager switch --flake .#jon.schaeffer@fast-mac
```

### dl-mac (personal)

```sh
sudo darwin-rebuild switch --flake .#dl-mac
home-manager switch --flake .#jon@dl-mac
```

### home-mac (home)

```sh
sudo darwin-rebuild switch --flake .#home-mac
home-manager switch --flake .#jon@home-mac
```

### Update flake inputs

```sh
nix flake update
```

## Bootstrap a New Machine

1. Install Nix via Determinate Systems:

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

2. Create a basic darwin install to bootstrap nix-darwin:

```sh
sudo mkdir -p /etc/nix-darwin
sudo chown $(id -nu):$(id -ng) /etc/nix-darwin
cd /etc/nix-darwin

nix flake init -t nix-darwin/master

sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix
```

3. Install `nix-darwin`:

```sh
nix run nix-darwin/master#darwin-rebuild -- switch
```

4. Run `darwin-rebuild switch` to confirm it's installed. You may need to reopen your terminal.

5. Clone this repo to `~/`:

```sh
git clone <repo-url> ~/nix-config
cd ~/nix-config
```

6. In `flake.nix`, add a new `darwinConfigurations` entry, `homeConfiguration` entry, and ensure your user is listed (or add a new one).

7. In `hosts/`, create a new folder and `configuration.nix` that imports `../common.nix` and adds machine-specific homebrew packages.

8. In `home/<username>/`, add a `<hostname>.nix` file that imports `../modules/common.nix`.

9. Apply the config:

```sh
sudo darwin-rebuild switch --flake .#<machine>

nix-shell -p home-manager
home-manager switch --flake .#<user>@<machine>
```
