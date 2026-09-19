{ pkgs, ... }:
{
  home.packages = [
    pkgs.opencode-desktop
  ];
  programs.opencode = {
    enable = true;
    settings = {
      default_agent = "plan";
      agent = {
        build = {
          model = "opencode/muse-spark-1.3-contributor-free";
        };
        plan = {
          model = "opencode/muse-spark-1.3-contributor-free";
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
