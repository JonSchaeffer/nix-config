1. Install Nix Determinate System `curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install`

2. Create a basic darwin install to bootstrap nix-darwin.
```sh
sudo mkdir -p /etc/nix-darwin
sudo chown $(id -nu):$(id -ng) /etc/nix-darwin
cd /etc/nix-darwin

nix flake init -t nix-darwin/master

sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix
```
3. Install `nix-darwin` with: `nix run nix-darwin/master#darwin-rebuild -- switch`
4. Run `darwin-rebuild switch` to confirm `nix-darwin` is installed. Note: You may need to reopen your terminal to pick up the new binary.

5. Clone this repo to `~/`
6. `cd` to `nix-config`
7. In `flake.nix`, add a new `darwinConfigurations` entry, `homeConfiguration` entry, and ensure the user you want is listed (otherwise add a new one)
8. In `hosts/` create a new folder and configuration that matches the name of your machine.
9. In `home/` find your user (or create a new folder for your user) and add a `<host>.nix` file.
10. From `~/nix-config` run `darwin-rebuild switch --flake .#newmachine`
11. For home manager: 
```
nix-shell -p home-manager
home-manager switch --flake .#newuser@newmachine
```
