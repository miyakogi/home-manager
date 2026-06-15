{ pkgs, inputs, ... }: {
  # home.packages = [
  #   pkgs.opencode-desktop
  # ];
  programs.opencode = {
    enable = true;
    settings = {
      default_agent = "plan";
    };
    tui = {
      theme = "opencode";
      mouse = true;
      attention = {
        enabled = true;
        notifications = true;
      };
    };
    context = ''
      # User Preferences

      ## Language

      Always respond in the same language the user used in their message.
      - If the user writes in Japanese, respond in Japanese.
      - If the user writes in English, respond in English.
      - If the user switches languages mid-conversation, follow the switch immediately.
    '';
  };
}
