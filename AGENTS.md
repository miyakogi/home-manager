# AGENTS.md

Nix home-manager flake for user `miyaco` (NixOS, x86_64-linux). No CI, no tests — building is the only verification.

## Apply changes

- `home-manager switch --flake .#miyaco` from the repo root (creates the gitignored `result` symlink)

## Layout

- `home.nix` is the root module; each app has `dir/name.nix` listed in its `imports`
- `scripts/` is copied verbatim to `~/bin` (recursive, all executable) by `scripts.nix` — WM keybindings call these scripts by name
- `services/` holds systemd user services/timers deployed via `services.nix`
- `flakes/karukan/` is a local path flake input

## Gotchas

- `hypr/hyprland.lua` is the live Hyprland config (hypr3 lua plugin); `hypr/hyprland.conf` is unused legacy — never edit it
- Both Hyprland and Niri are configured, launched via uwsm, and share the same scripts

## Conventions

- Commit messages: `[area] lowercase imperative` in English, e.g. `[script] find next free workspace with jq`; `area` matches the app dir (script, hyprland, niri, waybar, rio, mpv, opencode, ...)
- Shell scripts: clean shellcheck warnings before committing; `is-4k` (in `~/bin`) reports whether the focused monitor is DP-1 for monitor-specific behavior
- Global preferences (language, commit approval, no `nix flake update`) are in `~/.config/opencode/AGENTS.md` — already loaded, not duplicated here
