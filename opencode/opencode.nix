{ pkgs, ... }: {
  home.packages = [
    pkgs.opencode-desktop
  ];
  programs.opencode = {
    enable = true;
    settings = {
      default_agent = "plan";
      mode = {
        build = {
          model = "cline-pass/cline-pass/deepseek-v4-flash";
        };
        plan = {
          model = "opencode/muse-spark-1.2-contributor-free";
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
      };
      plugin = [
        "superpowers@git+https://github.com/obra/superpowers.git"
      ];
    };
    tui = {
      theme = "system";
      mouse = true;
      attention = {
        enabled = true;
        notifications = true;
      };
    };
    context = ../agents/AGENTS.md;
  };
}
