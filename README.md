# Home Manager configuration for `miyaco`

Nix [home-manager](https://github.com/nix-community/home-manager) flake for user `miyaco` on NixOS (x86_64-linux).

Personal configuration: dual window manager setup (Hyprland + Niri), Japanese IME (fcitx5 + karukan), and a set of WM-agnostic shell scripts.

## Overview

- **Dual window managers** — [Hyprland](https://hyprland.org/) (configured via the hypr3 Lua plugin in `hypr/hyprland.lua`) and [Niri](https://niri.dev/), both launched through [uwsm](https://github.com/Vladimir-csp/uwsm) and sharing the same scripts and services
- **Japanese input** — fcitx5 with [hazkey](https://github.com/aster-void/nix-hazkey) and [karukan](https://github.com/togatoga/karukan), a neural kana-kanji conversion IME, packaged as a local flake (`flakes/karukan`)
- **WM-agnostic scripts** — `scripts/` is installed verbatim to `~/bin`; window manager keybindings call these by name
- **Systemd user services** — per-WM Waybar and idle daemons (hypridle/swayidle), ollama, Taskwarrior notification timers
- **Many terminals configured** — alacritty, foot, kitty, ghostty, rio, wezterm

## Applying

```sh
git clone https://github.com/miyakogi/home-manager.git

home-manager switch --flake .#miyaco
```

> **Warning:** this configuration is optimized for my specific hardware and environment. It is not intended to be used as-is on a different machine, and I do not recommend doing so. Please do not copy it wholesale — treat it only as a reference and build your own setup from scratch.

## Structure

```
├── flake.nix           # flake entrypoint
├── home.nix            # root module (packages, imports)
├── scripts.nix         # installs scripts/ to ~/bin
├── services.nix        # systemd user services & timers
├── <app>/<app>.nix     # per-app home-manager modules
├── scripts/            # WM-agnostic shell scripts
├── services/           # systemd user units
└── flakes/karukan/     # local flake: karukan neural IME for fcitx5
```

`home.nix` imports each `dir/name.nix` module; per-app configuration lives in the corresponding directory.

## Highlights

- **Scripts shared by both WMs** — `terminal`, `launch-menu`, `screenshot`, `niri-workspace`, `hypr-addws`, `hypr-scratchterm`, `is-4k`, and more are called by name from both Hyprland and Niri keybindings
- **Taskwarrior notifications** — `tw-notify` / `tw-notify-daily` run on systemd timers and notify due tasks
- **Home-managed IME** — karukan is built from source via a local flake and wired into fcitx5 (see `flakes/karukan/flake.nix`)
- **Per-WM Waybar** — separate services (`waybar-hyprland.service`, `waybar-niri.service`) so the bar can restart without touching the other WM

## Keybindings

`Mod` is the Super key. Bindings below are representative; both WMs share the same scripts, but some details differ — see `hypr/hyprland.lua` and `niri/config.kdl` for the full lists.

| Keybind | Action |
| --- | --- |
| `Mod+Return` | Open terminal |
| `Mod+D` | App launcher (fuzzel) |
| `Mod+S` | Launch menu |
| `Mod+Space` | Notifications panel (swaync) |
| `F2` | Scratchpad terminal |
| `Mod+Q` / `Mod+W` | Close window (Hyprland) |
| `Mod+F` | Toggle fullscreen (Hyprland) |
| `Mod+Shift+F` | Toggle floating (Hyprland) |
| `Mod+E` / `Mod+T` | Toggle special workspace (memo / AI) |
| `Mod+1..9` | Switch to workspace |
| `Mod+Shift+1..9` | Move window to workspace |
| `Mod+O` / `Mod+P` | Previous / next workspace |
| `Mod+Shift+E` | Leave (session menu) |
| `Mod+Shift+R` | Restart Waybar |
| `Print` / `Shift+Print` / `Ctrl+Print` | Screenshot fullscreen / window / region |

## Included apps

Apps with dedicated configuration modules (not just installed packages):

- **Editors** — Neovim, Helix
- **Terminals** — alacritty, foot, kitty, ghostty, rio, wezterm
- **Shell & tools** — fish, starship, atuin, zoxide, zellij, yazi, gitui, lazygit, direnv, eza, bat, broot
- **UI** — waybar (custom build from flake input), quickshell, swaync, fuzzel, tofi, swappy
- **Media** — mpv
- **Development** — Rust toolchain (rustup, mold, cargo-llvm-cov), Node.js/pnpm, LSPs (ruff, pyright, lua-language-server, bash-language-server, typescript-language-server), hyperfine
- **AI** — ollama (Vulkan), pi-coding-agent, opencode
- **Other** — taskwarrior (with notification timers), capacities, QMK tooling

## License

[MIT](LICENSE)
