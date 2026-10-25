{ pkgs, ... }:
{
  home.packages = [
    pkgs.opencode-desktop
  ];
  programs.opencode = {
    enable = true;
    mutableSettings = true;
    settings = {
      default_agent = "plan";
    };
    cli = {
      theme.name = "system";
      mouse = true;
      animations = true;
      attention = {
        enabled = true;
        notifications = true;
      };
    };
    context = builtins.readFile ../agents/AGENTS.md + "\n" + builtins.readFile ./superpowers.md;
  };
}
