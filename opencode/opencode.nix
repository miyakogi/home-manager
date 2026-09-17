{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  opencode2Pkgs = inputs.opencode2.packages.${system};
  # Upstream nix/hashes.json is stale at this pin; on bump, take the "got:"
  # hash from a failed `nix build github:anomalyco/opencode/<rev>#node_modules_updater`.
  opencode2 = opencode2Pkgs.default.overrideAttrs (old: {
    node_modules = old.node_modules.override {
      hash = "sha256-yzCk746pospz8EVakHRcDhYJkhGYGSt9dHOPbzO4OYo=";
    };
  });
in
{
  home.packages = [
    pkgs.opencode-desktop
  ];
  programs.opencode = {
    enable = true;
    # package = opencode2;
    settings = {
      default_agent = "plan";
      agent = {
        build = {
          model = "cline-pass/cline-pass/deepseek-v4.1-flash";
        };
        plan = {
          model = "cline-pass/cline-pass/deepseek-v4.1-flash";
        };
      };
      mcp = {
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
          headers = {
            CONTEXT7_API_KEY = "{env:CONTEXT7_API_KEY}";
          };
          enabled = true;
        };
        github = {
          type = "remote";
          url = "https://api.githubcopilot.com/mcp/";
          enabled = true;
          oauth = false;
          headers = {
            Authorization = "Bearer {env:GITHUB_PERSONAL_ACCESS_TOKEN}";
          };
        };
      };
    };
    tui = {
      theme = "system";
      mouse = true;
      attention = {
        enabled = true;
        notifications = true;
      };
    };
    context = builtins.readFile ../agents/AGENTS.md + "\n" + builtins.readFile ./superpowers.md;
  };
}
