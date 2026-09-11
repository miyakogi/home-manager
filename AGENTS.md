# AGENTS.md

Nix home-manager flake for user `miyaco` (NixOS, x86_64-linux). No CI, no tests — building is the only verification.

## Apply changes

- `home-manager switch --flake .#miyaco` from the repo root (registers the generation under `~/.local/state/home-manager`; it does not create a `result` symlink)
- `home-manager build --flake .#miyaco` creates the gitignored `result` out-link when a stable path to the built generation is needed

## Layout

- `home.nix` is the root module; each app has `dir/name.nix` listed in its `imports`
- `scripts/` is copied verbatim to `~/bin` (recursive, all executable) by `scripts.nix` — WM keybindings call these scripts by name
- `services/services.nix` declares systemd user units (services/timers) via `systemd.user.*`
- `flakes/karukan/` is a local path flake input

## Gotchas

- Both Hyprland and Niri are configured, launched via uwsm, and share the same scripts
- Systemd user units are enabled declaratively (`.wants` live in the HM generation). `home-manager switch` runs sd-switch, so changed units are started/restarted/stopped automatically. `ollama.service` has no `Install` and is intentionally never auto-started.

## Conventions

- Commit messages: `[area] lowercase imperative` in English, e.g. `[script] find next free workspace with jq`; `area` matches the app dir (script, hyprland, niri, waybar, rio, mpv, opencode, ...)
- Formatting: run `nix fmt` on the `.nix` files you changed before committing (nixfmt via the flake `formatter`), e.g. `nix fmt $(git ls-files -m -o --exclude-standard -- '*.nix')`
- Shell scripts: clean shellharden warnings before committing; `is-4k` (in `~/bin`) reports whether the focused monitor is DP-1 for monitor-specific behavior
- Global preferences (language, commit approval, no `nix flake update`) are in `~/.config/opencode/AGENTS.md` — already loaded, not duplicated here
